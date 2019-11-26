SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE VIEW [dbo].[view_sprMonth]
AS
SELECT [MonthId]
      ,[rf_QuarterId]
      ,[monthName]
  FROM [OMS_NSI].[dbo].[tMonth]
GO
GRANT SELECT ON  [dbo].[view_sprMonth] TO [db_AccountOMS]
GO
