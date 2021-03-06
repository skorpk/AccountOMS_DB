SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE VIEW [dbo].[vw_sprV004]
AS 
SELECT id,name,CAST('20110101' AS DATE) AS DateBeg, CAST('20160101' AS DATE) AS DateEnd FROM oms_NSI.dbo.sprMedicalSpeciality WHERE Name IS NOT null
UNION ALL
SELECT Code,NAME, CAST('20160101' AS DATE),CAST('20190101' AS DATE)  FROM oms_nsi.dbo.sprV015
UNION ALL
SELECT IDSPEC,SPECNAME, CAST('20190101' AS DATE),DATEEND  FROM oms_nsi.dbo.sprV021

GO
GRANT SELECT ON  [dbo].[vw_sprV004] TO [db_AccountOMS]
GO
