SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[usp_GetDataDN65]
		@dateStart DATETIME,
        @dateEnd DATETIME,
        @dateEndPay DATETIME,
        @reportYear SMALLINT,
        @reportMonth TINYINT,
		@SMO CHAR(5),
		@by_diag TINYINT
as

/*
DECLARE @dateStart DATETIME='20190101',
        @dateEnd DATETIME='20190410',
        @dateEndPay DATETIME='20190410',
        @reportYear SMALLINT=2019,
        @reportMonth TINYINT=3,
		@SMO CHAR(5)= '34002'
*/

CREATE TABLE #tCases
(
       rf_idCase BIGINT,
       rf_idCompletedCase INT,
       CodeM CHAR(6),
       AmountPayment DECIMAL(15,2),
       AmountPaymentAcc DECIMAL(15,2),
       rf_idV006 TINYINT,
       rf_idSMO VARCHAR(5),
       ENP VARCHAR(16),
       Age INT, 
       AmmPay DECIMAL(15,2),
       Sex CHAR(1),
	   dn_diag CHAR(6)
)            

INSERT #tCases( rf_idCase, CodeM,AmountPayment,rf_idCompletedCase,AmountPaymentAcc,Age,rf_idV006,rf_idSMO,ENP,Sex, dn_diag )
SELECT distinct c.id, f.CodeM, c.AmountPayment,c.rf_idRecordCasePatient,c.AmountPayment, c.Age,c.rf_idV006,a.rf_idSMO,p.ENP,pp.Sex, dn_diag.DiagnosisCode AS dn_diag
FROM dbo.t_File f INNER JOIN dbo.t_RegistersAccounts a ON
                    f.id=a.rf_idFiles
                                  INNER JOIN dbo.t_RecordCasePatient r ON
                    a.id=r.rf_idRegistersAccounts
                                  INNER JOIN dbo.t_Case c ON
                    r.id=c.rf_idRecordCasePatient     
                                  INNER JOIN dbo.t_PatientSMO p ON
                    r.id=p.rf_idRecordCasePatient                                                                                         
                                  INNER JOIN dbo.t_RegisterPatient pp ON
                    f.id=pp.rf_idFiles
                    AND r.id=pp.rf_idRecordCase
								  INNER JOIN dbo.t_PurposeOfVisit pv ON 
					c.id = pv.rf_idCase
								  INNER JOIN dbo.t_Diagnosis diag ON
					c.id = diag.rf_idCase
								  LEFT JOIN oms_nsi.[dbo].[sprMKBDN] dn_diag ON
                    dn_diag.DiagnosisCode = diag.DiagnosisCode
WHERE f.DateRegistration>@dateStart AND f.DateRegistration<@dateEnd AND a.ReportMonth>0 AND a.ReportMonth <=@reportMonth AND a.ReportYear=@reportYear
             AND c.rf_idV006=3   
			 AND pv.rf_idV025 = '1.3'
			 AND c.Age>17 
			 AND p.rf_idSMO = @SMO

UPDATE p SET p.AmountPaymentAcc=p.AmountPayment-ISNULL(r.AmountDeduction, 0)
FROM #tCases p LEFT JOIN (SELECT c.rf_idCase,ISNULL(SUM(c.AmountDeduction), 0) AS AmountDeduction
                                                      FROM t_PaymentAcceptedCase2 c
                                                      WHERE c.DateRegistration>=@dateStart AND c.DateRegistration<@dateEndPay    AND TypeCheckup=1
                                                      GROUP BY c.rf_idCase
                                               ) r ON
                    p.rf_idCase=r.rf_idCase

UPDATE p SET p.AmmPay=r.AmountPaymentAccept
FROM #tCases p INNER JOIN (SELECT c.rf_idCase,ISNULL(SUM(c.AmountPaymentAccept), 0) AS AmountPaymentAccept
                                                      FROM dbo.t_PaidCase c
                                                      WHERE c.DateRegistration>=@dateStart AND c.DateRegistration<@dateEndPay
                                                      GROUP BY c.rf_idCase
                                               ) r ON
                    p.rf_idCase=r.rf_idCase


