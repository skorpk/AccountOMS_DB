CREATE TABLE [dbo].[t_DirectionMU]
(
[rf_idCase] [bigint] NOT NULL,
[DirectionDate] [date] NOT NULL,
[TypeDirection] [tinyint] NOT NULL,
[MethodStudy] [tinyint] NULL,
[DirectionMU] [varchar] (15) COLLATE Cyrillic_General_CI_AS NULL,
[DirectionMO] [varchar] (6) COLLATE Cyrillic_General_CI_AS NULL
) ON [PRIMARY]
GO
GRANT SELECT ON  [dbo].[t_DirectionMU] TO [db_AccountOMS]
GRANT INSERT ON  [dbo].[t_DirectionMU] TO [db_AccountOMS]
GO
