CREATE TABLE [dbo].[t_BirthWeight]
(
[rf_idCase] [bigint] NULL,
[BirthWeight] [smallint] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[t_BirthWeight] ADD CONSTRAINT [FK_BirthWeight_Cases] FOREIGN KEY ([rf_idCase]) REFERENCES [dbo].[t_Case] ([id]) ON DELETE CASCADE
GO
GRANT SELECT ON  [dbo].[t_BirthWeight] TO [db_AccountOMS]
GRANT INSERT ON  [dbo].[t_BirthWeight] TO [db_AccountOMS]
GO
