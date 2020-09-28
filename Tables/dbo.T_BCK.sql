CREATE TABLE [dbo].[T_BCK]
(
[SNILS] [char] (14) COLLATE Cyrillic_General_CI_AS NULL,
[ENP] [varchar] (16) COLLATE Cyrillic_General_CI_AS NULL,
[Fam] [nvarchar] (40) COLLATE Cyrillic_General_CI_AS NULL,
[Im] [nvarchar] (40) COLLATE Cyrillic_General_CI_AS NULL,
[Ot] [nvarchar] (40) COLLATE Cyrillic_General_CI_AS NULL,
[BirthDay] [date] NULL,
[rf_idV005] [tinyint] NOT NULL,
[DateBegin] [date] NOT NULL,
[DateEnd] [date] NOT NULL,
[rf_idMO] [char] (6) COLLATE Cyrillic_General_CI_AS NOT NULL,
[rf_idSMO] [char] (5) COLLATE Cyrillic_General_CI_AS NULL,
[DateRegistration] [datetime] NOT NULL,
[id] [bigint] NOT NULL,
[AttachLPU] [char] (6) COLLATE Cyrillic_General_CI_AS NULL,
[Code] [nvarchar] (255) COLLATE Cyrillic_General_CI_AS NULL,
[Name] [nvarchar] (255) COLLATE Cyrillic_General_CI_AS NULL
) ON [PRIMARY]
GO
