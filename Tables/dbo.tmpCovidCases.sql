CREATE TABLE [dbo].[tmpCovidCases]
(
[CodeM] [varchar] (6) COLLATE Cyrillic_General_CI_AS NULL,
[filialCode] [int] NULL,
[LPU] [varchar] (259) COLLATE Cyrillic_General_CI_AS NULL,
[Account] [varchar] (15) COLLATE Cyrillic_General_CI_AS NULL,
[DateAccount] [date] NOT NULL,
[idRecordCase] [bigint] NOT NULL,
[DateBegin] [date] NOT NULL,
[DateEnd] [date] NOT NULL,
[AmountPayment] [money] NULL,
[V006] [varchar] (11) COLLATE Cyrillic_General_CI_AS NOT NULL,
[FIO] [nvarchar] (122) COLLATE Cyrillic_General_CI_AS NULL,
[BirthDay] [date] NULL,
[Sex] [varchar] (1) COLLATE Cyrillic_General_CI_AS NOT NULL,
[SNILS] [char] (14) COLLATE Cyrillic_General_CI_AS NOT NULL,
[ENP] [varchar] (16) COLLATE Cyrillic_General_CI_AS NULL,
[TypePolis] [varchar] (254) COLLATE Cyrillic_General_CI_AS NULL,
[NumberPolis] [varchar] (20) COLLATE Cyrillic_General_CI_AS NULL,
[DS1] [char] (10) COLLATE Cyrillic_General_CI_AS NULL,
[DS2] [char] (10) COLLATE Cyrillic_General_CI_AS NULL,
[RSLT] [varchar] (254) COLLATE Cyrillic_General_CI_AS NULL,
[ISHOD] [varchar] (254) COLLATE Cyrillic_General_CI_AS NULL
) ON [PRIMARY]
GO
