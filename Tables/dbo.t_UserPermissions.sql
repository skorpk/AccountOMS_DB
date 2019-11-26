CREATE TABLE [dbo].[t_UserPermissions]
(
[user] [nvarchar] (25) COLLATE Cyrillic_General_CI_AS NOT NULL,
[userName] [nvarchar] (100) COLLATE Cyrillic_General_CI_AS NULL,
[havePermissionToPersonalData] [tinyint] NULL,
[filialPermission] [nchar] (10) COLLATE Cyrillic_General_CI_AS NULL,
[canCopyFromGrid] [tinyint] NULL
) ON [PRIMARY]
GO
GRANT SELECT ON  [dbo].[t_UserPermissions] TO [AccountsOMS]
GRANT SELECT ON  [dbo].[t_UserPermissions] TO [db_AccountOMS]
GRANT INSERT ON  [dbo].[t_UserPermissions] TO [db_AccountOMS]
GO
