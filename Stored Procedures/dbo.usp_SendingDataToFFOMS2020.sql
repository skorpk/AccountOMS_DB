SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
---Таблица t_PaidCase и другие таблицы должны присутствовать на сервере
CREATE PROCEDURE [dbo].[usp_SendingDataToFFOMS2020]
		@reportYear SMALLINT,
		@dateStart DATETIME,--всегда с начало года берутся случаи
		@dateEnd DATE,		
		@dateStartPay DATETIME,--всегда с 10 числа отчетного месяца. В сентябре 2017 конечная дата изменилась, теперь нужно брать с 6 числа и по 10 число следующего месяца
		@dateEndPay DATETIME
AS
CREATE TABLE #tPeople(
					  rf_idCase BIGINT,					 
					  AmountPayment DECIMAL(11,2) NOT NULL DEFAULT(0), 
					  CodeM CHAR(6),
					  rf_idV006 TINYINT,
					  rf_idV002 SMALLINT,
					  DateBegin DATE,
					  DateEnd DATE,
					  AmountPaymentAccepted decimal(11,2),
					   AmountPaymentAcceptedZSL decimal(11,2),
					  rf_idDepartmentMO VARCHAR(6) ,					  
					  TypeCases TINYINT,
					  IDSP TINYINT
					  )
/*
09.02.2019
случаи оказания медицинской помощи в дневном стационаре, в которых применяется способ оплаты 33, за исключением случаев, в которых применяются следующие коды КСГ
*/
INSERT #tPeople( rf_idCase ,CodeM ,rf_idV006 ,rf_idV002,DateBegin,DateEnd, AmountPaymentAccepted,rf_idDepartmentMO,TypeCases,IDSP,AmountPaymentAcceptedZSL)
SELECT c.id,c.rf_idMO ,c.rf_idV006 ,c.rf_idV002, c.DateBegin,c.DateEnd,c.AmountPayment, CAST(c.rf_idDepartmentMO AS VARCHAR(6)), 9,c.rf_idV010,0.0
FROM dbo.t_Case c INNER JOIN dbo.t_CompletedCase cc ON
			c.rf_idRecordCasePatient=cc.rf_idRecordCasePatient                  
WHERE c.DateEnd>@dateStart AND c.DateEnd<@dateEnd AND NOT EXISTS(SELECT 1 FROM dbo.t_Meduslugi m WHERE m.MUGroupCode=60 AND m.MUUnGroupCode=3 AND m.rf_idCase=c.id)
	AND c.rf_idV010 =33 AND c.rf_idV006<3

/*
09.02.2019
- начиная с отчетного периода 2018 год случаи проведения заместительной почечной терапии в условиях стационара (USL_OK=1), 
дневного стационара (USL_OK=2) и амбулаторно (USL_OK=3): случаи, содержащие на уровне услуг хотя бы одну услугу с кодом группы 60.3.*, 
способ оплаты по данным случаям – 4 лечебно-диагностическая процедура или 33, или 28.
*/
	INSERT #tPeople( rf_idCase ,CodeM ,rf_idV006 ,rf_idV002,DateBegin,DateEnd, AmountPaymentAccepted,rf_idDepartmentMO,TypeCases,IDSP,AmountPaymentAcceptedZSL)
	SELECT distinct c.id,c.rf_idMO ,c.rf_idV006 ,c.rf_idV002, c.DateBegin,c.DateEnd,c.AmountPayment
			,CAST(c.rf_idDepartmentMO AS VARCHAR(6)), 10, c.rf_idV010, 0.0
	FROM dbo.t_Case c INNER JOIN dbo.t_Meduslugi m ON
			c.id=m.rf_idCase
						INNER JOIN dbo.t_CompletedCase cc ON
			c.rf_idRecordCasePatient=cc.rf_idRecordCasePatient
	WHERE c.rf_idV010 IN(33,28) AND c.rf_idV006<4 AND c.DateEnd>=@dateStart AND c.DateEnd<@dateEnd AND m.MUGroupCode=60 AND m.MUUnGroupCode=3--указан 43 способ оплаты т.к ДС оплачивается в основном по нем если есть КСГ
--END 
 
