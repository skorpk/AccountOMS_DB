CREATE TABLE [dbo].[t_Kiro]
(
[rf_idCase] [bigint] NOT NULL,
[rf_idKiro] [int] NOT NULL,
[ValueKiro] [decimal] (3, 2) NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[t_Kiro] ADD CONSTRAINT [FK_Kiro_Cases] FOREIGN KEY ([rf_idCase]) REFERENCES [dbo].[t_Case] ([id]) ON DELETE CASCADE
GO
GRANT SELECT ON  [dbo].[t_Kiro] TO [db_AccountOMS]
GRANT INSERT ON  [dbo].[t_Kiro] TO [db_AccountOMS]
GRANT DELETE ON  [dbo].[t_Kiro] TO [db_AccountOMS]
GO
