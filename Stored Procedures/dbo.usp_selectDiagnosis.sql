SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[usp_selectDiagnosis]
@p_CaseId nvarchar(100)
AS
BEGIN
SELECT  d.[DiagnosisCode]
      ,[rf_idCase]
      ,[Diagnosis]
      ,case when [TypeDiagnosis]=1 then 'Основной'  when [TypeDiagnosis]=2 then 'Первичный' when [TypeDiagnosis]=3 then 'Сопутствующий' end AS TypeDiagnosis
  FROM [AccountOMS].[dbo].[t_Diagnosis] d
  inner join [OMS_nsi].[dbo].[sprMKB] mkb on mkb.[DiagnosisCode]=d.[DiagnosisCode]
  where d.[rf_idCase]=@p_CaseId
  --and [TypeDiagnosis]<>1 --не основные
END
GO
GRANT EXECUTE ON  [dbo].[usp_selectDiagnosis] TO [AccountsOMS]
GRANT EXECUTE ON  [dbo].[usp_selectDiagnosis] TO [db_AccountOMS]
GO
