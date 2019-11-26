CREATE TABLE [dbo].[t_SystemError]
(
[FileName] [varchar] (26) COLLATE Cyrillic_General_CI_AS NULL,
[DateOperation] [datetime] NULL,
[ERROR] [varchar] (100) COLLATE Cyrillic_General_CI_AS NULL
) ON [PRIMARY]
GO
GRANT SELECT ON  [dbo].[t_SystemError] TO [db_AccountOMS]
GRANT INSERT ON  [dbo].[t_SystemError] TO [db_AccountOMS]
GO
