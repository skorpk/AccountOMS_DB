CREATE TABLE [dbo].[t_Report2FFOMS]
(
[rf_idCase] [bigint] NULL,
[ReportMonth] [tinyint] NULL,
[ReportYear] [smallint] NULL,
[C_POKL] [tinyint] NULL,
[Agge] [tinyint] NULL,
[Sex] [tinyint] NULL,
[ENP] [varchar] (20) COLLATE Cyrillic_General_CI_AS NULL,
[DR] [date] NULL,
[NumberCase] [int] NULL,
[DateBegin] [date] NULL,
[DateEnd] [date] NULL,
[rf_idV006] [tinyint] NULL,
[rf_idV008] [smallint] NULL,
[AmountPayment] [decimal] (11, 2) NULL,
[AmountDeduction] [decimal] (11, 2) NOT NULL,
[PID] [int] NULL,
[DS1] [varchar] (6) COLLATE Cyrillic_General_CI_AS NULL,
[N_ZAP] [int] NOT NULL IDENTITY(1, 1)
) ON [PRIMARY]
GO
GRANT SELECT ON  [dbo].[t_Report2FFOMS] TO [db_AccountOMS]
GRANT INSERT ON  [dbo].[t_Report2FFOMS] TO [db_AccountOMS]
GO
