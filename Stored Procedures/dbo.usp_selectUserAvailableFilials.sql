SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[usp_selectUserAvailableFilials]
AS
declare @currentUser nvarchar(100),
		@havePermission int=1;
 select @currentUser=SYSTEM_USER
SELECT filialPermission, userName, user
  FROM [dbo].[t_UserPermissions]
  where [user]=@currentUser 
  --and [havePermissionToPersonalData]=@havePermission
GO
GRANT EXECUTE ON  [dbo].[usp_selectUserAvailableFilials] TO [AccountsOMS]
GRANT EXECUTE ON  [dbo].[usp_selectUserAvailableFilials] TO [db_AccountOMS]
GO
