SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE VIEW [dbo].[vw_sprCSG]
AS
SELECT tCSG.CSGroupId, tCSG.code, tCSG.name,tCSG.rf_CSGTypeId,t1.NAME AS TypeName,SUBSTRING(tCSG.code,3,1) AS GroupCSG,codePGR,dateBeg,dateEnd,codeMinZdrav
,CASE WHEN ISNULL(noLevelCoefficient,0)=0 THEN 1 ELSE 0 END AS NoLevelCoefficient
FROM oms_NSI.dbo.tCSGroup tCSG INNER JOIN oms_NSI.dbo.tCSGType t1 ON
				tCSG.rf_CSGTypeId=t1.CSGTypeId

GO
GRANT SELECT ON  [dbo].[vw_sprCSG] TO [db_AccountOMS]
GO
