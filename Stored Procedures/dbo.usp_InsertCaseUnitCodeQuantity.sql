SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[usp_InsertCaseUnitCodeQuantity]
		@dtBegin DATETIME,	
		@reportYear SMALLINT
as
DECLARE @dtEndReg DATE=GETDATE()
CREATE TABLE #tmpCases
					(id INT,
					 DateRegistration DATETIME,
					 CodeM CHAR(6), 
					 rf_idCase bigint,
					 AmountPayment decimal(15,2),
					 DateEnd date,
					 rf_idV006 tinyint, 
					 Quantity INT,
					 UnitCode INT,
					 CodeSMO VARCHAR(5)
					 )
/*-------------------------------------------------------------------------------------------------------------------------------------------*/

SELECT MU,beginDate,endDate,unitCode,ChildUET,AdultUET INTO #tmpMU1 FROM RegisterCases.dbo.vw_sprMU WHERE unitCode IS NOT NULL AND calculationType=1
UNION ALL
SELECT CSGCode AS MU,beginDate,endDate,UnitCode,ChildUET, AdultUET FROM oms_nsi.dbo.vw_CSGPlanUnit WHERE unitCode IS NOT NULL AND calculationType=1

SELECT CSGCode AS MU,beginDate,endDate,UnitCode,ChildUET, AdultUET INTO #tmpMU2  FROM oms_nsi.dbo.vw_CSGPlanUnit WHERE unitCode IS NOT NULL AND calculationType=2
UNION ALL
SELECT MU,beginDate,endDate,unitCode,ChildUET,AdultUET  FROM RegisterCases.dbo.vw_sprMU WHERE unitCode IS NOT NULL AND calculationType=2

CREATE NONCLUSTERED INDEX IX_MU1 ON #tmpMU1(MU,beginDate,endDate) INCLUDE(ChildUET,AdultUET,unitCode)
CREATE NONCLUSTERED INDEX IX_MU2 ON #tmpMU2(MU,beginDate,endDate) INCLUDE(ChildUET,AdultUET,unitCode)

/*ЗС и КСГ*/
INSERT #tmpCases( id ,DateRegistration ,CodeM ,rf_idCase ,AmountPayment ,DateEnd ,rf_idV006 ,Quantity,UnitCode, CodeSMO)
SELECT f.id,f.DateRegistration,f.CodeM,c.id AS rf_idCase,c.AmountPayment, c.DateEnd,c.rf_idV006,
		CASE WHEN c.IsChildTariff=1 THEN m.Quantity*t1.ChildUET ELSE m.Quantity*t1.AdultUET END ,unitCode , a.rf_idSMO
FROM dbo.t_File f INNER JOIN dbo.t_RegistersAccounts a ON
			f.id=a.rf_idFiles
					INNER JOIN dbo.t_RecordCasePatient r ON
			a.id=r.rf_idRegistersAccounts					
					INNER JOIN dbo.t_Case c ON
			r.id=c.rf_idRecordCasePatient															
					INNER JOIN dbo.t_MES m ON
			c.id=m.rf_idCase            
					INNER JOIN #tmpMU1 t1  ON
		m.MES=t1.MU			
WHERE  f.DateRegistration>=@dtBegin AND f.DateRegistration<=@dtEndReg AND a.ReportYear>=@reportYear AND c.DateEnd>= t1.beginDate AND c.DateEnd<=t1.endDate
	AND NOT EXISTS(SELECT 1 FROM dbo.t_Case_UnitCode_V006 u WHERE u.rf_idCase=c.id AND u.UnitCode=t1.unitCode)

INSERT #tmpCases( id ,DateRegistration ,CodeM ,rf_idCase ,AmountPayment ,DateEnd ,rf_idV006 ,Quantity,UnitCode, CodeSMO)
SELECT f.id,f.DateRegistration,f.CodeM,c.id AS rf_idCase,c.AmountPayment, c.DateEnd,c.rf_idV006,1,unitCode, a.rf_idSMO
FROM dbo.t_File f INNER JOIN dbo.t_RegistersAccounts a ON
			f.id=a.rf_idFiles
					INNER JOIN dbo.t_RecordCasePatient r ON
			a.id=r.rf_idRegistersAccounts					
					INNER JOIN dbo.t_Case c ON
			r.id=c.rf_idRecordCasePatient															
					INNER JOIN dbo.t_MES m ON
			c.id=m.rf_idCase            
					INNER JOIN #tmpMU2 t1 ON
		m.MES=t1.MU			
