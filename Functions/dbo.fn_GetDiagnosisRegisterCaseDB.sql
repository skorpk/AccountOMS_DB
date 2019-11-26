SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE FUNCTION [dbo].[fn_GetDiagnosisRegisterCaseDB](@rf_idCase bigint)
RETURNS @DS TABLE (
					rf_idCase bigint, 
					DS0 varchar(6),
					DS1 varchar(6),
					DS2 varchar(6)
				  )
as
begin
		--declare @t as table(rf_idCase bigint, DS0 varchar(6),DS1 varchar(6),DS2 varchar(6))

		insert @DS(rf_idCase,DS1)
		select rf_idCase,DiagnosisCode
		from RegisterCases.dbo.t_Diagnosis
		where TypeDiagnosis=1 and rf_idCase=@rf_idCase

		update @DS
		set DS0=DiagnosisCode
		from @DS t inner join RegisterCases.dbo.t_Diagnosis d on
				t.rf_idCase=d.rf_idCase and
				d.TypeDiagnosis=2
				and d.rf_idCase=@rf_idCase
		update @DS
		set DS2=DiagnosisCode
		from @DS t inner join RegisterCases.dbo.t_Diagnosis d on
				t.rf_idCase=d.rf_idCase and
				d.TypeDiagnosis=3
				and d.rf_idCase=@rf_idCase
RETURN;
end
GO
GRANT SELECT ON  [dbo].[fn_GetDiagnosisRegisterCaseDB] TO [db_AccountOMS]
GO
