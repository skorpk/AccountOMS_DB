SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[usp_selectReport_CancerRegistr]
		@dateStartReg DATETIME,
		@dateEndReg DATETIME,
		@reportYearStart SMALLINT,
		@reportYearEnd SMALLINT,
		@reportMonthStart TINYINT,
		@reportMonthEnd TINYINT
as
declare	@dateStart DATE,
		@dateEnd DATE
	

set @dateStart=CAST(@reportYearStart AS CHAR(4))+RIGHT('0'+CAST(@reportMonthStart AS VARCHAR(2)),2)+'01'
set	@dateEnd=DATEADD(MONTH,1,CAST((CAST(@reportYearEnd AS CHAR(4))+RIGHT('0'+CAST(@reportMonthEnd AS VARCHAR(2)),2)+'01') AS DATE))

DECLARE @startPeriod INT=CAST(CAST(@reportYearStart AS VARCHAR(4))+RIGHT('0'+CAST(@reportMonthStart AS VARCHAR(2)),2) AS INT),
		@endPeriod int=CAST(CAST(@reportYearEnd AS VARCHAR(4))+RIGHT('0'+CAST(@reportMonthEnd AS VARCHAR(2)),2) AS INT)

CREATE TABLE #tmpCases(ENP VARCHAR(16),rf_idCase BIGINT, pid int)
--SELECT @startPeriod,@endPeriod,@dateStart,@dateEnd
INSERT #tmpCases( ENP, rf_idCase,pid)
SELECT ps.ENP,c.id,p.id
FROM AccountOMS.dbo.t_File f INNER JOIN AccountOMS.dbo.t_RegistersAccounts a ON
			f.id=a.rf_idFiles
					INNER JOIN AccountOMS.dbo.t_RecordCasePatient r ON
			a.id=r.rf_idRegistersAccounts                  
					INNER JOIN AccountOMS.dbo.t_Case c ON
		r.id = c.rf_idRecordCasePatient     
					INNER JOIN AccountOMS.dbo.t_PatientSMO ps ON
		r.id=ps.rf_idRecordCasePatient                         
					INNER JOIN AccountOMS.dbo.t_Diagnosis d ON
		c.id=d.rf_idCase  
					INNER JOIN dbo.PEOPLE p ON
		r.id=p.rf_idRecordCase                
WHERE f.DateRegistration>=@dateStartReg AND f.DateRegistration<@dateEndReg AND a.ReportYearMonth>=@startPeriod AND a.ReportYearMonth<=@endPeriod		
		 and c.DateEnd>=@dateStart AND c.DateEnd<@dateEnd AND d.DiagnosisCode LIKE 'C%' AND d.TypeDiagnosis IN(1,3)
---------------------------------------------------------------------------------------------------------------------------------------
SELECT DISTINCT f.CodeM,a.rf_idSMO, a.Account, c.idRecordCase,f.DateRegistration,a.DateRegister,c.id AS rf_idCase, c1.PID, c.rf_idV006, c.rf_idV002,c.rf_idDoctor,c.DateBegin,c.DateEnd,
		d.DS1, c.AmountPayment,c.AmountPayment AS AmountPaymentAcc,c.Age
		,r.NumberPolis,r.AttachLPU,c.NumberHistoryCase,c.rf_idV009, c.rf_idV012, c.rf_idV004, 1 AS TypeDS
INTO #tmpPeople
FROM AccountOMS.dbo.t_File f INNER JOIN AccountOMS.dbo.t_RegistersAccounts a ON
			f.id=a.rf_idFiles				
				INNER JOIN AccountOMS.dbo.t_RecordCasePatient r ON
		a.id=r.rf_idRegistersAccounts				
				INNER JOIN AccountOMS.dbo.t_Case c  ON
		r.id=c.rf_idRecordCasePatient
				INNER JOIN 	#tmpCases c1 ON
		c.id=c1.rf_idCase              
				INNER JOIN AccountOMS.dbo.vw_Diagnosis d ON
		c.id=d.rf_idCase												
