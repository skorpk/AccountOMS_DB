CREATE TABLE [dbo].[tmpOnkologia2020_GOOD]
(
[rf_idCase] [bigint] NOT NULL,
[AmountPayment] [decimal] (15, 2) NOT NULL,
[ENP] [varchar] (16) COLLATE Cyrillic_General_CI_AS NULL,
[ReportMonth] [tinyint] NULL,
[ReportYear] [smallint] NULL,
[IdTypeCol12] [int] NOT NULL,
[dd] [date] NULL,
[LPU] [char] (6) COLLATE Cyrillic_General_CI_AS NULL,
[Q] [char] (5) COLLATE Cyrillic_General_CI_AS NULL,
[PID] [int] NULL,
[sid] [int] NULL,
[lid] [int] NULL
) ON [PRIMARY]
GO
