SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE view [dbo].[vw_TotalDoubleGUID]
as
select c.rf_idMO,a.ReportMonth,a.PrefixNumberRegister,a.NumberRegister,a.PropertyNumberRegister,a.ReportYear,SUM(c1.TotalRows) as TotalRows
from t_Case c inner join (
							select GUID_Case,COUNT(*) as TotalRows
							from t_Case 
							group by GUID_Case 
							having COUNT(*)>1
						  ) c1 on c.GUID_Case=c1.GUID_Case
				inner join t_RecordCasePatient r on
			c.rf_idRecordCasePatient=r.id
				inner join t_RegistersAccounts a on
			r.rf_idRegistersAccounts=a.id
group by c.rf_idMO,a.ReportMonth,a.PrefixNumberRegister,a.NumberRegister,a.PropertyNumberRegister,a.ReportYear
GO
GRANT SELECT ON  [dbo].[vw_TotalDoubleGUID] TO [db_AccountOMS]
GO
