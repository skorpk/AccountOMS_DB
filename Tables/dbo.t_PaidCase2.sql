CREATE TABLE [dbo].[t_PaidCase2]
(
[rf_idCase] [bigint] NOT NULL,
[DateRegistration] [datetime2] (3) NOT NULL,
[AmountPaymentAccept] [decimal] (15, 2) NOT NULL,
[CodeM] [char] (6) COLLATE Cyrillic_General_CI_AS NOT NULL,
[Letter] [char] (1) COLLATE Cyrillic_General_CI_AS NOT NULL
) ON [PRIMARY]
GO
