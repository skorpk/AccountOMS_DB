SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[usp_GetDataCasesAndMuToSMEV]
as
DECLARE @dateRegStart DATETIME='20180120',
		@dateRegEnd DATETIME=GETDATE(),
		@reportYear SMALLINT=2018
CREATE TABLE #tCases(
						CodeM VARCHAR(6),
						OKATO CHAR(5),
						ENP VARCHAR(16),
						rf_idCase BIGINT,
						rf_idV006 TINYINT,
						rf_idV008 SMALLINT,
						rf_idV002 SMALLINT,
						AmountPayment DECIMAL(15,2),
						Account VARCHAR(15),
						DateBegin DATE,
						DateEnd DATE,
						Mesc VARCHAR(20),
						Tariff DECIMAL(15,2),
						AmountPaymentAccepted DECIMAL(15,2),
						IsChild tinyint 
					)
CREATE UNIQUE NONCLUSTERED INDEX UQ_Temp ON #tCases(rf_idCase) WITH IGNORE_DUP_KEY
CREATE TABLE #tMU(
				   rf_idCase BIGINT,
				   MUGroupCode TINYINT,
				   MUUnGroupCode TINYINT,
				   MUCode SMALLINT,
				   DateHelpBegin DATE,
				   DateHelpEnd DATE,
				   Qunatity DECIMAL(6,2),
				   Price DECIMAL(15,2)
				)

INSERT #tCases( CodeM ,OKATO ,ENP ,rf_idCase ,rf_idV006 ,rf_idV008 ,rf_idV002 ,AmountPayment ,Account ,DateBegin ,Dateend ,Mesc ,Tariff, IsChild)
SELECT f.CodeM,ps.OKATO,ps.ENP,c.id AS rf_idCase, c.rf_idV006, c.rf_idV008, c.rf_idV002, c.AmountPayment,a.Account,c.DateBegin,c.DateEnd,m.MES, m.Tariff, CASE WHEN Age>17 THEN 0 ELSE 1 END
FROM dbo.t_File f INNER JOIN dbo.t_RegistersAccounts a ON
		f.id=a.rf_idFiles
					INNER JOIN dbo.t_RecordCasePatient p ON
		a.id=p.rf_idRegistersAccounts
					INNER JOIN dbo.t_PatientSMO ps ON
		p.id=ps.rf_idRecordCasePatient                  
					INNER JOIN dbo.t_Case c ON
		p.id=c.rf_idRecordCasePatient
					INNER JOIN dbo.t_MES m ON
		c.id=m.rf_idCase
WHERE f.DateRegistration>=@dateRegStart AND f.DateRegistration<@dateRegEnd AND ReportYear>=@reportYear AND c.rf_idV006<=3
		AND NOT EXISTS(SELECT 1 FROM dbo.t_SynchCasesSMEV WHERE rf_idCase=c.id)

INSERT #tCases( CodeM ,OKATO ,ENP ,rf_idCase ,rf_idV006 ,rf_idV008 ,rf_idV002 ,AmountPayment ,Account ,DateBegin ,Dateend ,Mesc ,Tariff, IsChild)
SELECT f.CodeM,ps.OKATO,ps.ENP,c.id AS rf_idCase, c.rf_idV006, c.rf_idV008, c.rf_idV002, c.AmountPayment,a.Account,c.DateBegin,c.DateEnd,null, NULL, CASE WHEN Age>17 THEN 0 ELSE 1 END
FROM dbo.t_File f INNER JOIN dbo.t_RegistersAccounts a ON
		f.id=a.rf_idFiles
					INNER JOIN dbo.t_RecordCasePatient p ON
		a.id=p.rf_idRegistersAccounts
					INNER JOIN dbo.t_PatientSMO ps ON
		p.id=ps.rf_idRecordCasePatient                  
					INNER JOIN dbo.t_Case c ON
		p.id=c.rf_idRecordCasePatient					
WHERE f.DateRegistration>=@dateRegStart AND f.DateRegistration<@dateRegEnd AND ReportYear>=@reportYear AND c.rf_idV006>=3 
		AND NOT EXISTS(SELECT 1 FROM dbo.t_SynchCasesSMEV WHERE rf_idCase=c.id)

