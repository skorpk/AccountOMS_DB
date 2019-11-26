CREATE TABLE [dbo].[D_2017]
(
[DateRegistration] [datetime] NOT NULL,
[ReportYear] [smallint] NOT NULL,
[rf_idSMO] [char] (5) COLLATE Cyrillic_General_CI_AS NULL,
[ENP] [varchar] (16) COLLATE Cyrillic_General_CI_AS NULL,
[TypeDisp] [varchar] (3) COLLATE Cyrillic_General_CI_AS NOT NULL,
[rf_idV009] [smallint] NOT NULL,
[rf_idMO] [char] (6) COLLATE Cyrillic_General_CI_AS NOT NULL,
[DateBegin] [date] NOT NULL,
[DateEnd] [date] NOT NULL,
[Age] [smallint] NULL,
[DiagnosisCode] [char] (10) COLLATE Cyrillic_General_CI_AS NULL,
[TypeDiagnosis] [tinyint] NOT NULL,
[IsNeedDisp] [tinyint] NULL,
[IsFirstDS] [tinyint] NULL,
[id] [bigint] NOT NULL,
[Expr1] [decimal] (38, 2) NULL
) ON [PRIMARY]
GO
