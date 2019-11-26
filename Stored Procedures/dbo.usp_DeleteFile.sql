SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
--удаляем файлы если они не были отданны в СМО иначе ничего не удаляем
CREATE proc [dbo].[usp_DeleteFile]
			@id int
as
DELETE FROM dbo.t_FileExit WHERE rf_idFile=@id AND SUSER_ID()=364 --удалять может только А.С. Степанова

if NOT EXISTS(select * from t_FileExit e where e.rf_idFile=@id)
BEGIN	 
	delete from t_File where id=@id
	select 1
end
else 
begin
	select 0
end
  
GO
GRANT EXECUTE ON  [dbo].[usp_DeleteFile] TO [db_AccountOMS]
GO
