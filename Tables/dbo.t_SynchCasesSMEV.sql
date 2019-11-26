CREATE TABLE [dbo].[t_SynchCasesSMEV]
(
[rf_idCase] [bigint] NULL
) ON [PRIMARY]
GO
CREATE UNIQUE CLUSTERED INDEX [PK_RF_ID_CASE] ON [dbo].[t_SynchCasesSMEV] ([rf_idCase]) ON [PRIMARY]
GO
