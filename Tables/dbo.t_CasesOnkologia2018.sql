CREATE TABLE [dbo].[t_CasesOnkologia2018]
(
[rf_idCase] [bigint] NOT NULL,
[ENP] [varchar] (16) COLLATE Cyrillic_General_CI_AS NULL,
[ReportYear] [smallint] NULL
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_ENP_Year] ON [dbo].[t_CasesOnkologia2018] ([ENP]) INCLUDE ([ReportYear]) ON [PRIMARY]
GO
