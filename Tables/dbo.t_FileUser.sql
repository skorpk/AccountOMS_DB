CREATE TABLE [dbo].[t_FileUser]
(
[FileName] [varchar] (26) COLLATE Cyrillic_General_CI_AS NULL,
[UserName] [varchar] (40) COLLATE Cyrillic_General_CI_AS NULL,
[DateOperation] [datetime] NULL
) ON [PRIMARY]
GO
GRANT SELECT ON  [dbo].[t_FileUser] TO [db_AccountOMS]
GRANT INSERT ON  [dbo].[t_FileUser] TO [db_AccountOMS]
GO
