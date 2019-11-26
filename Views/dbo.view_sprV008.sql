SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE VIEW [dbo].[view_sprV008]
AS 
SELECT [Id]
      ,[Name]
      ,[DateBeg]
      ,[DateEnd]
  FROM [oms_NSI].[dbo].[sprV008]

GO
GRANT SELECT ON  [dbo].[view_sprV008] TO [db_AccountOMS]
GO
