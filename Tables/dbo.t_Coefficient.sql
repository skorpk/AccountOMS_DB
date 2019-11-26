CREATE TABLE [dbo].[t_Coefficient]
(
[rf_idCase] [bigint] NULL,
[Code_SL] [smallint] NULL,
[Coefficient] [decimal] (3, 2) NULL
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_Coef] ON [dbo].[t_Coefficient] ([rf_idCase]) INCLUDE ([Code_SL], [Coefficient]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[t_Coefficient] ADD CONSTRAINT [FK_Coefficient_Cases] FOREIGN KEY ([rf_idCase]) REFERENCES [dbo].[t_Case] ([id]) ON DELETE CASCADE
GO
GRANT SELECT ON  [dbo].[t_Coefficient] TO [db_AccountOMS]
GRANT INSERT ON  [dbo].[t_Coefficient] TO [db_AccountOMS]
GO
