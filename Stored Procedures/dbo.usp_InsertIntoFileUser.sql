SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
create procedure [dbo].[usp_InsertIntoFileUser]
			@file varchar(26)
as
if not exists(select * from t_FileUser where [FileName]=@file and UserName= ORIGINAL_LOGIN())
begin
	insert t_FileUser([FileName],UserName,DateOperation) values(@file, ORIGINAL_LOGIN(), GETDATE())
end
GO
GRANT EXECUTE ON  [dbo].[usp_InsertIntoFileUser] TO [db_AccountOMS]
GO
