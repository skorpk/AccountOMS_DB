CREATE TABLE [dbo].[t_CasesFilters_DS_Type2]
(
[rf_idCase] [bigint] NOT NULL,
[isDObservation] [tinyint] NULL,
[isDTaken] [tinyint] NULL
) ON [PRIMARY]
GO
GRANT SELECT ON  [dbo].[t_CasesFilters_DS_Type2] TO [AccountsOMS]
GRANT SELECT ON  [dbo].[t_CasesFilters_DS_Type2] TO [db_AccountOMS]
GO
