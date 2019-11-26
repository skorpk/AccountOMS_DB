SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
create view [dbo].[vw_Diagnosis]
as
select rf_idCase,max(case when TypeDiagnosis=1 then DiagnosisCode else null end) DS1,
		max(case when TypeDiagnosis=2 then DiagnosisCode else null end) DS0,
		max(case when TypeDiagnosis=3 then DiagnosisCode else null end) DS2,		
		max(case when TypeDiagnosis=4 then DiagnosisCode else null end) DS3
from t_Diagnosis
group by rf_idCase
GO
GRANT SELECT ON  [dbo].[vw_Diagnosis] TO [AccountsOMS]
GRANT SELECT ON  [dbo].[vw_Diagnosis] TO [db_AccountOMS]
GO
