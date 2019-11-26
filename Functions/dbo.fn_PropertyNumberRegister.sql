SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
--функция возвращает 1 если присутствует данный номер реестр СП и ТК и небыл принят счет с данным номером на это лпу
--если возвращаемое значение отлично от 1 значит ошибка.
CREATE FUNCTION [dbo].[fn_PropertyNumberRegister](@account varchar(15))
RETURNS int
as
begin
declare @i int
		select @i=cast(case when IsNumeric(rtrim(left(right(@account,len(@account)-charindex('-',@account,charindex('-',@account)+1)),2)))=1 
						then rtrim(left(right(@account,len(@account)-charindex('-',@account,charindex('-',@account)+1)),2))
						else left(rtrim(left(right(@account,len(@account)-charindex('-',@account,charindex('-',@account)+1)),2)),1) end as int)
RETURN(@i)
end
GO
GRANT EXECUTE ON  [dbo].[fn_PropertyNumberRegister] TO [db_AccountOMS]
GO