-----снятия смотрим по законченному случаю
UPDATE p SET p.AmountPaymentAcceptedZSL=p.AmountPaymentAccepted-r.AmountDeduction
FROM #tPeople p INNER JOIN (
							SELECT t.rf_idCase,SUM(p.AmountDeduction) AS AmountDeduction
							FROM dbo.t_PaymentAcceptedCase2 p INNER  JOIN #tPeople t ON			
												p.rf_idCase=t.rf_idCase
							WHERE p.DateRegistration>=@dateStartPay AND p.DateRegistration<@dateEndPay	 
							GROUP BY t.rf_idCase
							) r ON
			p.rf_idCase=r.rf_idCase

--------------------------------------------------------------------------------------------------------------------------
SELECT rf_idCase,p.DateBegin,p.DateEnd
	,CASE WHEN p.rf_idDepartmentMO IS NULL THEN p.CodeM+'.'+CAST(p.rf_idV006 AS VARCHAR(3))+'.'+CAST(p.rf_idV002 AS VARCHAR(5))
			ELSE p.CodeM+'.'+p.rf_idDepartmentMO+'.'+CAST(p.rf_idV006 AS VARCHAR(3)) END AS UnitOfHospital
	,TypeCases,IDSP, AmountPaymentAcceptedZSL
INTO #UnitOfHosp
FROM #tPeople p 
WHERE AmountPaymentAcceptedZSL>0

SELECT DISTINCT m1.rf_idCase,MUSurgery,id ,cs.[Код КСГ] AS CodeCSG
INTO #MU1
FROM #UnitOfHosp u inner JOIN dbo.t_Meduslugi m1 ON
				u.rf_idCase=m1.rf_idCase
				INNER JOIN oms_NSI.dbo.sprNomenclMUCSGview cs ON
				m1.MUSurgery =cs.codeNomenclMU   
WHERE m1.DateHelpEnd>'20191231'  
CREATE NONCLUSTERED INDEX ix_MU1 ON #MU1(rf_idCase) INCLUDE(MUSurgery,id)

SELECT * INTO #csg FROM vw_sprCSG WHERE dateBeg>'20191231' AND dateEnd<'22220101'


SELECT DISTINCT c.id AS rf_idCase,c.rf_idMO AS CodeM,a.rf_idMO,a.ReportMonth,a.ReportYear,r.rf_idF008,c.rf_idV006,r.SeriaPolis,r.NumberPolis,p.BirthDay,p.rf_idV005
		,c.idRecordCase,c.rf_idV014,u.UnitOfHospital,c.DateBegin,c.DateEnd,
		d.DS1, d.DS2, d.DS3,c.rf_idV009
		,m.MES,0 AS IsDelete
		,c.AmountPayment,mu.id AS idMU, mu.MUSurgery
		,c.Age,CASE WHEN c.Age>0 AND c.Age<4 THEN 4
					WHEN c.age>3 AND c.Age<18 THEN 5
					WHEN c.Age>17 AND c.Age<60 THEN 6
					WHEN c.Age>59 AND c.Age<75 THEN 7
					WHEN c.Age>74 THEN 8
					WHEN c.Age=0 AND DATEDIFF(DAY,p.BirthDay,c.DateBegin)>28 AND DATEDIFF(DAY,p.BirthDay,c.DateBegin)<91 THEN 2
					WHEN c.Age=0 AND DATEDIFF(DAY,p.BirthDay,c.DateBegin)>90 THEN 3
					WHEN c.Age=0 AND DATEDIFF(DAY,p.BirthDay,c.DateBegin)<29 THEN 1
				/*ELSE 3*/ END AS VZST
		,MES AS K_KSG--CASE WHEN csg.codePGR IS NOT NULL THEN csg.codePGR ELSE csg.codeMinZdrav END AS K_KSG
		,CASE WHEN csg.codePGR IS NOT NULL THEN 1 ELSE 0 END AS KSG_PG
		,c.IT_SL,ps.ENP,TypeCases, NULL AS Quantity, NULL AS TotalPriceMU, csg.NoLevelCoefficient AS UR_K
		,cc.AmountPayment AS AmountPaymentZSL,u.IDSP
