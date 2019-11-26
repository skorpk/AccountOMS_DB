SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE VIEW	[dbo].[vw_MUCSGLetter]
AS
select DISTINCT cast(m.MUGroupCode as varchar(2))+'.'+cast(m.MUUnGroupCode as varchar(2))+'.'+cast(m.MUCode as varchar(3)) as MU
		,m.MUName
		,CASE WHEN a.accountSymbol=' ' THEN NULL ELSE a.accountSymbol END as AccountParam
from oms_NSI.dbo.vw_sprMU m inner join oms_NSI.dbo.tAccountType a on
		m.rf_AccountTypeId=a.AccountTypeId
		UNION ALL
select distinct m.code as MU,m.name,CASE WHEN a.accountSymbol=' ' THEN NULL ELSE a.accountSymbol END as AccountParam
from oms_NSI.dbo.tCSGroup m inner join oms_NSI.dbo.tAccountType a on
		m.rf_AccountTypeId=a.AccountTypeId

GO
GRANT SELECT ON  [dbo].[vw_MUCSGLetter] TO [db_AccountOMS]
GO