WHERE f.DateRegistration>=@dateStartReg AND f.DateRegistration<@dateEndReg AND a.ReportYearMonth>=@startPeriod AND a.ReportYearMonth<=@endPeriod AND d.DS1 LIKE 'C%' AND d.DS3 LIKE 'R52%'

CREATE UNIQUE NONCLUSTERED INDEX UQ_Index ON #tmpPeople(rf_idCase) WITH IGNORE_DUP_KEY

INSERT #tmpPeople (CodeM,rf_idSMO,Account,idRecordCase,DateRegistration,DateRegister,rf_idCase,PID,rf_idV006,rf_idV002,rf_idDoctor,DateBegin,DateEnd,DS1,AmountPayment,AmountPaymentAcc,
					Age,NumberPolis,AttachLPU,NumberHistoryCase,rf_idV009,rf_idV012,rf_idV004,TypeDS) 
SELECT f.CodeM,a.rf_idSMO, a.Account, c.idRecordCase,f.DateRegistration,a.DateRegister,c.id AS rf_idCase, c1.PID, c.rf_idV006, c.rf_idV002,c.rf_idDoctor,c.DateBegin,c.DateEnd,
		d.DS2, c.AmountPayment,c.AmountPayment AS AmountPaymentAcc,c.Age
		,r.NumberPolis,r.AttachLPU,c.NumberHistoryCase,c.rf_idV009, c.rf_idV012, c.rf_idV004, 2
FROM AccountOMS.dbo.t_File f INNER JOIN AccountOMS.dbo.t_RegistersAccounts a ON
			f.id=a.rf_idFiles				
				INNER JOIN AccountOMS.dbo.t_RecordCasePatient r ON
		a.id=r.rf_idRegistersAccounts				
				INNER JOIN AccountOMS.dbo.t_Case c  ON
		r.id=c.rf_idRecordCasePatient
				INNER JOIN 	#tmpCases c1 ON
		c.id=c1.rf_idCase              
				INNER JOIN AccountOMS.dbo.vw_Diagnosis d ON
		c.id=d.rf_idCase														
WHERE f.DateRegistration>=@dateStartReg AND f.DateRegistration<@dateEndReg AND a.ReportYearMonth>=@startPeriod AND a.ReportYearMonth<=@endPeriod AND d.DS2 LIKE 'C%' AND d.DS3 LIKE 'R52%'


UPDATE p SET p.AmountPaymentAcc=p.AmountPayment-r.AmountDeduction
FROM #tmpPeople p INNER JOIN (SELECT c.rf_idCase,SUM(c.AmountDeduction) AS AmountDeduction
								FROM AccountOMS.dbo.t_PaymentAcceptedCase2 c
								WHERE c.TypeCheckup=1 and c.DateRegistration>=@dateStartReg AND c.DateRegistration<GETDATE()
								GROUP BY c.rf_idCase
							) r ON
			p.rf_idCase=r.rf_idCase

