SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
--функция возвращает 1 если присутствует данный номер реестр СП и ТК и небыл принят счет с данным номером на это лпу
--если возвращаемое значение отлично от 1 значит ошибка.
CREATE FUNCTION [dbo].[fn_PrefixNumberRegister](@account varchar(15))
RETURNS int
as
begin
declare @i int
		select @i=cast(replace(rtrim(left(left(@account,charindex('-',@account)),5)),'-','') as int)
RETURN(@i)
end
GO
GRANT EXECUTE ON  [dbo].[fn_PrefixNumberRegister] TO [db_AccountOMS]
GO