WHERE f.DateRegistration>=@dtBegin AND f.DateRegistration<=@dtEndReg AND a.ReportYear>=@reportYear AND c.DateEnd>= t1.beginDate AND c.DateEnd<=t1.endDate
		AND NOT EXISTS(SELECT 1 FROM dbo.t_Case_UnitCode_V006 u WHERE u.rf_idCase=c.id AND u.UnitCode=t1.unitCode)
/*-------------------------------------------------------------------------------------------------------------------------------------------*/
/*Медуслуги*/
INSERT #tmpCases( id ,DateRegistration ,CodeM ,rf_idCase ,AmountPayment ,DateEnd ,rf_idV006 ,Quantity,UnitCode, CodeSMO)
SELECT f.id,f.DateRegistration,f.CodeM,c.id AS rf_idCase,c.AmountPayment, c.DateEnd,c.rf_idV006,
		CASE WHEN c.IsChildTariff=1 THEN m.Quantity*t1.ChildUET ELSE m.Quantity*t1.AdultUET END ,unitCode, a.rf_idSMO
FROM dbo.t_File f INNER JOIN dbo.t_RegistersAccounts a ON
			f.id=a.rf_idFiles
					INNER JOIN dbo.t_RecordCasePatient r ON
			a.id=r.rf_idRegistersAccounts					
					INNER JOIN dbo.t_Case c ON
			r.id=c.rf_idRecordCasePatient															
					INNER JOIN dbo.t_Meduslugi m ON
			c.id=m.rf_idCase            
					INNER JOIN RegisterCases.dbo.vw_sprMU t1 ON
		m.MU=t1.MU
		AND t1.unitCode IS NOT NULL
WHERE f.DateRegistration>=@dtBegin AND f.DateRegistration<=@dtEndReg AND a.ReportYear>=@reportYear AND c.DateEnd>= t1.beginDate AND c.DateEnd<=t1.endDate AND t1.calculationType=1
		AND NOT EXISTS(SELECT 1 FROM dbo.t_Case_UnitCode_V006 u WHERE u.rf_idCase=c.id AND u.UnitCode=t1.unitCode)

INSERT #tmpCases( id ,DateRegistration ,CodeM ,rf_idCase ,AmountPayment ,DateEnd ,rf_idV006 ,Quantity,UnitCode, CodeSMO)
SELECT f.id,f.DateRegistration,f.CodeM,c.id AS rf_idCase,c.AmountPayment, c.DateEnd,c.rf_idV006,1,unitCode, a.rf_idSMO
FROM dbo.t_File f INNER JOIN dbo.t_RegistersAccounts a ON
			f.id=a.rf_idFiles
					INNER JOIN dbo.t_RecordCasePatient r ON
			a.id=r.rf_idRegistersAccounts					
					INNER JOIN dbo.t_Case c ON
			r.id=c.rf_idRecordCasePatient															
					INNER JOIN dbo.t_Meduslugi m ON
			c.id=m.rf_idCase            
					INNER JOIN RegisterCases.dbo.vw_sprMU t1 ON
		m.MU=t1.MU			
		AND t1.unitCode IS NOT NULL
WHERE f.DateRegistration>=@dtBegin AND f.DateRegistration<=@dtEndReg AND a.ReportYear>=@reportYear AND c.DateEnd>= t1.beginDate AND c.DateEnd<=t1.endDate AND t1.calculationType=2
		AND NOT EXISTS(SELECT 1 FROM dbo.t_Case_UnitCode_V006 u WHERE u.rf_idCase=c.id AND u.UnitCode=t1.unitCode)

INSERT dbo.t_Case_UnitCode_V006( rf_idCase ,UnitCode ,V006,DateRegistration,CodeM,Qunatity)
SELECT rf_idCase, UnitCode,rf_idV006 ,DateRegistration ,CodeM,Quantity FROM #tmpCases

DELETE FROM dbo.t_Case_UnitCode_V006 
FROM dbo.t_Case_UnitCode_V006 c WHERE NOT EXISTS(SELECT * FROM dbo.t_Case cc WHERE c.rf_idCase=cc.id )

DROP TABLE #tmpCases
DROP TABLE #tmpMU1
DROP TABLE #tmpMU2
GO
