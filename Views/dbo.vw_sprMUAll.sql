SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE view [dbo].[vw_sprMUAll]
as
select cast(MUGroupCode as varchar(2))+'.'+cast(MUUnGroupCode as varchar(2))+'.'+cast(MUCode as varchar(3)) as MU,AdultUET,ChildUET,unitCode,unitName,
		Profile,AgeGroupShortName,cast(MUGroupCodeP as varchar(2))+'.'+cast(MUUnGroupCodeP as varchar(2))+'.'+cast(MUCodeP as varchar(3)) as MU_P,
		MUName
from oms_NSI.dbo.vw_sprMUAll

GO
GRANT SELECT ON  [dbo].[vw_sprMUAll] TO [db_AccountOMS]
GO
