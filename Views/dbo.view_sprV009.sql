SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE VIEW [dbo].[view_sprV009]
AS
SELECT [Id]
      ,[Name]
      ,[DL_USLOV]
      ,[DateBeg]
      ,[DateEnd]
  FROM [oms_NSI].[dbo].[sprV009]
GO
GRANT SELECT ON  [dbo].[view_sprV009] TO [db_AccountOMS]
GO
