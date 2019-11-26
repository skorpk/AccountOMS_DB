SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[usp_DeadPeopleAndCases]
			@dtBeginReg DATETIME,	
			@dtEndReg DATETIME,
			@dtEndRAK DATETIME,		
			@codeSMO CHAR(5)
as
CREATE TABLE #tmpCases(CodeM varchar(6),rf_idCase bigint,AmountPayment decimal(15, 2),AmountPaymentAccepted decimal(15, 2),CodeSMO char(5),DS1 char(10),rf_idV006 tinyint,rf_idV009 smallint,ENP varchar(16),
						rf_idV002 smallint,DateBegin date,DateEnd date,NewBorn varchar(9),Account varchar(15),DateAccount date,NumberHistoryCase nvarchar(50),idRecordCase BIGINT,DS DATE)


INSERT #tmpCases( CodeM ,rf_idCase ,AmountPayment ,AmountPaymentAccepted ,CodeSMO ,DS1 ,rf_idV006,rf_idV009 ,ENP ,rf_idV002 ,DateBegin ,DateEnd ,NewBorn ,Account ,DateAccount ,NumberHistoryCase ,idRecordCase,DS)
SELECT distinct f.CodeM,c.id AS rf_idCase,c.AmountPayment,c.AmountPayment AS AmountPaymentAccepted,a.rf_idSMO AS CodeSMO,d.DS1,c.rf_idV006,c.rf_idV009,ps.ENP,c.rf_idV002,c.DateBegin,c.DateEnd,r.NewBorn
	,Account,a.DateRegister	AS DateAccount,c.NumberHistoryCase,c.idRecordCase, dp.DS		
FROM AccountOMS.dbo.t_File f INNER JOIN AccountOMS.dbo.t_RegistersAccounts a ON
			f.id=a.rf_idFiles			
					INNER JOIN AccountOMS.dbo.t_RecordCasePatient r ON
			a.id=r.rf_idRegistersAccounts
					INNER JOIN AccountOMS.dbo.t_PatientSMO ps ON
			r.id=ps.rf_idRecordCasePatient					
					INNER JOIN AccountOMS.dbo.t_Case c ON
			r.id=c.rf_idRecordCasePatient
			AND c.DateEnd>='20170101'					
					INNER JOIN AccountOMS.dbo.vw_Diagnosis d ON
			c.id=d.rf_idCase  											
					INNER JOIN dbo.t_DeadPeople dp ON
			ps.ENP=dp.enp                  
WHERE f.DateRegistration>=@dtBeginReg AND f.DateRegistration<=@dtEndReg AND a.rf_idSMO=@codeSMO AND a.ReportYear>=2017

ALTER TABLE #tmpCases ADD AmountDeduction DECIMAL(11,2)

UPDATE c SET c.AmountPaymentAccepted=c.AmountPayment-p.AmountDeduction
from #tmpCases c INNER JOIN ( SELECT c.rf_idCase,SUM(c.AmountDeduction) AS AmountDeduction
								FROM AccountOMS.dbo.t_PaymentAcceptedCase2 c INNER JOIN #tmpCases t ON
												c.rf_idCase=t.rf_idCase																							
								WHERE c.DateRegistration>=@dtBeginReg AND c.DateRegistration<=@dtEndRAK
								GROUP BY c.rf_idCase
							) p ON
			c.rf_idCase=p.rf_idCase 
			   
SELECT DISTINCT c.rf_idCase,c.DocumentDate AS DateAkt,c.TypeCheckup,c.AmountDeduction,r.CodeReason
INTO #tAkt
FROM AccountOMS.dbo.t_PaymentAcceptedCase2 c INNER JOIN #tmpCases t ON
				c.rf_idCase=t.rf_idCase		
							LEFT JOIN /*vw_sprReasonDenialPayment*/[dbo].[vw_sprReasonDenialPayment_ForPDnReports] r ON
				c.rf_idCase=r.rf_idCase
				AND c.idAkt=r.idAkt																					
WHERE c.DateRegistration>=@dtBeginReg AND c.DateRegistration<=@dtEndRAK --AND c.TypeCheckup IN(1,2,3)
------------------------------------------------------------------------------------------------
DECLARE @i INT =0
SELECT distinct ROW_NUMBER() OVER(ORDER BY enp,DateBegin,DS1) AS ID,c.ENP,c.CodeM,l.NAMES,c.DateBegin,c.DateEnd,c.DS1,v6.name AS USL_OK, v9.Name, c.Account,c.DateAccount,c.idRecordCase,CAST(c.AmountPayment AS MONEY) AS AmountPayment,CAST(c.AmountPaymentAccepted AS money) AS AmountPaymentAccepted,
		CASE WHEN aa.TypeCheckup=1 THEN aa.DateAkt ELSE NULL END AS DateAktMEK,
		CASE WHEN aa.TypeCheckup=1 THEN aa.CodeReason ELSE NULL END AS CodeMEK,
		-------------------------------------------------------------------
		CASE WHEN aa.TypeCheckup=2 THEN aa.DateAkt ELSE NULL END AS DateAktMEE,
		CASE WHEN aa.TypeCheckup=2 THEN aa.CodeReason ELSE NULL END AS CodeMEE,
		CASE WHEN aa.TypeCheckup=2 THEN CAST(ISNULL(aa.AmountDeduction,0.0) AS MONEY) else null end AS DeductionMEE,
		----------------------------------------------------------
		CASE WHEN aa.TypeCheckup=3 THEN aa.DateAkt ELSE NULL END AS DateAktEKMP,
		CASE WHEN aa.TypeCheckup=3 THEN aa.CodeReason ELSE NULL END AS CodeEKMP,
		CASE WHEN aa.TypeCheckup=3 THEN CAST(ISNULL(aa.AmountDeduction,0.0) AS MONEY) else null end AS DeductionEKMP
from #tmpCases c 
INNER JOIN AccountOMS.dbo.vw_sprT001 l ON c.CodeM=l.CodeM
INNER JOIN dbo.vw_sprV006 v6 ON c.rf_idV006=v6.id       
INNER JOIN dbo.vw_sprV009 v9 ON c.rf_idV009=v9.id       
LEFT JOIN #tAkt aa ON c.rf_idCase=aa.rf_idCase              
ORDER BY enp, DateBegin,DS1--,rf_idCase

DROP TABLE #tAkt
drop TABLE #tmpCases
GO
GRANT EXECUTE ON  [dbo].[usp_DeadPeopleAndCases] TO [AccountsOMS]
GO
GRANT EXECUTE ON  [dbo].[usp_DeadPeopleAndCases] TO [db_AccountOMS]
GO
