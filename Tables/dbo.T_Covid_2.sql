CREATE TABLE [dbo].[T_Covid_2]
(
[Ид_Пациента] [int] NOT NULL,
[ENP] [varchar] (16) COLLATE Cyrillic_General_CI_AS NULL,
[TypeDiagnosis] [tinyint] NOT NULL,
[DateBegin] [date] NOT NULL,
[DateEnd] [date] NOT NULL,
[DiagnosisCode] [char] (10) COLLATE Cyrillic_General_CI_AS NULL,
[rf_idV006] [tinyint] NOT NULL,
[rf_idV002] [smallint] NOT NULL
) ON [PRIMARY]
GO
