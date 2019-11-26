SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[usp_InsertTmpFileSynchPlanDD]
				@dtStart DATETIME,
				@ReportYear SMALLINT
as
TRUNCATE TABLE dbo.tmp_FileSynchPlanDD

INSERT dbo.tmp_FileSynchPlanDD( rf_idFile )
SELECT f.id
FROM dbo.t_File f INNER JOIN dbo.t_RegistersAccounts a ON
			f.id=a.rf_idFiles
WHERE f.DateRegistration>@dtStart AND a.ReportYear>=@ReportYear AND Letter IN('O','R') --AND a.rf_idSMO<>'34'
		AND NOT EXISTS(SELECT * FROM dbo.t_FileSynchPlanDD WHERE rf_idFile=f.id)

SELECT @@ROWCOUNT

GO
