SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[usp_selectReport_MEEProfAndDisp_2017]
					@p_StartReportMonth int,
					@p_StartReportYear int,
					@p_EndReportMonth int,
					@p_EndReportYear int,
					@dateStart nvarchar(10),
					@dateEnd nvarchar(10),
					@dateEndPay nvarchar(10),
					@codeM int -- возможен выбор только одной МО
AS	
CREATE TABLE #tPeople(rf_idCase BIGINT,DateBegin DATE,DateEnd DATE,CodeM CHAR(6),Account VARCHAR(15),ReportMonth TINYINT
,AmountPayment DECIMAL(11,2),rf_idSMO CHAR(5),NumberHistoryCase VARCHAR(50),Policy VARCHAR(30),DateAccount DATE
,NumberCase BIGINT,TypeDisp nvarchar(4),Letter VARCHAR(1),IsOnlyMEK BIT NOT NULL DEFAULT(1))
INSERT #tPeople(rf_idCase ,DateBegin ,DateEnd ,CodeM ,Account ,AmountPayment,rf_idSMO,NumberHistoryCase,Policy,DateAccount,NumberCase,TypeDisp,Letter )
SELECT c.id,c.DateBegin,c.DateEnd,f.CodeM,a.Account,c.AmountPayment,a.rf_idSMO,c.NumberHistoryCase,r.NumberPolis,a.DateRegister,c.idRecordCase, di.TypeDisp, a.Letter
FROM AccountOMS.dbo.t_File f 
INNER JOIN AccountOMS.dbo.t_RegistersAccounts a ON f.id=a.rf_idFiles AND f.CodeM=@codeM AND a.rf_idSMO<>'34'
INNER JOIN (VALUES('O'),('F'),('V'),('I'),('R'),('U'),('D')) v(letter) ON a.Letter=v.letter
INNER JOIN AccountOMS.dbo.t_RecordCasePatient r ON a.id=r.rf_idRegistersAccounts
INNER JOIN AccountOMS.dbo.t_Case c ON r.id=c.rf_idRecordCasePatient			
INNER JOIN AccountOMS.dbo.t_DispInfo di on c.id=di.rf_idCase																	
WHERE f.DateRegistration>=@dateStart AND f.DateRegistration<=@dateEnd+' 23:59:59'
AND a.[ReportYearMonth] between cast(@p_StartReportYear as nvarchar(4))+right('00'+ltrim(str(@p_StartReportMonth)),2) 
and cast(@p_EndReportYear as nvarchar(4))+right('00'+ltrim(str(@p_EndReportMonth)),2)
-------------------------------------------------------------RAK-------------------------------------------------------------
UPDATE c1 SET c1.AmountPayment=c1.AmountPayment-ISNULL(r.AmountDeduction,0)
FROM #tPeople c1 INNER JOIN (
       SELECT rf_idCase,SUM(ISNULL([AmountMEK],0)) AS AmountDeduction
       FROM AccountOMS.dbo.t_PaymentAcceptedCase2 vz1
       WHERE DateRegistration>=@dateStart AND DateRegistration<=@dateEndPay+' 23:59:59' AND TypeCheckup=1  
       AND NOT EXISTS(SELECT rf_idCase
						   FROM AccountOMS.dbo.t_PaymentAcceptedCase2	vz2													
						   WHERE DateRegistration>=@dateStart AND DateRegistration<=@dateEndPay+' 23:59:59' AND TypeCheckup>1 
								 AND CodeM=@codeM AND vz2.rf_idCase=vz1.rf_idCase)
			GROUP BY rf_idCase) r ON c1.rf_idCase=r.rf_idCase 
			 
