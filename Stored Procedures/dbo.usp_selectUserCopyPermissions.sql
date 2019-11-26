SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[usp_selectUserCopyPermissions]
@currentUser nvarchar(100)=null
AS
declare
		@haveCopyPermission int=1;
 select @currentUser=SYSTEM_USER
SELECT count(*)
  FROM [dbo].[t_UserPermissions]
  where [user]=@currentUser and [canCopyFromGrid]=@haveCopyPermission
GO
GRANT EXECUTE ON  [dbo].[usp_selectUserCopyPermissions] TO [AccountsOMS]
GRANT EXECUTE ON  [dbo].[usp_selectUserCopyPermissions] TO [db_AccountOMS]
GO
