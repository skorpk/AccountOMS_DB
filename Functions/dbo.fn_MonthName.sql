SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE FUNCTION [dbo].[fn_MonthName](@year smallint, @month tinyint)
RETURNS nvarchar(30)
as
begin
declare @i nvarchar(30),
		@d char(10)=CAST(@year as CHAR(4))+right('0'+CAST(@month as varchar(2)),2)+'01'
		
		select @i=DATENAME(MONTH,@d)+' '+CAST(@year as CHAR(4))+' г.'
RETURN(@i)
end
GO
GRANT EXECUTE ON  [dbo].[fn_MonthName] TO [db_AccountOMS]
GO