UPDATE p SET p.AmountPaymentAccepted=p.AmountPayment-r.AmountDeduction
FROM #tCases p INNER JOIN (
							SELECT t.rf_idCase,SUM(p.AmountDeduction) AS AmountDeduction
							FROM dbo.t_PaymentAcceptedCase2 p INNER  JOIN #tCases t ON			
												p.rf_idCase=t.rf_idCase
							WHERE p.DateRegistration>=@dateRegStart AND p.DateRegistration<GETDATE()	 
							GROUP BY t.rf_idCase
							) r ON
			p.rf_idCase=r.rf_idCase


INSERT #tMU( rf_idCase ,MUGroupCode ,MUUnGroupCode ,MUCode ,DateHelpBegin ,DateHelpEnd ,Qunatity ,Price )
SELECT m.rf_idCase, MUGroupCode, m.MUUnGroupCode, m.MUCode, m.DateHelpBegin, m.DateHelpEnd, m.Quantity, m.Price
FROM #tCases c INNER JOIN dbo.t_Meduslugi m ON
		c.rf_idCase=m.rf_idCase
WHERE (CASE WHEN c.AmountPayment=0 AND AmountPaymentAccepted=0 then 1 
			when c.AmountPayment>0 and AmountPaymentAccepted>0 THEN 1 END)=1 and m.Price>0 AND m.DateHelpBegin>=c.DateBegin AND m.DateHelpBegin<=c.Dateend AND ISNULL(m.IsNeedUsl,9)<>1

INSERT #tMU( rf_idCase ,MUGroupCode ,MUUnGroupCode ,MUCode ,DateHelpBegin ,DateHelpEnd ,Qunatity ,Price )
SELECT m.rf_idCase, m.MUGroupCode, m.MUUnGroupCode, m.MUCode, m.DateHelpBegin, m.DateHelpEnd, m.Quantity, p.Price
FROM #tCases c INNER JOIN dbo.t_Meduslugi m ON
		c.rf_idCase=m.rf_idCase
				INNER JOIN vw_PriceFalse_71_2 p ON
		m.MUCode = p.MUCode
		AND m.MUGroupCode = p.MUGroupCode
		AND m.MUUnGroupCode = p.MUUnGroupCode  
		AND c.IsChild=p.AGE            
WHERE c.DateEnd>=p.DATE_B AND c.DateEnd<=p.DATE_E and (CASE WHEN c.AmountPayment=0 AND AmountPaymentAccepted=0 then 1 
			when c.AmountPayment>0 and AmountPaymentAccepted>0 THEN 1 END)=1 and m.MUGroupCode=71 AND m.MUUnGroupCode=1
------------------------вывод данных для SSIS------------------------------------
SELECT  c.CodeM ,c.OKATO ,c.ENP ,c.rf_idCase ,c.rf_idV006 ,c.rf_idV008 ,c.rf_idV002 ,c.AmountPayment ,c.Account ,c.DateBegin ,c.DateEnd ,c.Mesc ,c.Tariff         
INTO tmpCasesSMEV
FROM #tCases  c
WHERE (CASE WHEN c.AmountPayment=0 AND AmountPaymentAccepted=0 then 1 when c.AmountPayment>0 and AmountPaymentAccepted>0 THEN 1 END)=1  

SELECT  m.rf_idCase ,m.MUGroupCode ,m.MUUnGroupCode ,m.MUCode ,m.DateHelpBegin ,m.DateHelpEnd ,m.Qunatity ,m.Price INTO tmpMUSMEV FROM #tMU m

SELECT m.rf_idCase, m.MUSurgery
INTO tmpMUSurgerySMEV
FROM #tCases c INNER JOIN dbo.t_Meduslugi m ON
		c.rf_idCase=m.rf_idCase
WHERE (CASE WHEN c.AmountPayment=0 AND AmountPaymentAccepted=0 then 1 when c.AmountPayment>0 and AmountPaymentAccepted>0 THEN 1 END)=1 AND m.MUSurgery IS NOT NULL
----------------------вставка сведений о том что случай был выгружен для сведений о личном кабинете----------------------
INSERT dbo.t_SynchCasesSMEV( rf_idCase )
SELECT DISTINCT rf_idCase FROM #tCases c WHERE (CASE WHEN c.AmountPayment=0 AND AmountPaymentAccepted=0 then 1 when c.AmountPayment>0 and AmountPaymentAccepted>0 THEN 1 END)=1  

DROP TABLE #tCases
DROP TABLE #tMU
GO
