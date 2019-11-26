CREATE TABLE [dbo].[t_FileError]
(
[id] [int] NOT NULL IDENTITY(1, 1),
[FileName] [varchar] (26) COLLATE Cyrillic_General_CI_AS NOT NULL,
[DateCreate] [datetime] NOT NULL CONSTRAINT [DF_DateCreate] DEFAULT (getdate())
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[t_FileError] ADD CONSTRAINT [PK__t_FileEr__3213E83F0519C6AF] PRIMARY KEY CLUSTERED  ([id]) ON [PRIMARY]
GO
GRANT SELECT ON  [dbo].[t_FileError] TO [db_AccountOMS]
GRANT INSERT ON  [dbo].[t_FileError] TO [db_AccountOMS]
GO
