CREATE TYPE [dbo].[TVP_ReportMO] AS TABLE
(
[id] [int] NULL,
[isfault] [bit] NULL
)
GO
GRANT EXECUTE ON TYPE:: [dbo].[TVP_ReportMO] TO [db_AccountOMS]
GO
