SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[usp_InsertTmpFileSynch]
as
TRUNCATE TABLE tmp_FileSynch
INSERT tmp_FileSynch
SELECT f.id
FROM dbo.t_File	f LEFT JOIN dbo.t_FileSynch fs ON
			f.id=fs.rf_idFile
WHERE fs.rf_idFile IS NULL

 --импорт определенных счетов на открытый сервер
 --id файлов берем из базы AccountOMS
 
 /*
INSERT tmp_FileSynch
SELECT f.id
FROM dbo.t_File	f inner JOIN dbo.t_RegistersAccounts fs ON
			f.id=fs.rf_idFiles
WHERE f.DateRegistration>'20140101'  AND f.DateRegistration<'20150120' AND f.CodeM='251001'  AND fs.ReportYear=2014 
*/
GO
GRANT EXECUTE ON  [dbo].[usp_InsertTmpFileSynch] TO [db_AccountOMS]
GO
