SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

create PROCEDURE [dbo].[usp_CalculationPVT_FFOMS2020_old]
as
--Для всех случаев с IDSP=4 или 28 PVT заполняется 0 и все эти случаи исключаются из дальнейшего рассмотрения
UPDATE s SET IsDisableCheck=1 FROM dbo.t_SendingDataIntoFFOMS s WHERE IDSP =28
/*
Из процедуры определения признака повторности лечения для случаев оказания медицинской помощи в стационарных условиях и в условиях дневного стационара (раздельно для каждого условия) 
исключаются все случаи, имеющие в качестве основного диагноза на уровне случая любой из кодов рубрики O (лат.) 
*/
UPDATE s SET IsDisableCheck=1 FROM dbo.t_SendingDataIntoFFOMS s WHERE DS1 LIKE 'O%' AND ReportMonth>4 AND ReportYear>2019
--версия в которой заменил IDPeople на ЕНП
;WITH doubleDS
AS(
  SELECT rf_idCase,ENP,DS1,DateBegin, DateEnd,rf_idV006
  FROM t_SendingDataIntoFFOMS 
  WHERE PVT=0 AND IsUnload=0
  GROUP BY rf_idCase,ENP,DS1,DateBegin,DateEnd,rf_idV006
),PVT3 as (SELECT s.ENP,s.DS1,d.dateBegin,d.DateEnd,d.rf_idV006
			   FROM doubleDS d INNER JOIN (SELECT DISTINCT rf_idCase,ENP,DS1,DateBegin,DateEnd,rf_idV006 FROM  dbo.t_SendingDataIntoFFOMS WHERE IsUnload=0) s ON	
					d.ENP=s.ENP
					AND d.DS1=s.DS1
					AND d.dateBegin=s.DateBegin		
					AND d.DateEnd=s.DateEnd
					AND d.rf_idV006=s.rf_idV006
				GROUP BY s.ENP,s.DS1,d.dateBegin,d.DateEnd,d.rf_idV006
				HAVING COUNT(*)>1)

UPDATE s SET s.IsFullDoubleDate=1--,s.IsUnload=1
FROM PVT3 d INNER JOIN dbo.t_SendingDataIntoFFOMS s ON	
					d.ENP=s.ENP
					AND d.DS1=s.DS1
					AND d.dateBegin=s.DateBegin
					AND d.DateEnd=s.DateEnd
					AND d.rf_idV006=s.rf_idV006
WHERE IsUnload=0
---------------------------------------------------------------------------------------------------------------------
--выполняется только после того как исключили записи отвергнутые экспертами
--Step 1 Простовляю IsDisableCheck=1 для курсовой реабилитации, что бы не учитывать ее в дальнейшем
UPDATE s SET IsDisableCheck=1
FROM dbo.t_SendingDataIntoFFOMS s INNER JOIN dbo.sprCSGDisableCheck v ON
			              s.MES=v.csgCode
						  AND s.ReportYear=v.ReportYear

 ---------------------------------------------------------------------------------------------------------------------
--Убираем случаи из выборки у которых DateBegin=DateEnd и результат обращения равен 102
UPDATE dbo.t_SendingDataIntoFFOMS SET IsDisableCheck=1 WHERE DateBegin=DateEnd AND rf_idV009=102 AND IsUnload=0

/*Step  определяем PVT=1 или PVT=2. Исключая случаи с курсовой реабилитацией и не учитываем случаи с IsFullDoubleDate=0
Расчитывать нужно ЗМЕ и на тех записях которые отдали в ФФОМС
получаем так называемый первый случай из всего списка лечения
*/
DECLARE @reportYear SMALLINT=2018

;WITH doubleCase
AS(
	SELECT rf_idCase,ENP,DS1,rf_idV006 
	FROM t_SendingDataIntoFFOMS 
	WHERE PVT=0  AND IsDisableCheck=0 AND IsFullDoubleDate=0 AND ReportYear=@reportYear
	GROUP BY rf_idCase,ENP,DS1,rf_idV006
),doubleDS as(SELECT ENP,DS1,rf_idV006 FROM doubleCase GROUP BY ENP,DS1,rf_idV006 HAVING COUNT(*)>1), 
cteMin AS (SELECT TOP 1 WITH TIES d.ENP,d.DS1,DateBegin AS MinDateBegin,s.rf_idV006
			FROM doubleDS d INNER JOIN dbo.t_SendingDataIntoFFOMS s ON	
					d.ENP=s.ENP
					AND d.DS1=s.DS1
					AND d.rf_idV006=s.rf_idV006
			WHERE s.IsDisableCheck=0 AND s.IsFullDoubleDate=0 AND ReportYear=@reportYear
			ORDER BY ROW_NUMBER() OVER(PARTITION BY d.ENP,d.DS1,s.rf_idV006 ORDER BY DateBegin,DateEnd)
			
			)
SELECT  d.ENP, d.DS1,s.DateEnd,rf_idCase,s.rf_idV006
INTO #tmpDateBeg
FROM cteMin d INNER JOIN dbo.t_SendingDataIntoFFOMS s ON	
					d.ENP=s.ENP
					AND d.DS1=s.DS1
					AND d.MinDateBegin=s.DateBegin
					AND d.rf_idV006=s.rf_idV006
WHERE s.IsDisableCheck=0 AND s.IsFullDoubleDate=0 AND ReportYear=@reportYear
GROUP BY d.ENP, d.DS1,s.DateEnd,rf_idCase,s.rf_idV006
PRINT ('create #tmpDateBeg')
-----------------------------------------------------------------------------------------------------------------------
--второй этап. Необходимо проставить PVT только для новых случаев, но пока что это не точно.

SELECT distinct ROW_NUMBER() OVER(PARTITION BY d.ENP,d.DS1,d.rf_idV006 ORDER BY s.DateBegin,s.DateEnd) AS id,
		 s.rf_idCase, s.ENP,s.DS1,s.DateBegin,s.DateEnd,s.rf_idV006			 	
INTO #t1
FROM #tmpDateBeg d inner JOIN (SELECT DISTINCT ENP,DS1,DateBegin,DateEnd,rf_idCase,s.rf_idV006
							   from dbo.t_SendingDataIntoFFOMS s
							   WHERE s.IsFullDoubleDate=0 AND ReportYear=@reportYear) s ON	
		d.ENP=s.ENP
		AND d.DS1=s.DS1	
		AND d.rf_idV006=s.rf_idV006

SELECT s.rf_idCase,(CASE WHEN DATEDIFF(d,c1.DateEnd,c2.DateBegin)>0 AND DATEDIFF(d,c1.DateEnd,c2.DateBegin)+1<=30 THEN 1 ELSE 0 END ) AS PVT
INTO #tt
from #t1 c1 inner JOIN #t1 c2 ON
		c1.ENP=c2.ENP
		AND c1.DS1=c2.DS1
		AND c1.id+1=c2.id
		AND c1.rf_idV006=c2.rf_idV006
				INNER JOIN dbo.t_SendingDataIntoFFOMS s ON
		c2.rf_idCase=s.rf_idCase 
		AND c2.rf_idV006=s.rf_idV006
WHERE IsDisableCheck=0 AND s.IsFullDoubleDate=0	AND IsUnload=0	

UPDATE s SET s.PVT=T.PVT
FROM dbo.t_SendingDataIntoFFOMS s INNER JOIN #tt t ON	
			s.rf_idCase=t.rf_idCase


DROP TABLE #tmpDateBeg
DROP TABLE #tt

GO
