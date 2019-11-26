SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE VIEW [dbo].[view_sprV004]
AS
SELECT [Id]
      ,[Name]
      ,[DateBeg]
      ,[DateEnd]
      ,[UId]
  FROM [oms_NSI].[dbo].[sprMedicalSpeciality]

GO
GRANT SELECT ON  [dbo].[view_sprV004] TO [db_AccountOMS]
GO
