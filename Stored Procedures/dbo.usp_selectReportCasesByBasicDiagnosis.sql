SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[usp_selectReportCasesByBasicDiagnosis]
@p_ProvideCondition tinyint, -- 1 - стационар, 2 - амбулаторий, 55 - дневной стационар, 57 - стоматология
@p_StartRegistrationDate nvarchar(10) = null,
@p_EndRegistrationDate nvarchar(10) = null,
@p_StartReportMonth int,
@p_StartReportYear int,
@p_EndReportMonth int,
@p_EndReportYear int,
@p_InsPlace int, --0 - Волгоградская область, 34 - другой регион
@p_Profile int,--профиль медпомощи
@p_MOCode int --Код медорганизации
AS
begin
CREATE TABLE #t_tmpReport
(diagnosis nvarchar(200), 
countcasesadult bigint, countpatientdaysadult bigint, casescostadult decimal(15, 2),
countcaseschild bigint, countpatientdayschild bigint, casescostchild decimal(15, 2))

INSERT INTO #t_tmpReport 
select 
      (d.[DiagnosisCode] +' '+ mkb.[Diagnosis]) as Diagnosis
      	,ISNULL(count(distinct case when c.age>=18 then c.id end),0) as countcases1adult
      	,ISNULL(sum(case when c.age>=18 then /*Datediff(day,c.[DateBegin],c.[DateEnd])*/ m.[Quantity] end),0)
      	,sum (case when c.age>=18 then ISNULL(m.Price*m.Quantity,0)+ISNULL(mes.Tariff*mes.Quantity,0) else 0 end) as casescost1adult
      	,ISNULL(count (distinct case when c.age<18 then c.id end),0) as countcases1child
      	,ISNULL(sum(case when c.age<18 then /*Datediff(day,c.[DateBegin],c.[DateEnd])*/ m.[Quantity] end),0)
      	,sum (case when c.age<18 then ISNULL(m.Price*m.Quantity,0)+ISNULL(mes.Tariff*mes.Quantity,0) else 0 end) as casescost1adult
		FROM [dbo].[t_Diagnosis] d
		inner join [OMS_nsi].[dbo].[sprMKB] mkb on mkb.[DiagnosisCode]=d.[DiagnosisCode]
  inner JOIN [dbo].[t_Case] c on d.[rf_idCase]=c.[id]
  INNER JOIN [dbo].[t_RecordCasePatient] rcp on rcp.id = c.rf_idRecordCasePatient
  INNER JOIN [dbo].[t_RegistersAccounts] ra on ra.id = rcp.rf_idRegistersAccounts
  INNER JOIN [dbo].[t_File] f on f.id = ra.rf_idFiles 
  --INNER JOIN [OMS_NSI].[dbo].[sprV002] v002 on v002.[Id]=c.[rf_idV002]
  inner JOIN [dbo].[t_Meduslugi] m on m.[rf_idCase]=c.[id]
  LEFT JOIN [dbo].[t_MES] mes on mes.[rf_idCase]=c.[id]
  
  
  where
	 ra.ReportYear >= @p_StartReportYear and ra.ReportYear <= @p_EndReportYear 
	 and ra.ReportMonth >= @p_StartReportMonth and ra.ReportMonth <= @p_EndReportMonth  
	 and f.DateRegistration >=@p_StartRegistrationDate and f.DateRegistration-1 <=@p_EndRegistrationDate  
	 and ((ra.PrefixNumberRegister=@p_InsPlace and @p_InsPlace=34) or (@p_InsPlace<>34 and ra.PrefixNumberRegister<>34))
	 and f.CodeM = case when @p_MOCode=-1 then f.CodeM else @p_MOCode  end
	 and m.MUGroupCode=@p_ProvideCondition 
	 and c.[rf_idV002]=case when @p_Profile=-1 then c.[rf_idV002] else @p_Profile  end
	 and d.[TypeDiagnosis]=1
	 group by d.[DiagnosisCode] +' '+ mkb.[Diagnosis]
	 
select diagnosis
	,countcasesadult
	,countpatientdaysadult
	,casescostadult
	,countcaseschild
	,countpatientdayschild
	,casescostchild
	,cast(cast(countpatientdaysadult as float)/cast((case when countcasesadult=0 then 1 else countcasesadult end) as float) as decimal(15,2)) col8
	,cast(cast(countpatientdayschild as float)/cast((case when countcaseschild=0 then 1 else countcaseschild end) as float) as decimal(15,2)) col9
	,cast(cast(casescostadult as float)/cast((case when countcasesadult=0 then 1 else countcasesadult end) as float) as decimal(15,2)) col10
	,cast(cast(casescostchild as float)/cast((case when countcaseschild=0 then 1 else countcaseschild end) as float) as decimal(15,2)) col11

	from #t_tmpReport
end
GO
GRANT EXECUTE ON  [dbo].[usp_selectReportCasesByBasicDiagnosis] TO [db_AccountOMS]
GO
