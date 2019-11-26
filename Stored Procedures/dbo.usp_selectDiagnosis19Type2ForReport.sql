SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[usp_selectDiagnosis19Type2ForReport]
@p_CaseId nvarchar(max)
AS
--SELECT 'Основной' as DiagType
--	  ,rtrim(d.[DiagnosisCode]) [DiagnosisCode]
--      ,d.[rf_idCase] 
--      ,[Diagnosis]
--	  ,case when IsFirstDS=1 then 'Да' else 'Нет' end IsFirst
--	  ,case when IsNeedDisp=1 then 'Состоит' when IsNeedDisp=2 then 'Взят' when IsNeedDisp=3 then 'Не подлежит' end IsNeedDisp
--FROM dbo.[t_Diagnosis] AS d 
--inner join [OMS_nsi].[dbo].[sprMKB] mkb on mkb.[DiagnosisCode]=d.[DiagnosisCode]
--inner join dbo.t_Case c on c.id = d.rf_idCase
--where d.[rf_idCase]=101047097

declare @query nvarchar(max)='
/*DS1*/
SELECT ''Основной'' as DiagType
	  ,rtrim(d.[DiagnosisCode]) [DiagnosisCode]
      ,d.[rf_idCase] 
      ,[Diagnosis]
	  ,case when IsFirstDS=1 then ''Да'' else ''Нет'' end IsFirst
	  ,case when IsNeedDisp=1 then ''Состоит'' when IsNeedDisp=2 then ''Взят'' when IsNeedDisp=3 then ''Не подлежит'' end IsNeedDisp
FROM dbo.[t_Diagnosis] AS d 
inner join [OMS_nsi].[dbo].[sprMKB] mkb on mkb.[DiagnosisCode]=d.[DiagnosisCode]
inner join dbo.t_Case c on c.id = d.rf_idCase
where d.[rf_idCase] in ('+@p_CaseId+')

union all

/*DS2*/
SELECT ''Диагноз заболевания'' as DiagType
	  ,rtrim(d.[DiagnosisCode]) [DiagnosisCode]
      ,d.[rf_idCase]
      ,[Diagnosis]
	  ,case when IsFirst=1 then ''Да'' else ''Нет'' end IsFirst
	  ,case when IsNeedDisp=1 then ''Состоит'' when IsNeedDisp=2 then ''Взят'' when IsNeedDisp=3 then ''Не подлежит'' end IsNeedDisp
FROM [dbo].[t_DS2_Info] d
inner join [OMS_nsi].[dbo].[sprMKB] mkb on mkb.[DiagnosisCode]=d.[DiagnosisCode]
where d.[rf_idCase] in ('+@p_CaseId+')'

print(@query)
exec(@query)

GO
GRANT EXECUTE ON  [dbo].[usp_selectDiagnosis19Type2ForReport] TO [AccountsOMS]
GRANT EXECUTE ON  [dbo].[usp_selectDiagnosis19Type2ForReport] TO [db_AccountOMS]
GO
