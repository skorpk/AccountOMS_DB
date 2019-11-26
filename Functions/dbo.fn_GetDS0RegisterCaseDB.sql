SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE FUNCTION [dbo].[fn_GetDS0RegisterCaseDB](@rf_idCase bigint)
RETURNS varchar(10)
as
begin
declare @d varchar(10)
		select @d=DiagnosisCode	from RegisterCases.dbo.t_Diagnosis d where d.TypeDiagnosis=2 and d.rf_idCase=@rf_idCase
	
RETURN(@d)
end
GO
GRANT EXECUTE ON  [dbo].[fn_GetDS0RegisterCaseDB] TO [db_AccountOMS]
GO
