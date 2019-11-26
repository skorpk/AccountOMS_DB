SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE procedure [dbo].[usp_IsFileNameExists]
				@fileName varchar(26)
as 
IF EXISTS (select id from t_File where FileNameHR= UPPER(rtrim(ltrim(@fileName))))
	SELECT 1
ELSE 
	SELECT 0
GO
GRANT EXECUTE ON  [dbo].[usp_IsFileNameExists] TO [db_AccountOMS]
GO
