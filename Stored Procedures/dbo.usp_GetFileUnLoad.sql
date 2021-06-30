SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE proc [dbo].[usp_GetFileUnLoad]
			--@tableID as TVP_ErrorNumber READONLY
			@num nvarchar(max)
as
declare @tableID as TVP_ErrorNumber 
		
DECLARE @idoc int,
        @err int,
        @xml xml
        
select @xml=cast(replace('<Root><Num num="'+@num+'" /></Root>',',','" /><Num num="') as xml)
--CAST(dbo.fn_SplitNumber(@num) as xml)

 EXEC  @err = sp_xml_preparedocument @idoc OUTPUT, @xml
	insert @tableID 
	select num
	from OPENXML(@idoc, '/Root/Num', 1)
			  WITH (num int)

 EXEC sp_xml_removedocument @idoc
--if ORIGINAL_LOGIN()<>'VTFOMS\SKrainov'
--begin
	--помечаю файлы которые отдал в СМО
	insert t_FileExit(rf_idFile,FileName,DateUnLoad)
	select f.id,f.FileNameHR,GETDATE()
	from t_File f inner join @tableID t on
			f.id=t.id 														  				
	where NOT EXISTS(SELECT TOP(1) 1 FROM  t_FileExit fe WHERE f.id=fe.rf_idFile)
			--AND NOT EXISTS(SELECT TOP(1) 1 FROM dbo.t_RegistersAccounts a WHERE a.rf_idSMO='34' AND a.rf_idFiles=f.id)
PRINT(@@ROWCOUNT)
PRINT('Insert into t_FileExit')
--end

--испоьлзую выбор файлов с помощью FILESTREAM
--23.10.2013 решено отказаться от технологий выгрузки через SqlFileStream
select FileZIP.PathName(),/*GET_FILESTREAM_TRANSACTION_CONTEXT()*/f.FileZIP,rtrim(FileNameHR) as FileNameHR
from t_File f inner join @tableID t on
		f.id=t.id
GO
GRANT EXECUTE ON  [dbo].[usp_GetFileUnLoad] TO [db_AccountOMS]
GO
