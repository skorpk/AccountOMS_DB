SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


CREATE PROCEDURE [dbo].[usp_CalculationPVT_FFOMS2020]
AS
--Для всех случаев с IDSP=4 или 28 PVT заполняется 0 и все эти случаи исключаются из дальнейшего рассмотрения
UPDATE s SET IsDisableCheck=1 FROM dbo.t_SendingDataIntoFFOMS s WHERE IDSP =28
/*
Из процедуры определения признака повторности лечения для случаев оказания медицинской помощи в стационарных условиях и в условиях дневного стационара (раздельно для каждого условия) 
исключаются все случаи, имеющие в качестве основного диагноза на уровне случая любой из кодов рубрики O (лат.) 
*/
UPDATE s SET IsDisableCheck=1 FROM dbo.t_SendingDataIntoFFOMS s WHERE DS1 LIKE 'O%' AND ReportMonth>4 AND ReportYear>2019
--версия в которой заменил IDPeople на ЕНП

SELECT rf_idCase,ENP,DS1,DateBegin, DateEnd,rf_idV006
INTO #doubleDS
FROM t_SendingDataIntoFFOMS 
WHERE PVT=0 AND IsUnload=0
GROUP BY rf_idCase,ENP,DS1,DateBegin,DateEnd,rf_idV006

SELECT s.ENP,s.DS1,d.dateBegin,d.DateEnd,d.rf_idV006
INTO #PVT3
FROM #doubleDS d INNER JOIN (SELECT DISTINCT rf_idCase,ENP,DS1,DateBegin,DateEnd,rf_idV006 FROM  dbo.t_SendingDataIntoFFOMS WHERE IsUnload=0) s ON	
	d.ENP=s.ENP
	AND d.DS1=s.DS1
	AND d.dateBegin=s.DateBegin		
	AND d.DateEnd=s.DateEnd
	AND d.rf_idV006=s.rf_idV006
GROUP BY s.ENP,s.DS1,d.dateBegin,d.DateEnd,d.rf_idV006
HAVING COUNT(*)>1

UPDATE s SET s.IsFullDoubleDate=1--,s.IsUnload=1
FROM #PVT3 d INNER JOIN dbo.t_SendingDataIntoFFOMS s ON	
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



GO
