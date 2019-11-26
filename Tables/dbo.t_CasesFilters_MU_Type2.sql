CREATE TABLE [dbo].[t_CasesFilters_MU_Type2]
(
[rf_idCase] [bigint] NOT NULL,
[isRejected] [tinyint] NULL,
[isMedIndications] [tinyint] NULL,
[isEarlyMU] [tinyint] NULL
) ON [PRIMARY]
GO
GRANT SELECT ON  [dbo].[t_CasesFilters_MU_Type2] TO [AccountsOMS]
GRANT SELECT ON  [dbo].[t_CasesFilters_MU_Type2] TO [db_AccountOMS]
GO
