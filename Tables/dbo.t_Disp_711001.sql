CREATE TABLE [dbo].[t_Disp_711001]
(
[Fam] [nvarchar] (40) COLLATE Cyrillic_General_CI_AS NULL,
[Im] [nvarchar] (40) COLLATE Cyrillic_General_CI_AS NULL,
[Ot] [nvarchar] (40) COLLATE Cyrillic_General_CI_AS NULL,
[BirthDay] [date] NULL,
[rf_idV005] [tinyint] NOT NULL,
[ENP] [varchar] (16) COLLATE Cyrillic_General_CI_AS NULL,
[SeriaPolis] [varchar] (10) COLLATE Cyrillic_General_CI_AS NULL,
[rf_idF008] [tinyint] NOT NULL,
[NumberPolis] [varchar] (20) COLLATE Cyrillic_General_CI_AS NULL,
[rf_idV006] [tinyint] NOT NULL,
[DateBegin] [date] NOT NULL,
[DateEnd] [date] NOT NULL,
[ReportYear] [smallint] NOT NULL,
[ReportMonth] [tinyint] NOT NULL,
[DateRegister] [date] NOT NULL,
[Account] [varchar] (15) COLLATE Cyrillic_General_CI_AS NULL,
[Letter] [char] (1) COLLATE Cyrillic_General_CI_AS NULL,
[rf_idMO] [char] (6) COLLATE Cyrillic_General_CI_AS NOT NULL,
[rf_idSMO] [char] (5) COLLATE Cyrillic_General_CI_AS NULL,
[DateRegistration] [datetime] NOT NULL,
[Expr1] [decimal] (38, 2) NULL,
[id] [bigint] NOT NULL
) ON [PRIMARY]
GO
