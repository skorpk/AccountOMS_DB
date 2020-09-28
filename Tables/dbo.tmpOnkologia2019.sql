CREATE TABLE [dbo].[tmpOnkologia2019]
(
[rf_idCase] [bigint] NOT NULL,
[AmountPayment] [decimal] (15, 2) NOT NULL,
[ENP] [varchar] (16) COLLATE Cyrillic_General_CI_AS NULL,
[ReportMonth] [tinyint] NOT NULL,
[ReportYear] [smallint] NOT NULL,
[IdTypeCol12] [int] NOT NULL
) ON [PRIMARY]
GO
