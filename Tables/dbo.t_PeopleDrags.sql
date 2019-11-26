CREATE TABLE [dbo].[t_PeopleDrags]
(
[Fam] [varchar] (14) COLLATE Cyrillic_General_CI_AS NOT NULL,
[Im] [varchar] (10) COLLATE Cyrillic_General_CI_AS NOT NULL,
[Ot] [varchar] (14) COLLATE Cyrillic_General_CI_AS NOT NULL,
[SS] [varchar] (11) COLLATE Cyrillic_General_CI_AS NOT NULL,
[PID] [int] NOT NULL IDENTITY(1, 1)
) ON [PRIMARY]
GO
GRANT SELECT ON  [dbo].[t_PeopleDrags] TO [db_AccountOMS]
GRANT INSERT ON  [dbo].[t_PeopleDrags] TO [db_AccountOMS]
GO
