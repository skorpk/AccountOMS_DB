SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[usp_InsertTmpFileSynchFin]
as
TRUNCATE TABLE tmp_FileSynchFin

INSERT tmp_FileSynchFin
SELECT f.id
FROM dbo.t_File	f LEFT JOIN dbo.t_FileSynchFin fs ON
			f.id=fs.rf_idFile
WHERE fs.rf_idFile IS NULL AND f.DateRegistration>'20170101'
GO
