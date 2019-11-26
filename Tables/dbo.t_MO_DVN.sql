CREATE TABLE [dbo].[t_MO_DVN]
(
[MOCODE] [char] (6) COLLATE Cyrillic_General_CI_AS NULL,
[MONAME] [nchar] (255) COLLATE Cyrillic_General_CI_AS NULL
) ON [PRIMARY]
GO
GRANT SELECT ON  [dbo].[t_MO_DVN] TO [db_AccountOMS]
GRANT INSERT ON  [dbo].[t_MO_DVN] TO [db_AccountOMS]
GO
