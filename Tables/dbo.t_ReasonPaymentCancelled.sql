CREATE TABLE [dbo].[t_ReasonPaymentCancelled]
(
[rf_idCase] [bigint] NOT NULL,
[rf_idPaymentAccountCanseled] [tinyint] NOT NULL
) ON [AccountOMSCase]
GO
ALTER TABLE [dbo].[t_ReasonPaymentCancelled] ADD CONSTRAINT [FK_ReasonPaymentCanseled_Cases] FOREIGN KEY ([rf_idCase]) REFERENCES [dbo].[t_Case] ([id]) ON DELETE CASCADE
GO
GRANT SELECT ON  [dbo].[t_ReasonPaymentCancelled] TO [db_AccountOMS]
GRANT INSERT ON  [dbo].[t_ReasonPaymentCancelled] TO [db_AccountOMS]
GO
