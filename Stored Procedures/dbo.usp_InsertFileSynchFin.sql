SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

create PROCEDURE [dbo].[usp_InsertFileSynchFin]
as
INSERT dbo.t_FileSynchFin( rf_idFile, DateSynch ) 
SELECT rf_idFile,GETDATE() 
FROM dbo.tmp_FileSynchFin s
WHERE EXISTS(SELECT * FROM [SRVSQL2-ST1].AccountOMS.dbo.t_File WHERE id=s.rf_idFile)

TRUNCATE TABLE tmp_FileSynchFin
GO
