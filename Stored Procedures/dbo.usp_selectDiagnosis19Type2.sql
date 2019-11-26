SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[usp_selectDiagnosis19Type2]
@rf_idCase bigint,
@p_FileType tinyint = 2
AS
--declare @p_FileType tinyint = 2

create table #TypeDiag(TypeCode int)

if(@p_FileType = 2)
	insert into #TypeDiag (TypeCode)
	(SELECT TypeCodeForAccounts FROM [oms_nsi].[dbo].[sprDiagnosisType])
else if(@p_FileType = 1)
	insert into #TypeDiag (TypeCode)
	(SELECT TypeCodeForAccounts FROM [oms_nsi].[dbo].[sprDiagnosisType] where [TypeCode]<>1)

/*DS1*/
SELECT [TypeName] as DiagType
	  ,rtrim(d.[DiagnosisCode]) [DiagnosisCode]
      ,d.[rf_idCase] 
      ,[Diagnosis]
	  ,case when IsFirstDS=1 then 'Да' else 'Нет' end IsFirst
	  ,case when IsNeedDisp=1 then 'Состоит' when IsNeedDisp=2 then 'Взят' when IsNeedDisp=3 then 'Не подлежит' end IsNeedDisp
FROM dbo.[t_Diagnosis] AS d 
inner join [OMS_nsi].[dbo].[sprMKB] mkb on mkb.[DiagnosisCode]=d.[DiagnosisCode]
inner join dbo.t_Case c on c.id = d.rf_idCase
inner join [oms_nsi].[dbo].[sprDiagnosisType] td on td.TypeCodeForAccounts=d.TypeDiagnosis
inner join #TypeDiag tdt on tdt.[TypeCode]=d.[TypeDiagnosis]
where d.[rf_idCase]=@rf_idCase

union all

/*DS2*/
SELECT 'Диагноз заболевания' as DiagType
	  ,rtrim(d.[DiagnosisCode]) [DiagnosisCode]
      ,d.[rf_idCase]
      ,[Diagnosis]
	  ,case when IsFirst=1 then 'Да' else 'Нет' end IsFirst
	  ,case when IsNeedDisp=1 then 'Состоит' when IsNeedDisp=2 then 'Взят' when IsNeedDisp=3 then 'Не подлежит' end IsNeedDisp
FROM [dbo].[t_DS2_Info] d
inner join [OMS_nsi].[dbo].[sprMKB] mkb on mkb.[DiagnosisCode]=d.[DiagnosisCode]
where d.[rf_idCase]=@rf_idCase
GO


GRANT EXECUTE ON  [dbo].[usp_selectDiagnosis19Type2] TO [AccountsOMS]
GRANT EXECUTE ON  [dbo].[usp_selectDiagnosis19Type2] TO [db_AccountOMS]
GO
