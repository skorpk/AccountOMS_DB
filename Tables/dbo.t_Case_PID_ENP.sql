CREATE TABLE [dbo].[t_Case_PID_ENP]
(
[rf_idCase] [bigint] NOT NULL,
[PID] [int] NULL,
[ENP] [varchar] (20) COLLATE Cyrillic_General_CI_AS NULL,
[IsLocal] [tinyint] NULL,
[ReportYear] [smallint] NULL
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_PID_Year2] ON [dbo].[t_Case_PID_ENP] ([PID], [ReportYear]) INCLUDE ([ENP], [rf_idCase]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_Case_ID] ON [dbo].[t_Case_PID_ENP] ([rf_idCase]) INCLUDE ([ENP], [PID]) ON [PRIMARY]
GO
GRANT SELECT ON  [dbo].[t_Case_PID_ENP] TO [db_AccountOMS]
GRANT INSERT ON  [dbo].[t_Case_PID_ENP] TO [db_AccountOMS]
GRANT SELECT ON  [dbo].[t_Case_PID_ENP] TO [PDAOR_Executive]
GO
