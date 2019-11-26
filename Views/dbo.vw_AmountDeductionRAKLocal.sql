SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE VIEW [dbo].[vw_AmountDeductionRAKLocal]
AS
SELECT TOP 1 WITH TIES sc.rf_idCase, f.DateRegistration, sc.AmountPaymentAccept, f.CodeM, RIGHT(a.Account, 1) AS Letter, ISNULL(sc.AmountEKMP, 0) 
                                                    + ISNULL(sc.AmountMEE, 0) + ISNULL(sc.AmountMEK, 0) AS AmountDeduction
FROM ExchangeFinancing.dbo.t_AFileIn f INNER JOIN
                                                    ExchangeFinancing.dbo.t_DocumentOfCheckup p ON f.id = p.rf_idAFile INNER JOIN
                                                    ExchangeFinancing.dbo.t_CheckedAccount a ON p.id = a.rf_idDocumentOfCheckup INNER JOIN
                                                    ExchangeFinancing.dbo.t_CheckedCase sc ON a.id = sc.rf_idCheckedAccount
WHERE f.DateRegistration >'20130101' AND f.DateRegistration<GETDATE() 
ORDER BY ROW_NUMBER() OVER (PARTITION BY f.DateRegistration, a.Account, a.ReportYear, sc.GUID_Case ORDER BY p.DocumentDate DESC, p.DocumentNumber DESC)
GO
GRANT SELECT ON  [dbo].[vw_AmountDeductionRAKLocal] TO [db_AccountOMS]
GO
