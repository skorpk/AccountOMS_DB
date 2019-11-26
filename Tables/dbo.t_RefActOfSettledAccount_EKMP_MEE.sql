CREATE TABLE [dbo].[t_RefActOfSettledAccount_EKMP_MEE]
(
[rf_idActFileBySMO] [int] NOT NULL,
[CodeSMO] [char] (5) COLLATE Cyrillic_General_CI_AS NULL,
[CodeM] [char] (6) COLLATE Cyrillic_General_CI_AS NULL,
[rf_idAccounts] [int] NULL,
[rf_idCase] [bigint] NULL,
[rf_idAct_Accounts_MEEAndEKMP] [int] NULL,
[CodeA] [int] NULL,
[ReportYear] [smallint] NULL,
[id] [int] NOT NULL IDENTITY(1, 1)
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[t_RefActOfSettledAccount_EKMP_MEE] ADD CONSTRAINT [FK_ActFileAndAccountsMEE_EKMP] FOREIGN KEY ([rf_idActFileBySMO]) REFERENCES [dbo].[t_ActFileBySMO] ([id]) ON DELETE CASCADE
GO
GRANT SELECT ON  [dbo].[t_RefActOfSettledAccount_EKMP_MEE] TO [db_AccountOMS]
GRANT INSERT ON  [dbo].[t_RefActOfSettledAccount_EKMP_MEE] TO [db_AccountOMS]
GO
