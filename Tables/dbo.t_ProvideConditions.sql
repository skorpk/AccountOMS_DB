CREATE TABLE [dbo].[t_ProvideConditions]
(
[Code] [smallint] NULL,
[ConditionName] [nchar] (50) COLLATE Cyrillic_General_CI_AS NULL
) ON [PRIMARY]
GO
GRANT SELECT ON  [dbo].[t_ProvideConditions] TO [db_AccountOMS]
GRANT INSERT ON  [dbo].[t_ProvideConditions] TO [db_AccountOMS]
GO
