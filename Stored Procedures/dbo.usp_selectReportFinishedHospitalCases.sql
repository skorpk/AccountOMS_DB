SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[usp_selectReportFinishedHospitalCases]
--@p_ProvideCondition tinyint, -- 1.7 и 1.10 — стационарные случаи, передаются в параметр 7 и 10
@p_StartRegistrationDate nvarchar(10) = null,
@p_EndRegistrationDate nvarchar(10) = null,
@p_StartReportMonth int,
@p_StartReportYear int,
@p_EndReportMonth int,
@p_EndReportYear int,
@p_InsPlace int, --0 - Волгоградская область, 34 - другой регион
@p_MOCode int --Код медорганизации
AS
begin
CREATE TABLE #t_tmpReport
(medservice nvarchar(300), 
countcasesadult bigint, countpatientdaysadult bigint, casescostadult float,
countcaseschild bigint, countpatientdayschild bigint, casescostchild float)

INSERT INTO #t_tmpReport 
select 
(mes.[MES] +' '+ cc.[Наименование]) as medservice
      	,count (distinct case when c.age>=18 then c.id end) as countcasesadult
      	,isnull(sum (case when c.age>=18 then /*Datediff(day,c.[DateBegin],c.[DateEnd])*/m.[Quantity] end),0) as countmedservicesadult
      	,isnull(sum (case when c.age>=18 then ISNULL(mes.Tariff*mes.Quantity,0) else 0 end),0) as casescostadult
      	,count (distinct case when c.age<18 then c.id end) as countcaseschild
      	,isnull(sum (case when c.age<18 then /*Datediff(day,c.[DateBegin],c.[DateEnd])*/m.[Quantity] end),0) as countmedserviceschild
      	,isnull(sum (case when c.age<18 then ISNULL(mes.Tariff*mes.Quantity,0) else 0 end),0) as casescostchild
    FROM [dbo].[t_MES] mes
inner join [dbo].[t_Meduslugi] m on (m.[rf_idCase]=mes.[rf_idCase] and m.[MUSurgery] is null)
inner join [oms_nsi].[dbo].[V_sprMUForCompletedCasePD] cc on mes.[MES]=cc.[Код]
inner JOIN [dbo].[t_Case] c on mes.[rf_idCase]=c.[id]
INNER JOIN [dbo].[t_RecordCasePatient] rcp on rcp.id = c.rf_idRecordCasePatient
INNER JOIN [dbo].[t_RegistersAccounts] ra on ra.id = rcp.rf_idRegistersAccounts
INNER JOIN [dbo].[t_File] f on f.id = ra.rf_idFiles 
  
  where
	 ra.ReportYear >= @p_StartReportYear and ra.ReportYear <= @p_EndReportYear 
	 and ra.ReportMonth >= @p_StartReportMonth and ra.ReportMonth <= @p_EndReportMonth  
	 and f.DateRegistration >=@p_StartRegistrationDate and f.DateRegistration-1 <=@p_EndRegistrationDate 
	 and ((ra.PrefixNumberRegister=@p_InsPlace and @p_InsPlace=34) or (@p_InsPlace<>34 and ra.PrefixNumberRegister<>34))
	 and f.CodeM = case when @p_MOCode=-1 then f.CodeM else @p_MOCode  end
	 group by mes.[MES] +' '+ cc.[Наименование]
	 
select medservice
	,countcasesadult
	,countpatientdaysadult
	,casescostadult
	,countcaseschild
	,countpatientdayschild
	,casescostchild
	,cast(cast(countpatientdaysadult as float)/cast((case when countcasesadult=0 then 1 else countcasesadult end) as float) as decimal(15,2)) col8
	,cast(cast(countpatientdayschild as float)/cast((case when countcaseschild=0 then 1 else countcaseschild end) as float) as decimal(15,2)) col9
	from #t_tmpReport
end
GO
GRANT EXECUTE ON  [dbo].[usp_selectReportFinishedHospitalCases] TO [db_AccountOMS]
GO
