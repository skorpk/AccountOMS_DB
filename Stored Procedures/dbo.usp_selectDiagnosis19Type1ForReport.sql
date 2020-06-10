SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[usp_selectDiagnosis19Type1ForReport]
@rf_idCase bigint
AS
create table #TypeDiag(TypeCode int)

insert into #TypeDiag (TypeCode)
(SELECT TypeCodeForAccounts FROM [oms_nsi].[dbo].[sprDiagnosisType])

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
GO
GRANT EXECUTE ON  [dbo].[usp_selectDiagnosis19Type1ForReport] TO [AccountsOMS]
GO
GRANT EXECUTE ON  [dbo].[usp_selectDiagnosis19Type1ForReport] TO [db_AccountOMS]
GO