INTO #tCases
FROM #UnitOfHosp u INNER JOIN dbo.t_Case c ON
		u.rf_idCase=c.id
					INNER JOIN dbo.t_RecordCasePatient r ON
		r.id=c.rf_idRecordCasePatient
					INNER JOIN dbo.t_CompletedCase cc ON
			r.id=cc.rf_idRecordCasePatient
					INNER JOIN dbo.t_RegistersAccounts a ON
		a.id=r.rf_idRegistersAccounts					                  
					INNER JOIN dbo.t_RegisterPatient p ON --vw_RegisterPatient
		r.id=p.rf_idRecordCase                 
					INNER JOIN dbo.vw_Diagnosis d ON 
		c.id=d.rf_idCase
					INNER JOIN dbo.t_MES m ON
		c.id=m.rf_idCase
					INNER JOIN #csg csg ON
		m.MES=csg.code		
		AND cc.DateEnd BETWEEN csg.dateBeg AND csg.dateEnd
					INNER JOIN dbo.t_PatientSMO ps ON
		r.id=ps.rf_idRecordCasePatient                  
				LEFT JOIN  #MU1 mu ON
		c.id=mu.rf_idCase     
WHERE TypeCases=9 
--UNION ALL
INSERT #tCases
SELECT DISTINCT c.id AS rf_idCase,c.rf_idMO AS CodeM,a.rf_idMO,a.ReportMonth,a.ReportYear,r.rf_idF008,c.rf_idV006,r.SeriaPolis,r.NumberPolis,p.BirthDay,p.rf_idV005
		,c.idRecordCase,c.rf_idV014,u.UnitOfHospital,c.DateBegin,c.DateEnd,
		d.DS1, d.DS2, d.DS3,c.rf_idV009
		,mes.MES AS MES,0 IsDelete--не учитываются случаи реабилитации
		,c.AmountPayment,m.id AS idMU
		,m.MUSurgery ---2020-04-16
		,c.Age,CASE WHEN c.Age>0 AND c.Age<4 THEN 4
					WHEN c.age>3 AND c.Age<18 THEN 5
					WHEN c.Age>17 AND c.Age<60 THEN 6
					WHEN c.Age>59 AND c.Age<75 THEN 7
					WHEN c.Age>74 THEN 8
					WHEN c.Age=0 AND DATEDIFF(DAY,p.BirthDay,c.DateBegin)>28 AND DATEDIFF(DAY,p.BirthDay,c.DateBegin)<91 THEN 2
					WHEN c.Age=0 AND DATEDIFF(DAY,p.BirthDay,c.DateBegin)>90 THEN 3
					WHEN c.Age=0 AND DATEDIFF(DAY,p.BirthDay,c.DateBegin)<29 THEN 1
				/*ELSE 3*/ END AS VZST
		,CASE WHEN IDSP IN(4,28) THEN 'DIAL' ELSE NULL END AS K_KSG
		,0 AS KSG_PG
		,c.IT_SL,ps.ENP,TypeCases,CAST(m.Quantity AS INT) AS Quantity, m.TotalPrice,ISNULL(NULL,0) AS NoLevelCoefficient
		,cc.AmountPayment AS AmountPaymentZSL,u.IDSP
FROM #UnitOfHosp u INNER JOIN dbo.t_Case c ON
		u.rf_idCase=c.id
					INNER JOIN dbo.t_RecordCasePatient r ON
		r.id=c.rf_idRecordCasePatient
					INNER JOIN dbo.t_CompletedCase cc ON
			r.id=cc.rf_idRecordCasePatient
					INNER JOIN dbo.t_RegistersAccounts a ON
		a.id=r.rf_idRegistersAccounts					                  
					INNER JOIN dbo.t_RegisterPatient p ON --vw_RegisterPatient
		r.id=p.rf_idRecordCase                 					
					INNER JOIN dbo.vw_Diagnosis d ON 
		c.id=d.rf_idCase										
					INNER JOIN dbo.t_PatientSMO ps ON
		r.id=ps.rf_idRecordCasePatient                  
					INNER JOIN dbo.t_Meduslugi m ON
		c.id=m.rf_idCase     		                 
					LEFT JOIN t_Mes mes ON
		c.id=mes.rf_idCase
		AND mes.TypeMES=2        
