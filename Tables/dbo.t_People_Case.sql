CREATE TABLE [dbo].[t_People_Case]
(
[IDPeople] [bigint] NULL,
[rf_idCase] [bigint] NULL,
[ReportYear] [smallint] NULL
) ON [AccountOMSCase]
GO
GRANT SELECT ON  [dbo].[t_People_Case] TO [db_AccountOMS]
GRANT INSERT ON  [dbo].[t_People_Case] TO [db_AccountOMS]
GO
