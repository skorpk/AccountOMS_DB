CREATE TABLE [dbo].[t_AdditionalAccounts202003]
(
[CodeLPU] [char] (8) COLLATE Cyrillic_General_CI_AS NULL,
[CodeSMO] [char] (5) COLLATE Cyrillic_General_CI_AS NULL,
[ReportMonth] [tinyint] NULL,
[ReportYear] [smallint] NULL,
[NumberRegister] [tinyint] NULL,
[Letter] [char] (1) COLLATE Cyrillic_General_CI_AS NULL,
[DateRegistration] [datetime2] (3) NULL,
[DateAccount] [date] NULL,
[AmountPayment] [decimal] (15, 2) NULL,
[Account] [varchar] (11) COLLATE Cyrillic_General_CI_AS NULL,
[CodeM] [varchar] (6) COLLATE Cyrillic_General_CI_AS NULL,
[ReportYearMonth] [int] NULL,
[rf_idV006] [int] NULL
) ON [PRIMARY]
GO
