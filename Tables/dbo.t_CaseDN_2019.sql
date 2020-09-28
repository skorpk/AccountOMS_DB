CREATE TABLE [dbo].[t_CaseDN_2019]
(
[rf_idCase] [bigint] NOT NULL,
[AmountPayment] [decimal] (15, 2) NULL,
[CodeM] [varchar] (6) COLLATE Cyrillic_General_CI_AS NULL,
[ENP] [varchar] (16) COLLATE Cyrillic_General_CI_AS NULL,
[Age] [int] NULL,
[USL_OK] [tinyint] NOT NULL,
[rf_idRecordCasePatient] [int] NOT NULL,
[Sex] [tinyint] NOT NULL,
[flag] [float] NULL,
[TypeFile] [varchar] (1) COLLATE Cyrillic_General_CI_AS NULL,
[TypeDs] [int] NOT NULL,
[ReportYear] [smallint] NULL,
[rf_idCompletedCase] [int] NOT NULL
) ON [PRIMARY]
GO
