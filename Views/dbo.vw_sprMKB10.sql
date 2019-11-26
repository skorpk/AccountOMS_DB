SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


CREATE VIEW [dbo].[vw_sprMKB10]
AS
select DiagnosisCode,Diagnosis,rf_HeadUnGroupId,CASE WHEN CHARINDEX('.',DiagnosisCode)>0 THEN SUBSTRING(DiagnosisCode,0,CHARINDEX('.',DiagnosisCode)) ELSE DiagnosisCode END AS MainDS from oms_NSI.dbo.sprMKB


GO
GRANT SELECT ON  [dbo].[vw_sprMKB10] TO [db_AccountOMS]
GO
