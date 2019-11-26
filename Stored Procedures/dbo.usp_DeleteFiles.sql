SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
--удаляем файлы если они не были отданны в СМО иначе ничего не удаляем
create proc [dbo].[usp_DeleteFiles]
			@t as TVP_ErrorNumber READONLY
as

if(select COUNT(*) 
	from t_FileExit e inner join @t t on 
			e.rf_idFile=t.id
  )=0
begin
	delete from t_File where id in (select id from @t)
	select 1
end
else 
begin
	select 0
end
GO
GRANT EXECUTE ON  [dbo].[usp_DeleteFiles] TO [db_AccountOMS]
GO
