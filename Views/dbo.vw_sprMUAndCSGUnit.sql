SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE VIEW [dbo].[vw_sprMUAndCSGUnit]
as
SELECT DISTINCT CAST(MUGroupCode AS varchar(2)) + '.' + CAST(MUUnGroupCode AS varchar(2)) + '.' + CAST(MUCode AS varchar(3)) AS MU,beginDate,endDate,unitCode, IsCompletedCase
FROM         (
				select m.MUId,m.MUGroupCode,m.MUUnGroupCode,m.MUCode
						,unit.unitCode,unit.unitName, unit.beginDate, unit.endDate,m.MUName,m.IsCompletedCase
				from OMS_NSI.dbo.vw_sprMU m	left join (
															SELECT TOP 100 percent mu.rf_MUId,t2.unitCode,t2.UnitName, t.beginDate, t.endDate,t.Flag
															FROM OMS_NSI.dbo.tPlanUnitPeriod t INNER JOIN   OMS_NSI.dbo.tPlanUnit t2 ON
																		t.rf_PlanUnitID=t2.PlanUnitId
																					INNER JOIN oms_nsi.dbo.tMUPlanUnit mu ON
																		t2.PlanUnitId=mu.rf_PlanUnitID
															ORDER BY rf_MUId 
														) unit on
							m.MUId=unit.rf_MUId					 										
			)  t
union ALL
SELECT CSGCode,beginDate,endDate,UnitCode,1 FROM oms_nsi.dbo.vw_CSGPlanUnit WHERE unitCode IN(141,159)
GO
