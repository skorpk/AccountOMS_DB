CREATE TABLE [dbo].[sprDate146Order]
(
[ReportMonth] [tinyint] NOT NULL,
[ReportYear] [smallint] NOT NULL,
[DateEnd] [datetime] NOT NULL
) ON [PRIMARY]
GO
GRANT SELECT ON  [dbo].[sprDate146Order] TO [db_AccountOMS]
GRANT INSERT ON  [dbo].[sprDate146Order] TO [db_AccountOMS]
GO
