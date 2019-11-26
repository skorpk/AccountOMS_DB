SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
create function [dbo].[fn_FullYear] (@DateBeg date,@DateEnd date)
RETURNS int
as
begin
	declare @FullYear int
	select @FullYear=DATEDIFF(YEAR,@DateBeg,@DateEnd)-CASE WHEN 100*MONTH(@DateBeg)+DAY(@DateBeg)>100*MONTH(@DateEnd)+DAY(@DateEnd) THEN 1 ELSE 0 END;
	return (@FullYear)
end
GO
GRANT EXECUTE ON  [dbo].[fn_FullYear] TO [db_AccountOMS]
GO
