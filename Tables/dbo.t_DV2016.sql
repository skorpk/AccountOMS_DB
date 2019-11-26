CREATE TABLE [dbo].[t_DV2016]
(
[SeriaPolis] [varchar] (10) COLLATE Cyrillic_General_CI_AS NULL,
[NumberPolis] [varchar] (20) COLLATE Cyrillic_General_CI_AS NULL,
[rf_idV006] [tinyint] NOT NULL,
[DateBegin] [date] NOT NULL,
[DateEnd] [date] NOT NULL,
[DiagnosisCode] [char] (10) COLLATE Cyrillic_General_CI_AS NULL,
[Expr1] [int] NULL
) ON [PRIMARY]
GO
