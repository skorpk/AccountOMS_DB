CREATE TABLE [dbo].[t_RefActOfSettledAccountBySMO]
(
[rf_idActFileBySMO] [int] NOT NULL,
[CodeSMO] [char] (5) COLLATE Cyrillic_General_CI_AS NULL,
[CodeM] [char] (6) COLLATE Cyrillic_General_CI_AS NULL,
[NumberAct] [int] NULL,
[rf_idAccounts] [int] NULL,
[DateAct] [date] NULL,
[ReportYear] [smallint] NULL,
[CodeA] [int] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[t_RefActOfSettledAccountBySMO] ADD CONSTRAINT [FK_ActFileAndAccounts] FOREIGN KEY ([rf_idActFileBySMO]) REFERENCES [dbo].[t_ActFileBySMO] ([id]) ON DELETE CASCADE
GO
GRANT SELECT ON  [dbo].[t_RefActOfSettledAccountBySMO] TO [db_AccountOMS]
GRANT INSERT ON  [dbo].[t_RefActOfSettledAccountBySMO] TO [db_AccountOMS]
GO
