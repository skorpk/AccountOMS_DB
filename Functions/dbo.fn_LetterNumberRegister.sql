SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
--функция возвращает 1 если присутствует данный номер реестр СП и ТК и небыл принят счет с данным номером на это лпу
--если возвращаемое значение отлично от 1 значит ошибка.
CREATE FUNCTION [dbo].[fn_LetterNumberRegister](@account varchar(15))
RETURNS char(1)
as
begin
declare @i char(1)
		select @i=case when IsNumeric(rtrim(left(right(@account,len(@account)-charindex('-',@account,charindex('-',@account)+1)),2)))=0 
						then right(rtrim(left(right(@account,len(@account)-charindex('-',@account,charindex('-',@account)+1)),2)),1)
						else null end 
RETURN(@i)
end
GO
GRANT EXECUTE ON  [dbo].[fn_LetterNumberRegister] TO [db_AccountOMS]
GO
