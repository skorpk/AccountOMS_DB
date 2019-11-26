SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

/****** Object:  View [dbo].[vw_sprMUAll]    Script Date: 16.02.2016 11:15:41 ******/
CREATE VIEW [dbo].[vw_sprMU_2]
AS
select m3.MUId,m1.MUGroupCode,m2.MUUnGroupCode,m3.MUCode,m3.MUName,m3.ST as IsCompletedCase,m3.rf_AccountTypeId
		,m3.OS as IsSpecialCase
from oms_nsi.dbo.sprMUGroup m1 inner join oms_nsi.dbo.sprMUUnGroup m2 on
			m1.MUGroupId=m2.rf_MUGroupId 
						inner join oms_nsi.dbo.sprMU m3 on
			m2.MUUnGroupId=m3.rf_MUUnGroupId
WHERE MUGroupCode=2



GO
GRANT SELECT ON  [dbo].[vw_sprMU_2] TO [db_AccountOMS]
GO
