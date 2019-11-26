CREATE TABLE [dbo].[t_Report1FFOMS]
(
[Id] [bigint] NULL,
[rf_idCase] [bigint] NULL,
[ReportMonth] [tinyint] NULL,
[ReportYear] [smallint] NULL,
[C_POKL] [tinyint] NULL,
[Age] [tinyint] NULL,
[NumberCase] [int] NULL,
[DateBegin] [date] NULL,
[P_OTK] [tinyint] NULL,
[PID] [int] NULL,
[AttachLPU] [char] (6) COLLATE Cyrillic_General_CI_AS NULL,
[SNILS_Doc] [varchar] (11) COLLATE Cyrillic_General_CI_AS NULL,
[Sex] [tinyint] NULL,
[DISPName] [varchar] (5) COLLATE Cyrillic_General_CI_AS NULL,
[N_ZAP2] [int] NOT NULL
) ON [PRIMARY]
GO
