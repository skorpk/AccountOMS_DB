CREATE TABLE [dbo].[t_FinancialSanctions]
(
[rf_idCase] [bigint] NOT NULL,
[Amount] [decimal] (15, 2) NOT NULL,
[TypeSanction] [tinyint] NOT NULL
) ON [AccountOMSCase]
GO
ALTER TABLE [dbo].[t_FinancialSanctions] ADD CONSTRAINT [FK_FinancialSanctions_Cases] FOREIGN KEY ([rf_idCase]) REFERENCES [dbo].[t_Case] ([id]) ON DELETE CASCADE
GO
GRANT SELECT ON  [dbo].[t_FinancialSanctions] TO [db_AccountOMS]
GRANT INSERT ON  [dbo].[t_FinancialSanctions] TO [db_AccountOMS]
GO
