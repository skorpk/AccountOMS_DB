SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[usp_InsertFileSynch]
as
INSERT dbo.t_FileSynch( rf_idFile, DateSynch ) 
SELECT rf_idFile,GETDATE() 
FROM dbo.tmp_FileSynch s
WHERE EXISTS(SELECT * FROM [srv-cnt-db3].AccountOMSReports.dbo.t_File WHERE id=s.rf_idFile)
TRUNCATE TABLE tmp_FileSynch
GO
GRANT EXECUTE ON  [dbo].[usp_InsertFileSynch] TO [db_AccountOMS]
GO
