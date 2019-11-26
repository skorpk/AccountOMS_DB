SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE VIEW [dbo].[vw_sprV009]
AS 
SELECT id,name,DL_USLOV as USL_OK,DateBeg,DateEnd FROM oms_NSI.dbo.sprV009

GO
GRANT SELECT ON  [dbo].[vw_sprV009] TO [db_AccountOMS]
GO
