SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
create procedure [dbo].[usp_DeleteFromFileUser]
			@file varchar(26)
as
	delete from t_FileUser where [FileName]=@file and UserName=ORIGINAL_LOGIN()
GO
GRANT EXECUTE ON  [dbo].[usp_DeleteFromFileUser] TO [db_AccountOMS]
GO
