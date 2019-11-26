CREATE TABLE [dbo].[t_FileSynch]
(
[rf_idFile] [int] NULL,
[DateSynch] [datetime] NULL
) ON [PRIMARY]
GO
CREATE UNIQUE NONCLUSTERED INDEX [UQ_IdFile] ON [dbo].[t_FileSynch] ([rf_idFile]) WITH (IGNORE_DUP_KEY=ON) ON [PRIMARY]
GO
GRANT SELECT ON  [dbo].[t_FileSynch] TO [db_AccountOMS]
GRANT INSERT ON  [dbo].[t_FileSynch] TO [db_AccountOMS]
GO
