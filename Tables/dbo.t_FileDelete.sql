CREATE TABLE [dbo].[t_FileDelete]
(
[rf_idFile] [int] NOT NULL,
[FileName] [varchar] (26) COLLATE Cyrillic_General_CI_AS NOT NULL,
[DateDelete] [datetime] NOT NULL CONSTRAINT [DF_DateDelete] DEFAULT (getdate()),
[UserName] [varchar] (30) COLLATE Cyrillic_General_CI_AS NOT NULL CONSTRAINT [DF_DeleteUserName] DEFAULT (original_login())
) ON [PRIMARY]
GO
GRANT SELECT ON  [dbo].[t_FileDelete] TO [db_AccountOMS]
GRANT INSERT ON  [dbo].[t_FileDelete] TO [db_AccountOMS]
GO
