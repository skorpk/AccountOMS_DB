SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
create procedure [dbo].[usp_ExistsFromFileUser]
			@file varchar(26)
as
select COUNT(*) from t_FileUser where [FileName]=@file and UserName<>ORIGINAL_LOGIN()
GO
GRANT EXECUTE ON  [dbo].[usp_ExistsFromFileUser] TO [db_AccountOMS]
GO
