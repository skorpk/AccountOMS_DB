SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [dbo].[usp_selectReportHeartStenting]
        @dtBegin DATETIME,	
		@dtEndReg DATETIME,
		@dtBeginRAK DATETIME,	
		@dtEndRegRAK DATETIME,		
		@reportYear SMALLINT
AS
DECLARE @dtEnd DATE

--SET @dtBegin=CAST(@reportYear AS CHAR(4))+'0101'
SET @dtEnd=DATEADD(YEAR,1,@dtBegin)
--SELECT @dtBegin,@dtEnd,@dtEndReg

				
SELECT f.CodeM,c.id AS rf_idCase,c.AmountPayment AS AmountPaymentAccepted,a.rf_idSMO AS CodeSMO,m.mes,p.FAM,p.IM,p.Ot,p.DR,p.ENP,c.DateBegin, c.DateEnd,p.LPU
INTO #tmpCases
FROM AccountOMS.dbo.t_File f 
INNER JOIN AccountOMS.dbo.t_RegistersAccounts a ON f.id=a.rf_idFiles
INNER JOIN AccountOMS.dbo.t_RecordCasePatient r ON a.id=r.rf_idRegistersAccounts					
INNER JOIN AccountOMS.dbo.t_PatientSMO ps ON r.id=ps.rf_idRecordCasePatient                  
INNER JOIN AccountOMS.dbo.t_Case c ON r.id=c.rf_idRecordCasePatient
INNER JOIN AccountOMS.dbo.t_MES m ON c.id=m.rf_idCase										
INNER JOIN PolicyRegister.dbo.PEOPLE p ON ps.ENP=p.ENP
WHERE f.DateRegistration>=@dtBegin AND f.DateRegistration<=@dtEndReg AND a.ReportYear=@reportYear 	AND m.MES IN('1.12.498','1.12.499','1.16.498','1.16.499','1.17.498','1.17.499','1.18.498','1.18.499')
	AND a.rf_idSMO<>'34' AND c.DateEnd>=@dtBegin AND c.DateEnd<@dtEnd AND p.DS IS NULL

UPDATE c SET c.AmountPaymentAccepted=c.AmountPaymentAccepted-p.AmountDeduction
from #tmpCases c INNER JOIN ( SELECT c.rf_idCase,SUM(c.AmountDeduction) AS AmountDeduction
								FROM AccountOMS.dbo.t_PaymentAcceptedCase2 c																						
								WHERE c.DateRegistration>=@dtBegin AND c.DateRegistration<=@dtEndReg
								GROUP BY c.rf_idCase
							) p ON
			c.rf_idCase=p.rf_idCase   


SELECT  l.CodeM ,l.NAMES,CodeSMO ,RTRIM(MES) ,FAM ,IM ,ISNULL(OT,'') ,CAST(DR AS DATE) ,ENP ,c.DateBegin ,c.DateEnd ,
        LPU,l1.NAMES
FROM #tmpCases c 
INNER JOIN AccountOMS.dbo.vw_sprt001 l ON c.CodeM=l.CodeM			 
INNER JOIN AccountOMS.dbo.vw_sprt001 l1 ON c.LPU=l1.CodeM			 
WHERE AmountPaymentAccepted>0
ORDER BY l.CodeM

DROP TABLE #tmpCases
GO
GRANT EXECUTE ON  [dbo].[usp_selectReportHeartStenting] TO [AccountsOMS]
GO
GRANT EXECUTE ON  [dbo].[usp_selectReportHeartStenting] TO [db_AccountOMS]
GO
