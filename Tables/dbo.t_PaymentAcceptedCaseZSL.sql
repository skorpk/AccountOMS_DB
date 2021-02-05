CREATE TABLE [dbo].[t_PaymentAcceptedCaseZSL]
(
[rf_idCompletedCase] [bigint] NOT NULL,
[DateRegistration] [smalldatetime] NOT NULL,
[idAkt] [int] NOT NULL,
[DocumentDate] [date] NOT NULL,
[DocumentNumber] [varchar] (25) COLLATE Cyrillic_General_CI_AS NOT NULL,
[CodeM] [varchar] (6) COLLATE Cyrillic_General_CI_AS NULL,
[AmountDeduction] [decimal] (15, 2) NOT NULL,
[TypeCheckup] [tinyint] NOT NULL,
[rf_idF006] [tinyint] NULL
) ON [PRIMARY]
GO
