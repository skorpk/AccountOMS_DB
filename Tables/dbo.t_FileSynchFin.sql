CREATE TABLE [dbo].[t_FileSynchFin]
(
[rf_idFile] [int] NULL,
[DateSynch] [datetime] NULL
) ON [PRIMARY]
GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_File] ON [dbo].[t_FileSynchFin] ([rf_idFile]) WITH (IGNORE_DUP_KEY=ON) ON [PRIMARY]
GO
