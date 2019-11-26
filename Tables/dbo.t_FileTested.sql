CREATE TABLE [dbo].[t_FileTested]
(
[id] [int] NOT NULL IDENTITY(1, 1),
[DateRegistration] [datetime] NOT NULL CONSTRAINT [DF_DateRegistrationFileTested] DEFAULT (getdate()),
[FileName] [varchar] (50) COLLATE Cyrillic_General_CI_AS NOT NULL,
[UserName] [varchar] (30) COLLATE Cyrillic_General_CI_AS NOT NULL CONSTRAINT [DF_UserName] DEFAULT (original_login()),
[ErrorDescription] [nvarchar] (250) COLLATE Cyrillic_General_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[t_FileTested] ADD CONSTRAINT [PK__t_FileTe__3213E83F09DE7BCC] PRIMARY KEY CLUSTERED  ([id]) ON [PRIMARY]
GO
GRANT SELECT ON  [dbo].[t_FileTested] TO [db_AccountOMS]
GRANT INSERT ON  [dbo].[t_FileTested] TO [db_AccountOMS]
GO