WHERE TypeCases=10 AND IDSP =28	 AND m.MUGroupCode=60 AND m.MUUnGroupCode=3/*сюда отбор случаев у которых не должно быть VID_VME ксгшных. Но таких нету т.к медуслуги мы заменяем*/
--UNION ALL
UNION ALL
SELECT DISTINCT c.id AS rf_idCase,c.rf_idMO AS CodeM,a.rf_idMO,a.ReportMonth,a.ReportYear,r.rf_idF008,c.rf_idV006,r.SeriaPolis,r.NumberPolis,p.BirthDay,p.rf_idV005
		,c.idRecordCase,c.rf_idV014,u.UnitOfHospital,c.DateBegin,c.DateEnd,
		d.DS1, d.DS2, d.DS3,c.rf_idV009
		,mes.MES AS MES,0 IsDelete--не учитываются случаи реабилитации
		,c.AmountPayment,m.id AS idMU
		,m.MUSurgery--2020-04-16
		,c.Age,CASE WHEN c.Age>0 AND c.Age<4 THEN 4
					WHEN c.age>3 AND c.Age<18 THEN 5
					WHEN c.Age>17 AND c.Age<60 THEN 6
					WHEN c.Age>59 AND c.Age<75 THEN 7
					WHEN c.Age>74 THEN 8
					WHEN c.Age=0 AND DATEDIFF(DAY,p.BirthDay,c.DateBegin)>28 AND DATEDIFF(DAY,p.BirthDay,c.DateBegin)<91 THEN 2
					WHEN c.Age=0 AND DATEDIFF(DAY,p.BirthDay,c.DateBegin)>90 THEN 3
					WHEN c.Age=0 AND DATEDIFF(DAY,p.BirthDay,c.DateBegin)<29 THEN 1
				/*ELSE 3*/ END AS VZST		
		,MES AS K_KSG--CASE WHEN csg.codePGR IS NOT NULL THEN csg.codePGR ELSE csg.codeMinZdrav END AS K_KSG
		,CASE WHEN csg.codePGR IS NOT NULL THEN 1 ELSE 0 END AS KSG_PG
		,c.IT_SL,ps.ENP,TypeCases,CAST(m.Quantity AS INT) AS Quantity, m.TotalPrice,ISNULL(NULL,0) AS NoLevelCoefficient
		,cc.AmountPayment AS AmountPaymentZSL,u.IDSP
FROM #UnitOfHosp u INNER JOIN dbo.t_Case c ON
		u.rf_idCase=c.id
					INNER JOIN dbo.t_RecordCasePatient r ON
		r.id=c.rf_idRecordCasePatient
					INNER JOIN dbo.t_CompletedCase cc ON
			r.id=cc.rf_idRecordCasePatient
					INNER JOIN dbo.t_RegistersAccounts a ON
		a.id=r.rf_idRegistersAccounts					                  
					INNER JOIN dbo.t_RegisterPatient p ON --vw_RegisterPatient
		r.id=p.rf_idRecordCase                 					
					INNER JOIN dbo.vw_Diagnosis d ON 
		c.id=d.rf_idCase										
					INNER JOIN dbo.t_PatientSMO ps ON
		r.id=ps.rf_idRecordCasePatient                  
					INNER JOIN (SELECT DISTINCT rf_idCase,MUSurgery,id ,cs.[Код КСГ] AS CodeCSG,m1.MUGroupCode,m1.MUUnGroupCode,m1.Quantity,m1.TotalPrice
								FROM dbo.t_Meduslugi m1 left JOIN oms_NSI.dbo.sprNomenclMUCSGview cs ON
											m1.MUSurgery =cs.codeNomenclMU
                                WHERE m1.MUGroupCode=60 AND m1.MUUnGroupCode=3	AND m1.DateHelpEnd>'20191231'                                                                             
							  ) m ON
		c.id=m.rf_idCase     		                    
					INNER JOIN t_Mes mes ON
		c.id=mes.rf_idCase
		AND mes.TypeMES=2 
					INNER JOIN #csg csg ON
		mes.MES=csg.code					
		AND cc.DateEnd BETWEEN csg.dateBeg AND csg.dateEnd	   
WHERE TypeCases=10 AND IDSP=33            
---------------------------Берем услуги у которыг VID_VME есть для диализа, но которые не диализ---------------------------------------
 --UNION 
 INSERT #tCases