--UPDATE p SET p.AmountPayment=p.AmountPayment-r.AmountDeduction
--FROM #tPeople p 
--INNER JOIN (SELECT rf_idCase,SUM(c.AmountMEK) AS AmountDeduction
--			FROM ExchangeFinancing.dbo.t_AFileIn f 
--			INNER JOIN  ExchangeFinancing.dbo.t_DocumentOfCheckup d ON f.id=d.rf_idAFile AND f.CodeM=@codeM
--			INNER JOIN ExchangeFinancing.dbo.t_CheckedAccount a ON d.id=a.rf_idDocumentOfCheckup
--			INNER JOIN ExchangeFinancing.dbo.t_CheckedCase c ON a.id=c.rf_idCheckedAccount 														
--			WHERE f.DateRegistration>=@dateStart AND f.DateRegistration<=@dateEndPay+' 23:59:59' AND d.TypeCheckup=1 
--			AND NOT EXISTS(SELECT rf_idCase
--						   FROM ExchangeFinancing.dbo.t_AFileIn f 
--						   INNER JOIN  ExchangeFinancing.dbo.t_DocumentOfCheckup d ON f.id=d.rf_idAFile AND f.CodeM=@codeM																			
--						   INNER JOIN ExchangeFinancing.dbo.t_CheckedAccount a ON d.id=a.rf_idDocumentOfCheckup
--						   INNER JOIN ExchangeFinancing.dbo.t_CheckedCase c1 ON a.id=c1.rf_idCheckedAccount 														
--						   WHERE f.DateRegistration>=@dateStart AND f.DateRegistration<=@dateEndPay+' 23:59:59' AND d.TypeCheckup>1 
--																AND c1.rf_idCase=c.rf_idCase)
--			GROUP BY rf_idCase) r ON p.rf_idCase=r.rf_idCase


UPDATE p SET p.IsOnlyMEK=0
FROM #tPeople p 
INNER JOIN (SELECT DISTINCT rf_idCase
			FROM AccountOMS.dbo.t_PaymentAcceptedCase2															
			WHERE DateRegistration>=@dateStart AND DateRegistration<=@dateEndPay+' 23:59:59' 
			AND TypeCheckup>1 ) r ON p.rf_idCase=r.rf_idCase
--UPDATE p SET p.IsOnlyMEK=0
--FROM #tPeople p 
--INNER JOIN (SELECT DISTINCT rf_idCase
--			FROM ExchangeFinancing.dbo.t_AFileIn f 
--			INNER JOIN  ExchangeFinancing.dbo.t_DocumentOfCheckup d ON f.id=d.rf_idAFile AND f.CodeM=@codeM
--			INNER JOIN ExchangeFinancing.dbo.t_CheckedAccount a ON d.id=a.rf_idDocumentOfCheckup
--			INNER JOIN ExchangeFinancing.dbo.t_CheckedCase c ON a.id=c.rf_idCheckedAccount 														
--			WHERE f.DateRegistration>=@dateStart AND f.DateRegistration<=@dateEndPay+' 23:59:59' 
--			AND d.TypeCheckup>1 ) r ON p.rf_idCase=r.rf_idCase
-----------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------ИТОГИ------------------------------------------------------------
SELECT p1.FAM+' '+p1.IM+' '+ISNULL(p1.OT,'') AS FIO,CAST(p1.DR AS DATE) AS DR,p.Policy,s.sNameS,p.NumberHistoryCase,d.DS1
,p.Account,p.DateAccount,p.NumberCase,p.DateBegin,p.DateEnd,ISNULL(p.AmountPayment,0), TypeDisp, Letter
FROM #tPeople p 
INNER JOIN AccountOMS.dbo.t_Case_PID_ENP en ON p.rf_idCase=en.rf_idCase
INNER JOIN AccountOMS.dbo.vw_Diagnosis d ON p.rf_idCase=d.rf_idCase
INNER JOIN PolicyRegister.dbo.PEOPLE p1 ON en.pid=p1.ID
INNER JOIN AccountOMS.dbo.vw_sprSMO s ON p.rf_idSMO=s.smocod
WHERE p.AmountPayment>0	AND IsOnlyMEK=1		
ORDER BY FIO

DROP TABLE #tPeople
GO
GRANT EXECUTE ON  [dbo].[usp_selectReport_MEEProfAndDisp_2017] TO [AccountsOMS]
GO
GRANT EXECUTE ON  [dbo].[usp_selectReport_MEEProfAndDisp_2017] TO [db_AccountOMS]
GO
