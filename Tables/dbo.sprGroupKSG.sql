CREATE TABLE [dbo].[sprGroupKSG]
(
[GroupID] [int] NOT NULL,
[Name] [varchar] (142) COLLATE Cyrillic_General_CI_AS NOT NULL
) ON [PRIMARY]
GO
GRANT SELECT ON  [dbo].[sprGroupKSG] TO [db_AccountOMS]
GRANT INSERT ON  [dbo].[sprGroupKSG] TO [db_AccountOMS]
GO
