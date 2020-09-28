CREATE TABLE [dbo].[tmpPeopleDN_2020]
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
[IsDNType] [tinyint] NOT NULL CONSTRAINT [DF__tmpPeople__IsDNT__1FDA4091] DEFAULT ((1)),
[LPU] [char] (6) COLLATE Cyrillic_General_CI_AS NULL,
[Q] [char] (5) COLLATE Cyrillic_General_CI_AS NULL,
[PID] [int] NULL,
[sid] [int] NULL,
[lid] [int] NULL,
[dd] [date] NOT NULL CONSTRAINT [DF__tmpPeopleDN___dd__20CE64CA] DEFAULT ('20200701'),
[Col8] [tinyint] NULL,
[Col9] [date] NULL
) ON [PRIMARY]
GO
