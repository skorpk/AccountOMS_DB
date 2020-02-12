CREATE TABLE [dbo].[tmp_Case34002]
(
[rf_idCase] [bigint] NOT NULL,
[ENP] [varchar] (16) COLLATE Cyrillic_General_CI_AS NULL,
[AmountPayment] [decimal] (15, 2) NOT NULL,
[CodeM] [varchar] (6) COLLATE Cyrillic_General_CI_AS NULL,
[Account] [varchar] (15) COLLATE Cyrillic_General_CI_AS NULL,
[DateRegistration] [datetime] NOT NULL,
[DateEnd] [date] NOT NULL,
[idRecordCase] [bigint] NOT NULL,
[DateRegister] [date] NOT NULL,
[TypeDisp] [varchar] (3) COLLATE Cyrillic_General_CI_AS NOT NULL,
[rf_idSMO] [char] (5) COLLATE Cyrillic_General_CI_AS NULL
) ON [PRIMARY]
GO
