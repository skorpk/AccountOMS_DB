CREATE TABLE [dbo].[T_ZAPROS_18_04_2018]
(
[ReportYear] [smallint] NOT NULL,
[rf_idSMO] [char] (5) COLLATE Cyrillic_General_CI_AS NULL,
[rf_idV006] [tinyint] NOT NULL,
[DS] [varchar] (3) COLLATE Cyrillic_General_CI_AS NULL,
[TypeDiagnosis] [tinyint] NOT NULL,
[rf_idV002] [smallint] NOT NULL,
[KOL] [int] NULL,
[id] [bigint] NOT NULL,
[SUMMA_PR] [decimal] (38, 2) NULL
) ON [PRIMARY]
GO
