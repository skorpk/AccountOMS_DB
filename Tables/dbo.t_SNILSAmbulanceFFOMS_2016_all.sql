CREATE TABLE [dbo].[t_SNILSAmbulanceFFOMS_2016_all]
(
[rf_idCase] [bigint] NULL,
[DateBeg] [date] NULL,
[PID] [int] NULL,
[SNILS_Doc] [varchar] (11) COLLATE Cyrillic_General_CI_AS NULL,
[AttachLPU] [char] (6) COLLATE Cyrillic_General_CI_AS NULL,
[Sex] [tinyint] NULL,
[Age] [tinyint] NULL,
[NumberCase] [int] NULL,
[rf_idV006] [tinyint] NULL,
[rf_idV008] [smallint] NULL,
[rf_idV009] [smallint] NULL,
[ReportMonth] [tinyint] NULL,
[ReportYear] [smallint] NULL,
[id] [int] NULL,
[C_POKL] [tinyint] NULL,
[DS] [varchar] (10) COLLATE Cyrillic_General_CI_AS NULL
) ON [PRIMARY]
GO
