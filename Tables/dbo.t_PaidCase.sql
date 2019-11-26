CREATE TABLE [dbo].[t_PaidCase]
(
[rf_idCase] [bigint] NOT NULL,
[DateRegistration] [datetime2] (3) NOT NULL,
[AmountPaymentAccept] [decimal] (15, 2) NOT NULL,
[CodeM] [char] (6) COLLATE Cyrillic_General_CI_AS NOT NULL,
[Letter] [char] (1) COLLATE Cyrillic_General_CI_AS NOT NULL
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_PaidCase_DateReg] ON [dbo].[t_PaidCase] ([DateRegistration]) INCLUDE ([AmountPaymentAccept], [rf_idCase]) ON [PRIMARY]
GO
