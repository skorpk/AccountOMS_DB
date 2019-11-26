SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE VIEW [dbo].[view_sprMU]
AS
SELECT    
	 [MUId]
    ,[MUGroupCode]
    ,[MUUnGroupCode]
    ,[MUCode]
    ,[MUName]
    ,[rf_PlanUnitId]
    ,[AdultUET]
    ,[ChildUET] 
FROM
	[oms_NSI].[dbo].vw_sprMU


GO
GRANT SELECT ON  [dbo].[view_sprMU] TO [db_AccountOMS]
GO
