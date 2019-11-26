CREATE TABLE [dbo].[t_SendingFileToFFOMS]
(
[id] [int] NOT NULL IDENTITY(1, 1),
[NameFile] [varchar] (12) COLLATE Cyrillic_General_CI_AS NULL,
[ReportMonth] [tinyint] NULL,
[ReportYear] [smallint] NULL,
[DateCreate] [datetime] NOT NULL CONSTRAINT [DF__t_Sending__DateC__607D3EDD] DEFAULT (getdate()),
[NumberOfEndFile] [tinyint] NULL,
[TypeFile] AS (substring([NameFile],(1),(5))),
[UserName] [varchar] (50) COLLATE Cyrillic_General_CI_AS NULL
) ON [PRIMARY]
GO
GRANT SELECT ON  [dbo].[t_SendingFileToFFOMS] TO [db_AccountOMS]
GRANT INSERT ON  [dbo].[t_SendingFileToFFOMS] TO [db_AccountOMS]
GO
