SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[usp_InsertFileSynchPlanDD]
as 
INSERT dbo.t_FileSynchPlanDD( rf_idFile, DateSynch ) 
SELECT rf_idFile,GETDATE() 	FROM dbo.tmp_FileSynchPlanDD 

TRUNCATE TABLE dbo.tmp_FileSynchPlanDD
GO
