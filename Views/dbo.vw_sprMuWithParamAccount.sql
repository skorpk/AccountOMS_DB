SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE view [dbo].[vw_sprMuWithParamAccount]
as
select distinct MUGroupCode,m.MUUnGroupCode,m.MUCode
		,cast(m.MUGroupCode as varchar(2))+'.'+cast(m.MUUnGroupCode as varchar(2))+'.'+cast(m.MUCode as varchar(3)) as MU
		,m.MUName
		,CASE WHEN a.accountSymbol=' ' THEN NULL ELSE a.accountSymbol END as AccountParam
from (select m3.MUId,m1.MUGroupCode,m2.MUUnGroupCode,m3.MUCode,m3.MUName,m3.rf_PlanUnitId,m3.AdultUET,m3.ChildUET
		,case when m3.rf_DiagnosisTypeId=2 then 1 else 3 end as DiagnosisType,m3.ST as IsCompletedCase,ma.rf_AccountTypeId
		,m3.OS as IsSpecialCase
	from oms_nsi.dbo.sprMUGroup m1 inner join oms_nsi.dbo.sprMUUnGroup m2 on
				m1.MUGroupId=m2.rf_MUGroupId 
							inner join oms_nsi.dbo.sprMU m3 on
				m2.MUUnGroupId=m3.rf_MUUnGroupId
							INNER JOIN oms_nsi.dbo.sprMUAccountType ma ON
				m3.MUId=ma.rf_MUId                          
				) m inner join oms_NSI.dbo.tAccountType a on
		m.rf_AccountTypeId=a.AccountTypeId

GO
GRANT SELECT ON  [dbo].[vw_sprMuWithParamAccount] TO [db_AccountOMS]
GO
