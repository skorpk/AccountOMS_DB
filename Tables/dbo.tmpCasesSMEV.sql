CREATE TABLE [dbo].[tmpCasesSMEV]
(
[CodeM] [varchar] (6) COLLATE Cyrillic_General_CI_AS NULL,
[OKATO] [char] (5) COLLATE Cyrillic_General_CI_AS NULL,
[ENP] [varchar] (16) COLLATE Cyrillic_General_CI_AS NULL,
[rf_idCase] [bigint] NULL,
[rf_idV006] [tinyint] NULL,
[rf_idV008] [smallint] NULL,
[rf_idV002] [smallint] NULL,
[AmountPayment] [decimal] (15, 2) NULL,
[Account] [varchar] (15) COLLATE Cyrillic_General_CI_AS NULL,
[DateBegin] [date] NULL,
[DateEnd] [date] NULL,
[Mesc] [varchar] (20) COLLATE Cyrillic_General_CI_AS NULL,
[Tariff] [decimal] (15, 2) NULL
) ON [PRIMARY]
GO
