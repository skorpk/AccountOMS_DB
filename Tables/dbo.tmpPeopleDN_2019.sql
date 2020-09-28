CREATE TABLE [dbo].[tmpPeopleDN_2019]
(
[rf_idCase] [bigint] NOT NULL,
[ENP] [varchar] (16) COLLATE Cyrillic_General_CI_AS NULL,
[ReportYear] [smallint] NOT NULL,
[DS1] [char] (10) COLLATE Cyrillic_General_CI_AS NULL,
[DateEnd] [date] NOT NULL,
[W] [char] (1) COLLATE Cyrillic_General_CI_AS NULL,
[id] [int] NOT NULL IDENTITY(1, 1),
[MainDS] [varchar] (4) COLLATE Cyrillic_General_CI_AS NULL,
[idRow] [int] NULL,
[IsDNType] [tinyint] NOT NULL CONSTRAINT [DF__tmpPeople__IsDNT__18391EC9] DEFAULT ((1)),
[LPU] [char] (6) COLLATE Cyrillic_General_CI_AS NULL,
[Q] [char] (5) COLLATE Cyrillic_General_CI_AS NULL,
[PID] [int] NULL,
[sid] [int] NULL,
[lid] [int] NULL,
[dd] [date] NOT NULL CONSTRAINT [DF__tmpPeopleDN___dd__192D4302] DEFAULT ('20200101'),
[Col8] [tinyint] NULL,
[Col9] [date] NULL
) ON [PRIMARY]
GO
