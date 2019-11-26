CREATE TABLE [dbo].[t_CombinationOfSchema]
(
[rf_idCase] [bigint] NOT NULL,
[rf_idV024] [varchar] (10) COLLATE Cyrillic_General_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[t_CombinationOfSchema] ADD CONSTRAINT [FK_CombinationOfSchema_Cases] FOREIGN KEY ([rf_idCase]) REFERENCES [dbo].[t_Case] ([id]) ON DELETE CASCADE
GO
GRANT INSERT ON  [dbo].[t_CombinationOfSchema] TO [db_AccountOMS]
GO
