SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE VIEW [dbo].[view_sprF011]
AS
SELECT [ID]
      ,[Name]
      ,[Seria]
      ,[Number]
      ,[DateBeg]
      ,[DateEnd]
      ,[UId]
  FROM [oms_NSI].[dbo].[sprDocumentType]

GO
GRANT SELECT ON  [dbo].[view_sprF011] TO [db_AccountOMS]
GO
