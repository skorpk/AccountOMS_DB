CREATE TABLE [dbo].[DNVPersons2020]
(
[ENP] [varchar] (16) COLLATE Cyrillic_General_CI_AS NULL,
[PLACE] [tinyint] NULL,
[STEP] [int] NOT NULL,
[SMO] [char] (5) COLLATE Cyrillic_General_CI_AS NULL,
[MO] [char] (6) COLLATE Cyrillic_General_CI_AS NULL,
[FAM] [varchar] (40) COLLATE Cyrillic_General_CI_AS NULL,
[IM] [varchar] (40) COLLATE Cyrillic_General_CI_AS NULL,
[OT] [varchar] (40) COLLATE Cyrillic_General_CI_AS NULL,
[DR] [date] NULL
) ON [PRIMARY]
GO
CREATE CLUSTERED INDEX [ClusteredIndex-20200825-135708] ON [dbo].[DNVPersons2020] ([ENP]) ON [PRIMARY]
GO
