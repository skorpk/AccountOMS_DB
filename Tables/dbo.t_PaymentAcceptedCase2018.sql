CREATE TABLE [dbo].[t_PaymentAcceptedCase2018]
(
[rf_idCase] [bigint] NOT NULL,
[DateRegistration] [datetime2] (3) NOT NULL,
[AmountPaymentAccept] [decimal] (15, 2) NOT NULL,
[CodeM] [char] (6) COLLATE Cyrillic_General_CI_AS NOT NULL,
[Letter] [char] (1) COLLATE Cyrillic_General_CI_AS NULL,
[AmountDeduction] [decimal] (12, 2) NULL
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_PaymentAccepted_DateReg_idCase] ON [dbo].[t_PaymentAcceptedCase2018] ([DateRegistration]) INCLUDE ([AmountDeduction], [rf_idCase]) ON [PRIMARY]
GO