--SELECT 1 AS id,Sex , SUM(AmountPayment) AS Col5,COUNT(DISTINCT enp+Sex) AS Col6, SUM(AmmPay) AS Col7 FROM #tCases WHERE AmountPaymentAcc>0  GROUP BY sex

IF @by_diag = 0 
	BEGIN
		SELECT 1 AS id, SUM(AmountPayment) AS Col5,COUNT(DISTINCT enp) AS Col6, SUM(AmmPay) AS Col7 FROM #tCases WHERE AmountPaymentAcc>0 
		UNION ALL
		SELECT 2, SUM(AmountPayment) AS Col5,COUNT(DISTINCT enp) AS Col6, SUM(AmmPay) AS Col7 FROM #tCases WHERE AmountPaymentAcc>0  AND Sex='М' 
		UNION ALL
		SELECT 3, SUM(AmountPayment) AS Col5,COUNT(DISTINCT enp) AS Col6, SUM(AmmPay) AS Col7 FROM #tCases WHERE AmountPaymentAcc>0  AND Sex='М' AND Age=65
		UNION ALL
		SELECT 4, SUM(AmountPayment) AS Col5,COUNT(DISTINCT enp) AS Col6, SUM(AmmPay) AS Col7 FROM #tCases WHERE AmountPaymentAcc>0  AND Sex='М' AND Age>65
		UNION ALL
		SELECT 5, SUM(AmountPayment) AS Col5,COUNT(DISTINCT enp) AS Col6, SUM(AmmPay) AS Col7 FROM #tCases WHERE AmountPaymentAcc>0  AND Sex='Ж' 
		UNION ALL
		SELECT 6, SUM(AmountPayment) AS Col5,COUNT(DISTINCT enp) AS Col6, SUM(AmmPay) AS Col7 FROM #tCases WHERE AmountPaymentAcc>0  AND Sex='Ж' AND Age=65
		UNION ALL
		SELECT 7, SUM(AmountPayment) AS Col5,COUNT(DISTINCT enp) AS Col6, SUM(AmmPay) AS Col7 FROM #tCases WHERE AmountPaymentAcc>0  AND Sex='Ж' AND Age>65
	END
ELSE
	BEGIN
		SELECT 1 AS id, SUM(AmountPayment) AS Col5,COUNT(DISTINCT enp) AS Col6, SUM(AmmPay) AS Col7 FROM #tCases WHERE AmountPaymentAcc>0 AND dn_diag IS NOT NULL 
		UNION ALL
		SELECT 2, SUM(AmountPayment) AS Col5,COUNT(DISTINCT enp) AS Col6, SUM(AmmPay) AS Col7 FROM #tCases WHERE AmountPaymentAcc>0  AND Sex='М' AND dn_diag IS NOT NULL 
		UNION ALL
		SELECT 3, SUM(AmountPayment) AS Col5,COUNT(DISTINCT enp) AS Col6, SUM(AmmPay) AS Col7 FROM #tCases WHERE AmountPaymentAcc>0  AND Sex='М' AND Age=65 AND dn_diag IS NOT NULL 
		UNION ALL
		SELECT 4, SUM(AmountPayment) AS Col5,COUNT(DISTINCT enp) AS Col6, SUM(AmmPay) AS Col7 FROM #tCases WHERE AmountPaymentAcc>0  AND Sex='М' AND Age>65 AND dn_diag IS NOT NULL 
		UNION ALL
		SELECT 5, SUM(AmountPayment) AS Col5,COUNT(DISTINCT enp) AS Col6, SUM(AmmPay) AS Col7 FROM #tCases WHERE AmountPaymentAcc>0  AND Sex='Ж' AND dn_diag IS NOT NULL 
		UNION ALL
		SELECT 6, SUM(AmountPayment) AS Col5,COUNT(DISTINCT enp) AS Col6, SUM(AmmPay) AS Col7 FROM #tCases WHERE AmountPaymentAcc>0  AND Sex='Ж' AND Age=65 AND dn_diag IS NOT NULL 
		UNION ALL
		SELECT 7, SUM(AmountPayment) AS Col5,COUNT(DISTINCT enp) AS Col6, SUM(AmmPay) AS Col7 FROM #tCases WHERE AmountPaymentAcc>0  AND Sex='Ж' AND Age>65 AND dn_diag IS NOT NULL 
	END

DROP TABLE #tCases
GO