SELECT DISTINCT c.id AS rf_idCase,c.rf_idMO AS CodeM,a.rf_idMO,a.ReportMonth,a.ReportYear,r.rf_idF008,c.rf_idV006,r.SeriaPolis,r.NumberPolis,p.BirthDay,p.rf_idV005
		,c.idRecordCase,c.rf_idV014,u.UnitOfHospital,c.DateBegin,c.DateEnd,
		d.DS1, d.DS2, d.DS3,c.rf_idV009
		,mes.MES AS MES,0 IsDelete--не учитываются случаи реабилитации
		,c.AmountPayment,mu1.id AS idMU, mu1.MUSurgery
		,c.Age,CASE WHEN c.Age>0 AND c.Age<4 THEN 4
					WHEN c.age>3 AND c.Age<18 THEN 5
					WHEN c.Age>17 AND c.Age<60 THEN 6
					WHEN c.Age>59 AND c.Age<75 THEN 7
					WHEN c.Age>74 THEN 8
					WHEN c.Age=0 AND DATEDIFF(DAY,p.BirthDay,c.DateBegin)>28 AND DATEDIFF(DAY,p.BirthDay,c.DateBegin)<91 THEN 2
					WHEN c.Age=0 AND DATEDIFF(DAY,p.BirthDay,c.DateBegin)>90 THEN 3
					WHEN c.Age=0 AND DATEDIFF(DAY,p.BirthDay,c.DateBegin)<29 THEN 1
				/*ELSE 3*/ END AS VZST		
		,MES AS K_KSG--CASE WHEN csg.codePGR IS NOT NULL THEN csg.codePGR ELSE csg.codeMinZdrav END AS K_KSG
		,CASE WHEN csg.codePGR IS NOT NULL THEN 1 ELSE 0 END AS KSG_PG
		,c.IT_SL,ps.ENP,TypeCases,/*NULL*/CAST(mu1.Quantity AS INT)  AS Quantity, mu1.TotalPrice/*NULL*/,ISNULL(NULL,0) AS NoLevelCoefficient
		,cc.AmountPayment AS AmountPaymentZSL,u.IDSP
FROM #UnitOfHosp u INNER JOIN dbo.t_Case c ON
		u.rf_idCase=c.id
					INNER JOIN dbo.t_RecordCasePatient r ON
		r.id=c.rf_idRecordCasePatient
					INNER JOIN dbo.t_CompletedCase cc ON
			r.id=cc.rf_idRecordCasePatient
					INNER JOIN dbo.t_RegistersAccounts a ON
		a.id=r.rf_idRegistersAccounts					                  
					INNER JOIN dbo.t_RegisterPatient p ON --vw_RegisterPatient
		r.id=p.rf_idRecordCase                 					
					INNER JOIN dbo.vw_Diagnosis d ON 
		c.id=d.rf_idCase										
					INNER JOIN dbo.t_PatientSMO ps ON
		r.id=ps.rf_idRecordCasePatient                 
					 					                      
					INNER JOIN t_Mes mes ON
		c.id=mes.rf_idCase
		AND mes.TypeMES=2 
					INNER JOIN #csg csg ON
		mes.MES=csg.code	
		AND cc.DateEnd BETWEEN csg.dateBeg AND csg.dateEnd
					INNER JOIN 
					(SELECT DISTINCT rf_idCase,MUSurgery,id ,cs.[Код КСГ] AS CodeCSG,m1.Quantity,m1.TotalPrice
					 FROM dbo.t_Meduslugi m1 INNER JOIN oms_NSI.dbo.sprNomenclMUCSGview cs ON
											m1.MUSurgery =cs.codeNomenclMU
						WHERE m1.MUInt=0 and m1.DateHelpEnd>'20191231'                                                     
					) mu1 ON
		c.id=mu1.rf_idCase       
		AND mes=mu1.CodeCSG
		AND mu1.MUSurgery IS NOT NULL		
WHERE TypeCases=10 AND IDSP=33	AND EXISTS(SELECT 1 FROM  dbo.t_Meduslugi m WHERE c.id=m.rf_idCase AND m.MUGroupCode=60 AND m.MUUnGroupCode=3 )
--)
INSERT dbo.t_SendingDataIntoFFOMS( id ,rf_idCase ,CodeM ,rf_idMO ,ReportMonth ,ReportYear ,rf_idF008 ,rf_idV006 ,SeriaPolis ,NumberPolis ,BirthDay ,
          rf_idV005 ,idRecordCase ,rf_idV014 ,UnitOfHospital ,DateBegin ,DateEnd ,DS1 ,DS2 ,DS3 ,rf_idV009 ,MES ,AmountPayment ,idMU ,MUSurgery ,
          Age ,VZST ,K_KSG ,KSG_PG ,PVT ,IsDisableCheck,IT_SL, ENP, TypeCases, Quantity, TotalPriceMU, UR_K,IDSP, AmountPaymentZSL,DateInsert,IsFullDoubleDate) 
