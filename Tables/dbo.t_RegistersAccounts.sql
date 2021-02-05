CREATE TABLE [dbo].[t_RegistersAccounts]
(
[rf_idFiles] [int] NOT NULL,
[id] [int] NOT NULL IDENTITY(1, 1) NOT FOR REPLICATION,
[idRecord] [bigint] NOT NULL,
[rf_idMO] [char] (6) COLLATE Cyrillic_General_CI_AS NOT NULL,
[ReportYear] [smallint] NOT NULL,
[ReportMonth] [tinyint] NOT NULL,
[NumberRegister] [int] NOT NULL,
[PrefixNumberRegister] [char] (5) COLLATE Cyrillic_General_CI_AS NOT NULL,
[PropertyNumberRegister] [tinyint] NOT NULL,
[DateRegister] [date] NOT NULL,
[rf_idSMO] [char] (5) COLLATE Cyrillic_General_CI_AS NULL,
[AmountPayment] [decimal] (15, 2) NOT NULL,
[Comments] [varchar] (250) COLLATE Cyrillic_General_CI_AS NULL,
[AmountPaymentAccept] [decimal] (11, 2) NULL,
[AmountMEK] [decimal] (15, 2) NULL,
[AmountMEE] [decimal] (15, 2) NULL,
[AmountEKMP] [decimal] (15, 2) NULL,
[rf_idRegisterCaseBack] [int] NULL,
[Letter] [char] (1) COLLATE Cyrillic_General_CI_AS NULL,
[Account] AS (((((CONVERT([varchar](5),rtrim([PrefixNumberRegister]),0)+'-')+CONVERT([varchar](6),[NumberRegister],0))+'-')+CONVERT([char](1),[PropertyNumberRegister],0))+isnull([Letter],'')),
[ReportYearMonth] AS (CONVERT([int],CONVERT([char](4),[ReportYear],(0))+right('0'+CONVERT([varchar](2),[ReportMonth],(0)),(2)),(0)))
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[t_RegistersAccounts] ADD CONSTRAINT [CheckMonth] CHECK (([ReportMonth]>(0) AND [ReportMonth]<(13)))
GO
ALTER TABLE [dbo].[t_RegistersAccounts] ADD CONSTRAINT [CheckNumber] CHECK (([NumberRegister]>(0)))
GO
ALTER TABLE [dbo].[t_RegistersAccounts] ADD CONSTRAINT [CheckRegisterDate] CHECK (([DateRegister]<=getdate()))
GO
ALTER TABLE [dbo].[t_RegistersAccounts] WITH NOCHECK ADD CONSTRAINT [CheckYear] CHECK (([ReportYear]>=(datepart(year,getdate())-(1)) AND [ReportYear]<=datepart(year,getdate())))
GO
ALTER TABLE [dbo].[t_RegistersAccounts] NOCHECK CONSTRAINT [CheckYear]
GO
ALTER TABLE [dbo].[t_RegistersAccounts] ADD CONSTRAINT [PK_RegistersAccounts_idFiles_idRegisterCases] PRIMARY KEY CLUSTERED  ([id]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [ra_idx] ON [dbo].[t_RegistersAccounts] ([PrefixNumberRegister]) INCLUDE ([AmountPayment], [DateRegister], [id], [Letter], [NumberRegister], [PropertyNumberRegister], [ReportMonth], [ReportYear], [rf_idFiles], [rf_idSMO]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_ReportYear_Account_ExchangeFinancing] ON [dbo].[t_RegistersAccounts] ([ReportYear], [Account]) INCLUDE ([DateRegister], [id], [Letter], [NumberRegister], [PrefixNumberRegister], [PropertyNumberRegister], [ReportMonth], [rf_idFiles], [rf_idSMO]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_ReportYear_Number] ON [dbo].[t_RegistersAccounts] ([ReportYear], [NumberRegister]) INCLUDE ([rf_idFiles]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_ReportPeriod_IdFiles] ON [dbo].[t_RegistersAccounts] ([ReportYear], [ReportMonth]) INCLUDE ([Account], [AmountPayment], [DateRegister], [PrefixNumberRegister], [rf_idFiles], [rf_idSMO]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IDX_RA_rfidfiles] ON [dbo].[t_RegistersAccounts] ([rf_idFiles]) INCLUDE ([AmountPayment], [DateRegister], [id], [Letter], [NumberRegister], [PrefixNumberRegister], [PropertyNumberRegister], [ReportMonth], [ReportYear], [rf_idSMO]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_Accounts_FinanceInformationReport] ON [dbo].[t_RegistersAccounts] ([rf_idSMO]) INCLUDE ([AmountPayment], [ReportYearMonth], [rf_idFiles]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[t_RegistersAccounts] ADD CONSTRAINT [FK_RegistersAccounts_Files] FOREIGN KEY ([rf_idFiles]) REFERENCES [dbo].[t_File] ([id]) ON DELETE CASCADE
GO
GRANT SELECT ON  [dbo].[t_RegistersAccounts] TO [AccountsOMS]
GRANT SELECT ON  [dbo].[t_RegistersAccounts] TO [db_AccountOMS]
GRANT INSERT ON  [dbo].[t_RegistersAccounts] TO [db_AccountOMS]
GRANT SELECT ON  [dbo].[t_RegistersAccounts] TO [db_AccountsFinancing]
GRANT SELECT ON  [dbo].[t_RegistersAccounts] TO [db_Financing]
GRANT SELECT ON  [dbo].[t_RegistersAccounts] TO [PDAOR_Executive]
GO
