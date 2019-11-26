SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
create view [dbo].[vw_unitName]
as
select PlanUnitId,unitCode,unitName from oms_NSI.dbo.tPlanUnit
GO
GRANT SELECT ON  [dbo].[vw_unitName] TO [db_AccountOMS]
GO
