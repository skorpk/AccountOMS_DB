SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE VIEW [dbo].[wv_AmountPaymentRPDLocal]
AS
SELECT        sc.rf_idCase, f.DateRegistration, SUM(sc.AmountPayment) AS AmountPaymentAccept, f.CodeM, RIGHT(a.Account, 1) AS Letter
FROM            ExchangeFinancing.dbo.t_DFileIn f INNER JOIN
                         ExchangeFinancing.dbo.t_PaymentDocument p ON f.id = p.rf_idDFile INNER JOIN
                         ExchangeFinancing.dbo.t_SettledAccount a ON p.id = a.rf_idPaymentDocument INNER JOIN
                         ExchangeFinancing.dbo.t_SettledCase sc ON a.id = sc.rf_idSettledAccount
WHERE f.DateRegistration > '20130101' AND f.DateRegistration<GETDATE()
GROUP BY sc.rf_idCase, f.DateRegistration, f.CodeM, RIGHT(a.Account, 1)
GO
GRANT SELECT ON  [dbo].[wv_AmountPaymentRPDLocal] TO [db_AccountOMS]
GO
