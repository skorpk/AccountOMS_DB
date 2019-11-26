CREATE TABLE [dbo].[t1]
(
[rf_idCase] [bigint] NULL
) ON [PRIMARY]
GO
GRANT SELECT ON  [dbo].[t1] TO [db_AccountOMS]
GRANT INSERT ON  [dbo].[t1] TO [db_AccountOMS]
GO
