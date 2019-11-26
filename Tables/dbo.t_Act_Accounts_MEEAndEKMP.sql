CREATE TABLE [dbo].[t_Act_Accounts_MEEAndEKMP]
(
[id] [bigint] NULL,
[CodeM] [varchar] (6) COLLATE Cyrillic_General_CI_AS NOT NULL,
[NumAct] [varchar] (25) COLLATE Cyrillic_General_CI_AS NULL,
[DateAct] [date] NULL,
[TypeEx] [varchar] (4) COLLATE Cyrillic_General_CI_AS NOT NULL,
[TypeCheckup] [tinyint] NULL,
[OrderCheckup] [int] NOT NULL,
[Account] [varchar] (15) COLLATE Cyrillic_General_CI_AS NOT NULL,
[NumberCase] [int] NOT NULL,
[Deduction] [decimal] (11, 2) NULL,
[Reason] [varchar] (5) COLLATE Cyrillic_General_CI_AS NULL,
[DateAccount] [date] NULL,
[rf_idAccount] [bigint] NULL,
[rf_idCase] [bigint] NULL,
[CodeReason] [tinyint] NULL
) ON [PRIMARY]
GO
GRANT SELECT ON  [dbo].[t_Act_Accounts_MEEAndEKMP] TO [db_AccountOMS]
GRANT INSERT ON  [dbo].[t_Act_Accounts_MEEAndEKMP] TO [db_AccountOMS]
GO
