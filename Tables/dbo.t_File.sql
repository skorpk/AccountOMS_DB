CREATE TABLE [dbo].[t_File]
(
[GUID] [uniqueidentifier] NOT NULL ROWGUIDCOL CONSTRAINT [DF_GUID_File] DEFAULT (newsequentialid()),
[id] [int] NOT NULL IDENTITY(1, 1) NOT FOR REPLICATION,
[DateRegistration] [datetime] NOT NULL CONSTRAINT [DF_DateRegistration] DEFAULT (getdate()),
[FileVersion] [char] (5) COLLATE Cyrillic_General_CI_AS NOT NULL,
[DateCreate] [date] NOT NULL,
[FileNameHR] [varchar] (26) COLLATE Cyrillic_General_CI_AS NOT NULL,
[FileNameLR] [varchar] (26) COLLATE Cyrillic_General_CI_AS NOT NULL,
[FileZIP] [varbinary] (max) FILESTREAM NULL,
[CodeM] AS (substring([FileNameHR],(3),(6))),
[Insurance] AS (substring([FileNameHR],(9),(1))),
[CountSluch] [int] NULL,
[TypeFile] AS (left([FileNameHR],(1))),
CONSTRAINT [UQ__t_File__15B69B8F164452B1] UNIQUE NONCLUSTERED  ([GUID]) ON [PRIMARY]
) ON [PRIMARY] FILESTREAM_ON [FileStreamGroup]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE TRIGGER [dbo].[DeleteFile]
on [dbo].[t_File]
AFTER Delete
AS
--добавляем Код МУ в t_Meduslugi по законченным случаям
insert t_FileDelete(rf_idFile,FileName)
select distinct d.id,d.FileNameHR
from deleted d
GO
ALTER TABLE [dbo].[t_File] ADD CONSTRAINT [PK__t_File__3213E83F1367E606] PRIMARY KEY CLUSTERED  ([id]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_FileCodeM] ON [dbo].[t_File] ([CodeM]) INCLUDE ([DateRegistration]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_FileName_DateReg] ON [dbo].[t_File] ([DateRegistration]) INCLUDE ([CodeM], [FileNameHR], [id]) ON [PRIMARY]
GO
CREATE UNIQUE NONCLUSTERED INDEX [UQ_FileName] ON [dbo].[t_File] ([FileNameHR]) WITH (IGNORE_DUP_KEY=ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_FileName_ID] ON [dbo].[t_File] ([FileNameHR]) INCLUDE ([id]) ON [PRIMARY]
GO
GRANT SELECT ON  [dbo].[t_File] TO [AccountsOMS]
GRANT SELECT ON  [dbo].[t_File] TO [db_AccountOMS]
GRANT INSERT ON  [dbo].[t_File] TO [db_AccountOMS]
GRANT SELECT ON  [dbo].[t_File] TO [db_AccountsFinancing]
GRANT SELECT ON  [dbo].[t_File] TO [db_Financing]
GRANT SELECT ON  [dbo].[t_File] TO [PDAOR_Executive]
GO
