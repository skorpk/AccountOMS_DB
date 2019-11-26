SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE view [dbo].[vw_sprCSGWithParamAccount]
as
select distinct m.code as MU,m.name,CASE WHEN a.accountSymbol=' ' THEN NULL ELSE a.accountSymbol END as AccountParam,AccountTypeId
from oms_NSI.dbo.tCSGroup m inner join oms_NSI.dbo.tAccountType a on
		m.rf_AccountTypeId=a.AccountTypeId

GO
GRANT SELECT ON  [dbo].[vw_sprCSGWithParamAccount] TO [db_AccountOMS]
GO