SELECT  DENSE_RANK() OVER(ORDER BY rf_idCase ,ReportYear,ReportMonth) AS id, rf_idCase ,CodeM ,rf_idMO ,CAST(MONTH(@dateStartPay) AS TINYINT) AS ReportMonth 
		,CAST(YEAR(@dateStart) AS SMALLINT) AS ReportYear,
        rf_idF008 ,rf_idV006 ,SeriaPolis ,NumberPolis ,BirthDay ,rf_idV005 ,idRecordCase ,rf_idV014 ,UnitOfHospital ,
        DateBegin ,DateEnd ,DS1 ,DS2 ,DS3 ,rf_idV009 ,MES ,AmountPayment ,idMU ,MUSurgery ,Age ,VZST ,K_KSG ,KSG_PG,0 PVT,0 AS IsDisableCheck,IT_SL,ENP,TypeCases,Quantity
		,TotalPriceMU, UR_K,IDSP,AmountPaymentZSL, GETDATE(),0
FROM #tCases c
WHERE IsDelete=0 AND NOT EXISTS(SELECT * FROM dbo.t_SendingDataIntoFFOMS WHERE rf_idCase=c.rf_idCase)--включение случая происходит только один раз
	
--------------------------------------------------------------------------------------------------------------------------
DROP TABLE #tPeople
DROP TABLE #MU1
DROP TABLE #UnitOfHosp
DROP TABLE #tCases
DROP TABLE #csg	
--------------------------------------------------------------------------------------------------------------------------
----перекодировка символов DS2 и DS3
UPDATE f SET f.DS2=v.DS_T
FROM dbo.t_SendingDataIntoFFOMS f INNER JOIN dbo.t_DS_Recode v ON
					ISNULL(f.DS2,'bla-bla')=v.DS_w
WHERE ReportYear>=2018 AND IsUnload=0
UPDATE f SET f.DS3=v.DS_T
FROM dbo.t_SendingDataIntoFFOMS f INNER JOIN dbo.t_DS_Recode v ON
					ISNULL(f.DS3,'bla-bla')=v.DS_w
WHERE ReportYear>=2018 AND IsUnload=0
UPDATE f SET f.DS1=v.DS_T
FROM dbo.t_SendingDataIntoFFOMS f INNER JOIN dbo.t_DS_Recode v ON
					f.DS1=v.DS_w
WHERE reportYear>=2018 AND IsUnload=0

UPDATE dbo.t_SendingDataIntoFFOMS SET DS1='M45' WHERE DS1 LIKE 'M45.%' AND ReportYear>=2018
UPDATE dbo.t_SendingDataIntoFFOMS SET DS2='M45' WHERE DS2 LIKE 'M45.%' AND ReportYear>=2018

UPDATE dbo.t_SendingDataIntoFFOMS SET DS1='J47' WHERE DS1='J47.0' AND ReportYear>=2018
UPDATE dbo.t_SendingDataIntoFFOMS SET DS1='M43.8' WHERE DS1='M43.83' AND ReportYear>=2018
UPDATE dbo.t_SendingDataIntoFFOMS SET DS2='M43.8' WHERE DS2='M43.83' AND ReportYear>=2018

UPDATE dbo.t_SendingDataIntoFFOMS SET MUSurgery=NULL, idMU=NULL
WHERE MUSurgery IN ('B03.001.002','B03.001.003','B03.003.005')

UPDATE f SET f.MUSurgery=NULL, f.idMU=NULL
FROM dbo.t_SendingDataIntoFFOMS f INNER JOIN oms_NSI.dbo.v001 v1 ON
				f.MUSurgery=v1.IDRB
WHERE v1.isTelemedicine=1


--UPDATE s SET s.MUSurgery=v.MU
--FROM dbo.t_SendingDataIntoFFOMS s INNER JOIN (VALUES ('B01.001.006.001','B01.001.006'),('B01.001.009.001','B01.001.009 '),('A11.20.025','A11.20.027')) v(MU_E, MU) ON
--			s.MUSurgery=v.MU_E

DROP TABLE #tPeople
GO
