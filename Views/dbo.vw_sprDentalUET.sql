SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE VIEW [dbo].[vw_sprDentalUET]
as
SELECT m.code,SUM(CASE WHEN u.rf_AgeGroupId=1 THEN u.UET ELSE 0 END) AS AdultUET
		,SUM(CASE WHEN u.rf_AgeGroupId=2 THEN u.UET ELSE 0 END) AS ChildUET, 1 AS UnitCode
FROM OMS_NSI.dbo.sprDentalMU m INNER JOIN OMS_NSI.dbo.sprDentalMUUET u ON
				m.DentalMUId=u.rf_DentalMUId
GROUP BY m.code
								                              
GO
GRANT SELECT ON  [dbo].[vw_sprDentalUET] TO [db_AccountOMS]
GO
