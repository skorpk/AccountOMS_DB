SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE VIEW [dbo].[view_MKB]
AS
SELECT
	   row_number() OVER (order by DiagnosisCode) as DiagnosisCodeID
	  ,[DiagnosisCode]
      ,[Diagnosis]      
  FROM [oms_NSI].[dbo].[sprMKB]
GO
GRANT SELECT ON  [dbo].[view_MKB] TO [db_AccountOMS]
GO
