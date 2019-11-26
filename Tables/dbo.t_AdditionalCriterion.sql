CREATE TABLE [dbo].[t_AdditionalCriterion]
(
[rf_idCase] [bigint] NOT NULL,
[rf_idAddCretiria] [varchar] (20) COLLATE Cyrillic_General_CI_AS NOT NULL
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_Criterion] ON [dbo].[t_AdditionalCriterion] ([rf_idCase]) INCLUDE ([rf_idAddCretiria]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[t_AdditionalCriterion] ADD CONSTRAINT [FK_AdditionalCriterion_Cases] FOREIGN KEY ([rf_idCase]) REFERENCES [dbo].[t_Case] ([id]) ON DELETE CASCADE
GO
GRANT SELECT ON  [dbo].[t_AdditionalCriterion] TO [db_AccountOMS]
GRANT INSERT ON  [dbo].[t_AdditionalCriterion] TO [db_AccountOMS]
GRANT DELETE ON  [dbo].[t_AdditionalCriterion] TO [db_AccountOMS]
GO
