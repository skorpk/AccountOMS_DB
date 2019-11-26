SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE VIEW [dbo].[view_sprV002]
AS 
SELECT [Id]
      ,[Name]
      ,[DateBeg]
      ,[DateEnd]
  FROM [oms_NSI].[dbo].[sprV002]

GO
GRANT SELECT ON  [dbo].[view_sprV002] TO [db_AccountOMS]
GO
