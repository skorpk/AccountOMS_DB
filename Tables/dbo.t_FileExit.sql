CREATE TABLE [dbo].[t_FileExit]
(
[rf_idFile] [int] NOT NULL,
[FileName] [varchar] (26) COLLATE Cyrillic_General_CI_AS NOT NULL,
[DateUnLoad] [datetime] NOT NULL CONSTRAINT [DF_DateUnLoad] DEFAULT (getdate()),
[UserName] [varchar] (30) COLLATE Cyrillic_General_CI_AS NOT NULL CONSTRAINT [DF_UnLoadUserName] DEFAULT (original_login()),
[SMO] AS (substring([FileName],(10),(5)))
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_rf_idFile] ON [dbo].[t_FileExit] ([rf_idFile]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[t_FileExit] ADD CONSTRAINT [FK_FileExit_Files] FOREIGN KEY ([rf_idFile]) REFERENCES [dbo].[t_File] ([id]) ON DELETE CASCADE
GO
GRANT SELECT ON  [dbo].[t_FileExit] TO [db_AccountOMS]
GRANT INSERT ON  [dbo].[t_FileExit] TO [db_AccountOMS]
GO
