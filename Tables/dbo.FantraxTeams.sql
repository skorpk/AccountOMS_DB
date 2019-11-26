CREATE TABLE [dbo].[FantraxTeams]
(
[DynastyTeam] [nvarchar] (255) COLLATE Cyrillic_General_CI_AS NULL,
[Player] [nvarchar] (255) COLLATE Cyrillic_General_CI_AS NULL,
[NHL Team] [nvarchar] (255) COLLATE Cyrillic_General_CI_AS NULL,
[Eligible] [nvarchar] (255) COLLATE Cyrillic_General_CI_AS NULL,
[Fantasy Points] [float] NULL,
[FPG] [float] NULL,
[GP] [float] NULL,
[Age] [nvarchar] (255) COLLATE Cyrillic_General_CI_AS NULL,
[id] [bigint] NOT NULL IDENTITY(1, 1),
[Pos] [nchar] (3) COLLATE Cyrillic_General_CI_AS NULL
) ON [PRIMARY]
GO
