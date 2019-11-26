SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE VIEW dbo.view_sprRegionTFOMS
AS
SELECT [RegionTFOMSId]
      ,[rf_PropTFOMSId]
      ,[TF_KOD]
      ,[rf_idRegion]
      ,[nameRegion]
      ,[nameRegDop]
      ,[nameTFOMSDop]
  FROM [OMS_NSI].[dbo].[tRegionTFOMS]
GO
GRANT SELECT ON  [dbo].[view_sprRegionTFOMS] TO [db_AccountOMS]
GO
