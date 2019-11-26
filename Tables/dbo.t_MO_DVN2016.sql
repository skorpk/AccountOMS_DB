CREATE TABLE [dbo].[t_MO_DVN2016]
(
[codeMO] [nvarchar] (255) COLLATE Cyrillic_General_CI_AS NULL,
[NameS] [nvarchar] (255) COLLATE Cyrillic_General_CI_AS NULL
) ON [PRIMARY]
GO
GRANT SELECT ON  [dbo].[t_MO_DVN2016] TO [db_AccountOMS]
GRANT INSERT ON  [dbo].[t_MO_DVN2016] TO [db_AccountOMS]
GO
