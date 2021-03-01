CREATE TABLE [dbo].[tmpCases_WCF]
(
[rf_idCase] [bigint] NULL,
[CodeM] [char] (6) COLLATE Cyrillic_General_CI_AS NULL,
[rf_idV006] [tinyint] NULL,
[AmountPayment] [decimal] (11, 2) NOT NULL,
[DateBegin] [date] NULL,
[DateEnd] [date] NULL,
[PID] [int] NULL,
[CodeMES] [varchar] (20) COLLATE Cyrillic_General_CI_AS NULL,
[Tariff] [decimal] (15, 2) NULL,
[rf_idV002] [smallint] NULL
) ON [PRIMARY]
GO
