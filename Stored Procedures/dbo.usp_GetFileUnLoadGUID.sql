SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
create proc [dbo].[usp_GetFileUnLoadGUID]
as
--испоьлзую выбор файлов с помощью FILESTREAM
select FileZIP.PathName(),GET_FILESTREAM_TRANSACTION_CONTEXT(),rtrim(f.FileNameHR) as FileNameHR
from t_File f inner join t_DoubleGuidCase t on
		f.id=t.rf_idFiles
GO
GRANT EXECUTE ON  [dbo].[usp_GetFileUnLoadGUID] TO [db_AccountOMS]
GO
