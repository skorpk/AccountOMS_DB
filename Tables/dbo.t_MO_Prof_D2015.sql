CREATE TABLE [dbo].[t_MO_Prof_D2015]
(
[codeMO] [nvarchar] (255) COLLATE Cyrillic_General_CI_AS NULL,
[NameS] [nvarchar] (255) COLLATE Cyrillic_General_CI_AS NULL
) ON [PRIMARY]
GO
GRANT SELECT ON  [dbo].[t_MO_Prof_D2015] TO [db_AccountOMS]
GRANT INSERT ON  [dbo].[t_MO_Prof_D2015] TO [db_AccountOMS]
GO
