CREATE TABLE [dbo].[t_PaymentAcceptedCase2]
(
[rf_idCase] [bigint] NOT NULL,
[DateRegistration] [datetime] NOT NULL,
[idAkt] [int] NOT NULL,
[DocumentDate] [date] NOT NULL,
[DocumentNumber] [varchar] (25) COLLATE Cyrillic_General_CI_AS NOT NULL,
[CodeM] [char] (6) COLLATE Cyrillic_General_CI_AS NOT NULL,
[Letter] [char] (1) COLLATE Cyrillic_General_CI_AS NOT NULL,
[AmountMEK] [decimal] (12, 2) NOT NULL,
[AmountMEE] [decimal] (12, 2) NOT NULL,
[AmountEKMP] [decimal] (12, 2) NOT NULL,
[OrderCheckup] [tinyint] NULL,
[TypeCheckup] [tinyint] NULL,
[AmountDeduction] AS (([AmountMEK]+[AmountMEE])+[AmountEKMP])
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_WCF] ON [dbo].[t_PaymentAcceptedCase2] ([DateRegistration]) INCLUDE ([AmountEKMP], [AmountMEE], [AmountMEK], [rf_idCase]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_PaymentDateRegIDCase] ON [dbo].[t_PaymentAcceptedCase2] ([rf_idCase], [DateRegistration]) INCLUDE ([AmountDeduction], [idAkt]) ON [PRIMARY]
GO
CREATE UNIQUE NONCLUSTERED INDEX [UQ_IdCase_IdAkt] ON [dbo].[t_PaymentAcceptedCase2] ([rf_idCase], [idAkt]) INCLUDE ([DateRegistration], [TypeCheckup]) WITH (IGNORE_DUP_KEY=ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_TypeCheckup_Date] ON [dbo].[t_PaymentAcceptedCase2] ([TypeCheckup], [DateRegistration]) INCLUDE ([AmountDeduction], [rf_idCase]) ON [PRIMARY]
GO
GRANT SELECT ON  [dbo].[t_PaymentAcceptedCase2] TO [db_AccountOMS]
GO
