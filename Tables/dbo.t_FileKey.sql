CREATE TABLE [dbo].[t_FileKey]
(
[GUID] [uniqueidentifier] NOT NULL ROWGUIDCOL CONSTRAINT [DF_GUID_FileKey] DEFAULT (newsequentialid()),
[rf_idFiles] [int] NULL,
[FileNameKey] [varchar] (30) COLLATE Cyrillic_General_CI_AS NULL,
[FileKey] [varbinary] (max) FILESTREAM NOT NULL,
CONSTRAINT [UQ__t_FileKe__15B69B8F2DB1C7EE] UNIQUE NONCLUSTERED  ([GUID]) ON [PRIMARY]
) ON [PRIMARY] FILESTREAM_ON [FileStreamGroup]
GO
ALTER TABLE [dbo].[t_FileKey] ADD CONSTRAINT [UQ__t_FileKe__8403D6592AD55B43] UNIQUE NONCLUSTERED  ([rf_idFiles]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[t_FileKey] ADD CONSTRAINT [FK_FileKey_Files] FOREIGN KEY ([rf_idFiles]) REFERENCES [dbo].[t_File] ([id]) ON DELETE CASCADE
GO
GRANT SELECT ON  [dbo].[t_FileKey] TO [db_AccountOMS]
GRANT INSERT ON  [dbo].[t_FileKey] TO [db_AccountOMS]
GO
