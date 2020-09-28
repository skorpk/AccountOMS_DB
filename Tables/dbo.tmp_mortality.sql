CREATE TABLE [dbo].[tmp_mortality]
(
[IdRow] [bigint] NULL,
[ENP] [varchar] (16) COLLATE Cyrillic_General_CI_AS NULL,
[DR] [date] NULL,
[W] [varchar] (1) COLLATE Cyrillic_General_CI_AS NOT NULL,
[DS] [date] NOT NULL,
[ReportYearMonth] [int] NULL,
[IsResident] [int] NOT NULL,
[N] [varchar] (8) COLLATE Cyrillic_General_CI_AS NULL
) ON [PRIMARY]
GO
