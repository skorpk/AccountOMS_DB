SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE FUNCTION [dbo].[fn_GetMEERegisterCaseDB](@rf_idCase bigint)
RETURNS decimal(15,2)
as
begin
declare @d decimal(15,2)
		select @d=Amount from RegisterCases.dbo.t_FinancialSanctions d where d.TypeSanction=2 and d.rf_idCase=@rf_idCase
	
RETURN(@d)
end
GO
GRANT EXECUTE ON  [dbo].[fn_GetMEERegisterCaseDB] TO [db_AccountOMS]
GO
