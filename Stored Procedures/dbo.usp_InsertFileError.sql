SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE proc [dbo].[usp_InsertFileError]
			@fileName varchar(26),
			@errorID smallint
as
	declare @idFile int
	insert t_FileError([FileName]) values(@fileName)
	set @idFile=SCOPE_IDENTITY()
	insert t_Errors(rf_idFileError,ErrorNumber/*,rf_sprErrorAccount*/) values(@idFile,@errorID)
	
	select @idFile,1
GO
GRANT EXECUTE ON  [dbo].[usp_InsertFileError] TO [db_AccountOMS]
GO
