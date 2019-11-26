SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[usp_setAddionalFilterRequest]
@filterText nvarchar(256),
@datebegin nvarchar(8),
@dateEnd nvarchar(8),
@MOCode int,
@FilialCode int,
@selRCount int,
@version nvarchar(20)=null,
@excl nvarchar(20)= null,
@startrepperiod nvarchar(6) = null,
@endrepperiod nvarchar(6) = null

AS 
begin	
if(@filterText != '')
	if(CURRENT_USER not like @excl or @excl is null)
		begin
			insert into [dbo].[t_AdditionalFilterRequests]
			values (CURRENT_USER,@filterText,CURRENT_TIMESTAMP,@datebegin,@dateEnd,@MOCode,@FilialCode,@selRCount,@version,@startrepperiod,@endrepperiod) 		
		end
end
GO
GRANT EXECUTE ON  [dbo].[usp_setAddionalFilterRequest] TO [AccountsOMS]
GRANT EXECUTE ON  [dbo].[usp_setAddionalFilterRequest] TO [db_AccountOMS]
GO
