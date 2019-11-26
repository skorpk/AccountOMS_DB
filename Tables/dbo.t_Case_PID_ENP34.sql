CREATE TABLE [dbo].[t_Case_PID_ENP34]
(
[rf_idCase] [bigint] NOT NULL,
[PID] [int] NULL,
[ENP] [varchar] (20) COLLATE Cyrillic_General_CI_AS NULL,
[IsLocal] [tinyint] NULL,
[ReportYear] [smallint] NULL
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [ix_idCase] ON [dbo].[t_Case_PID_ENP34] ([rf_idCase]) ON [PRIMARY]
GO
GRANT SELECT ON  [dbo].[t_Case_PID_ENP34] TO [db_AccountOMS]
GRANT INSERT ON  [dbo].[t_Case_PID_ENP34] TO [db_AccountOMS]
GO
