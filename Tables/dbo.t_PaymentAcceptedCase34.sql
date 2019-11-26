CREATE TABLE [dbo].[t_PaymentAcceptedCase34]
(
[rf_idCase] [bigint] NULL,
[DateRegistration] [datetime] NULL,
[AmountPaymentAccept] [numeric] (1, 1) NOT NULL,
[CodeM] [varchar] (6) COLLATE Cyrillic_General_CI_AS NULL,
[Letter] [char] (1) COLLATE Cyrillic_General_CI_AS NULL,
[AmountDeduction] [decimal] (17, 2) NULL
) ON [PRIMARY]
GO