;WITH cte AS
(
SELECT p.rf_idCase,s.smocod,p.PID,p.CodeM, l.NAMES AS LPU,
		s.sNameS AS SMO,
		p.DateRegistration, p.Account,p.DateRegister,
		p.idRecordCase 
		,CASE WHEN TypeDS =1 THEN p.DS1 ELSE '' END AS DS1
		,CASE WHEN TypeDS =2 THEN p.DS1 ELSE '' END AS DS2
		,p.AmountPayment,
		v2.name AS Profil,
		p.NumberHistoryCase,
		p.DateBegin,p.DateEnd,
		v9.name AS RSLT,
		v12.name AS ISHOD,
		v4.name AS PRVS,
		pp.FAM,
		pp.IM,
		pp.OT,
		pp.DR,
		p.NumberPolis,
		p.AttachLPU,l1.NAMES AS AttachLPUName,p.Age, CASE WHEN pp.W=1 THEN 'М' ELSE 'Ж' END AS Sex
		,v6.name AS USL_OK
		,COUNT(pr.rf_idCase) AS CountCasesEKMP
		, COUNT(pr.Reason) AS CountReason
FROM #tmpPeople p INNER JOIN dbo.PEOPLE pp ON
			p.PID = pp.ID
					INNER JOIN AccountOMS.dbo.vw_sprT001 l ON
				p.CodeM=l.CodeM
					INNER JOIN AccountOMS.dbo.vw_sprSMO s ON
				p.rf_idSMO=s.smocod
					INNER JOIN dbo.vw_sprV009 v9 ON
				p.rf_idV009=v9.id                  
					INNER JOIN dbo.vw_sprV002 v2 ON
				p.rf_idV002=v2.id   					
					INNER JOIN dbo.vw_sprV012 v12 ON
				p.rf_idV012=v12.id    
					INNER JOIN dbo.vw_sprV004 v4 ON
				p.rf_idV004=v4.id       
					INNER JOIN dbo.vw_sprV006 v6 ON
				p.rf_idV006=v6.id 
					left JOIN AccountOMS.dbo.vw_PaymnetEKMP_Reason pr ON
				p.rf_idCase=pr.rf_idCase                  
					left JOIN AccountOMS.dbo.vw_sprT001 l1 ON
				p.AttachLPU=l1.CodeM 
WHERE p.AmountPayment=0 and p.AmountPaymentAcc=0  AND  v4.DateBeg='20190101'--p.DateEnd BETWEEN v4.DateBeg AND v4.DateEnd
GROUP BY p.rf_idCase,s.smocod,p.PID,p.CodeM, l.NAMES ,s.sNameS ,p.DateRegistration, p.Account,p.DateRegister,p.idRecordCase ,CASE WHEN TypeDS =1 THEN p.DS1 ELSE '' END 
		,CASE WHEN TypeDS =2 THEN p.DS1 ELSE '' END , p.AmountPayment,v2.name ,p.NumberHistoryCase,p.DateBegin,p.DateEnd,
		v9.name ,v12.name ,v4.name ,pp.FAM,pp.IM,pp.OT,pp.DR,p.NumberPolis,p.AttachLPU,l1.NAMES ,p.Age,CASE WHEN pp.W=1 THEN 'М' ELSE 'Ж' END,v6.name
UNION ALL
SELECT p.rf_idCase,s.smocod,p.PID,p.CodeM, l.NAMES AS LPU,
		s.sNameS AS SMO,
		p.DateRegistration, p.Account,p.DateRegister,
		p.idRecordCase 
		,CASE WHEN TypeDS =1 THEN p.DS1 ELSE '' END AS DS1
		,CASE WHEN TypeDS =2 THEN p.DS1 ELSE '' END AS DS2
		, p.AmountPayment,
		v2.name AS Profil,
		p.NumberHistoryCase,
		p.DateBegin,p.DateEnd,
		v9.name AS RSLT,
		v12.name AS ISHOD,
		v4.name AS PRVS,
		pp.FAM,pp.IM,pp.OT,pp.DR,p.NumberPolis,
		p.AttachLPU,l1.NAMES AS AttachLPUName,p.Age,CASE WHEN pp.W=1 THEN 'М' ELSE 'Ж' END AS Sex
		,v6.name
		,COUNT(pr.rf_idCase) AS CountCasesEKMP
		, COUNT(pr.Reason) AS CountReason
FROM #tmpPeople p INNER JOIN dbo.PEOPLE pp ON
				p.PID = pp.ID
					INNER JOIN AccountOMS.dbo.vw_sprT001 l ON
				p.CodeM=l.CodeM
					INNER JOIN AccountOMS.dbo.vw_sprSMO s ON
				p.rf_idSMO=s.smocod
					INNER JOIN dbo.vw_sprV009 v9 ON
				p.rf_idV009=v9.id                  
					INNER JOIN dbo.vw_sprV002 v2 ON
				p.rf_idV002=v2.id   					
					INNER JOIN dbo.vw_sprV012 v12 ON
				p.rf_idV012=v12.id    
					INNER JOIN dbo.vw_sprV004 v4 ON
				p.rf_idV004=v4.id     
					INNER JOIN dbo.vw_sprV006 v6 ON
				p.rf_idV006=v6.id    
					left JOIN AccountOMS.dbo.vw_PaymnetEKMP_Reason pr ON
				p.rf_idCase=pr.rf_idCase       
					left JOIN AccountOMS.dbo.vw_sprT001 l1 ON
				p.AttachLPU=l1.CodeM 
WHERE p.AmountPayment>0 and p.AmountPaymentAcc>0  AND v4.DateBeg='20190101'--p.DateEnd BETWEEN v4.DateBeg AND v4.DateEnd 
GROUP BY p.rf_idCase, s.smocod,p.PID,p.CodeM, l.NAMES ,s.sNameS ,p.DateRegistration, p.Account,p.DateRegister,p.idRecordCase ,CASE WHEN TypeDS =1 THEN p.DS1 ELSE '' END 
		,CASE WHEN TypeDS =2 THEN p.DS1 ELSE '' END , p.AmountPayment,v2.name ,p.NumberHistoryCase,p.DateBegin,p.DateEnd,
		v9.name ,v12.name ,v4.name ,pp.FAM,pp.IM,pp.OT,pp.DR,p.NumberPolis,p.AttachLPU,l1.NAMES,p.Age,CASE WHEN pp.W=1 THEN 'М' ELSE 'Ж' END,v6.name
) 
SELECT  --CodeM,
		SMO,LPU,
		CAST(DateRegistration AS DATE) AS dateregistration,
		Account,DateRegister,
		idRecordCase
		,DS1,ISNULL(m.Diagnosis,'')
		,DS2,ISNULL(m1.Diagnosis,'')
		,CAST(AmountPayment AS MONEY) AS AmountPayment,
		Profil,USL_OK,NumberHistoryCase,DateBegin,DateEnd,RSLT,ISHOD,PRVS,
		FAM+' '+ISNULL(IM,'')+' '+ISNULL(OT,''), Sex,CAST(DR AS DATE) AS DR, Age,NumberPolis		
		,ISNULL(AttachLPUName,'')
		,CASE WHEN CountCasesEKMP>0 THEN 'Да' ELSE 'Нет' END AS IsEKMP
		,CountReason
FROM cte left JOIN AccountOMS.dbo.vw_sprMKB10 m ON
			cte.DS1=m.DiagnosisCode
		left JOIN AccountOMS.dbo.vw_sprMKB10 m1 ON
			cte.DS2=m1.DiagnosisCode
GROUP BY smocod,SMO,CodeM,LPU,CAST(DateRegistration AS DATE),Account,DateRegister,idRecordCase,DS1,ISNULL(m.Diagnosis,''),DS2,ISNULL(m1.Diagnosis,''),CAST(AmountPayment AS MONEY),
		Profil,USL_OK,NumberHistoryCase,DateBegin,DateEnd,RSLT,ISHOD,PRVS,FAM+' '+ISNULL(IM,'')+' '+ISNULL(OT,''), Sex,CAST(DR AS DATE) , Age,NumberPolis,ISNULL(AttachLPUName,'')
		,CASE WHEN CountCasesEKMP>0 THEN 'Да' ELSE 'Нет' END 
		,CountReason
ORDER BY smocod desc,CodeM asc


DROP TABLE #tmpCases
DROP TABLE #tmpPeople
GO
GRANT EXECUTE ON  [dbo].[usp_selectReport_CancerRegistr] TO [AccountsOMS]
GO
