CREATE TABLE [dbo].[tmpPeople]
(
[PID] [int] NULL,
[FAM] [varchar] (40) COLLATE Cyrillic_General_CI_AS NULL,
[IM] [varchar] (40) COLLATE Cyrillic_General_CI_AS NULL,
[OT] [varchar] (40) COLLATE Cyrillic_General_CI_AS NULL,
[SS] [varchar] (14) COLLATE Cyrillic_General_CI_AS NULL,
[DR] [datetime] NULL,
[DOCTP] [varchar] (3) COLLATE Cyrillic_General_CI_AS NULL,
[DOCS] [varchar] (20) COLLATE Cyrillic_General_CI_AS NULL,
[DOCN] [varchar] (20) COLLATE Cyrillic_General_CI_AS NULL,
[Q] [varchar] (5) COLLATE Cyrillic_General_CI_AS NULL,
[LPU] [varchar] (15) COLLATE Cyrillic_General_CI_AS NULL
) ON [PRIMARY]
GO
