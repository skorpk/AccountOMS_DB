CREATE TABLE [dbo].[t_DS_ReCode]
(
[DS_W] [varchar] (6) COLLATE Cyrillic_General_CI_AS NOT NULL,
[DS_T] [varchar] (5) COLLATE Cyrillic_General_CI_AS NULL
) ON [PRIMARY]
GO
GRANT SELECT ON  [dbo].[t_DS_ReCode] TO [db_AccountOMS]
GRANT INSERT ON  [dbo].[t_DS_ReCode] TO [db_AccountOMS]
GO
