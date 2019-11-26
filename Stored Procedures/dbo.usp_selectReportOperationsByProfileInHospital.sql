SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[usp_selectReportOperationsByProfileInHospital]
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
CREATE TABLE #t_tmpCasesId(caseid bigint)	

insert into #t_tmpCasesId	
select distinct m1.[rf_idCase]
from [dbo].[t_Meduslugi] m1
where m1.MUSurgery is not null

CREATE TABLE #t_tmpReport
(profile nvarchar(300), 
countcasesadult bigint, countpatientdaysadult bigint, countmedservicesadult bigint, casescostadult decimal(15, 2),
countcaseschild bigint, countpatientdayschild bigint, countmedserviceschild bigint, casescostchild decimal(15, 2))

INSERT INTO #t_tmpReport
select 
      (v002.[Name]) as prof
      	,ISNULL(count(distinct case when c.age>=18 then c.id end),0) as countcasesadult
      	,ISNULL(sum(case when c.age>=18 then m.[Quantity] end),0) as countpatientdaysadult
      	,ISNULL(count(distinct case when (c.age>=18 and m.MUSurgery is not null) then m.id end),0) as countmedservicesadult
      	,sum (case when c.age>=18 then ISNULL(m.Price*m.Quantity,0)+ISNULL(mes.Tariff*mes.Quantity,0) else 0 end)  as casescostadult
      	,ISNULL(count (distinct case when c.age<18 then c.id end),0) as countcaseschild
      	,ISNULL(sum(case when c.age<18 then m.[Quantity] end),0) as countpatientdayschild
      	,ISNULL(count(distinct case when (c.age<18 and m.MUSurgery is not null) then m.id end),0) as countmedserviceschild
      	,sum (case when c.age<18 then ISNULL(m.Price*m.Quantity,0)+ISNULL(mes.Tariff*mes.Quantity,0) else 0 end) as casescostchild
		FROM [OMS_NSI].[dbo].[sprV002] v002 
  INNER JOIN [dbo].[t_Case] c on v002.[Id]=c.[rf_idV002]
  INNER JOIN [dbo].[t_RecordCasePatient] rcp on rcp.id = c.rf_idRecordCasePatient
  INNER JOIN [dbo].[t_RegistersAccounts] ra on ra.id = rcp.rf_idRegistersAccounts
  INNER JOIN [dbo].[t_File] f on f.id = ra.rf_idFiles 
  inner JOIN [dbo].[t_Meduslugi] m on m.[rf_idCase]=c.[id]
  LEFT JOIN [dbo].[t_MES] mes on mes.[rf_idCase]=c.[id]
  where
	 ra.ReportYear >= @p_StartReportYear and ra.ReportYear <= @p_EndReportYear 
	 and ra.ReportMonth >= @p_StartReportMonth and ra.ReportMonth <= @p_EndReportMonth  
	 and f.DateRegistration >=@p_StartRegistrationDate and (f.DateRegistration-1) <=@p_EndRegistrationDate 
	 and ((ra.PrefixNumberRegister=@p_InsPlace and @p_InsPlace=34) or (@p_InsPlace<>34 and ra.PrefixNumberRegister<>34))
	 and f.CodeM = case when @p_MOCode=-1 then f.CodeM else @p_MOCode  end
	 and v002.[Id]=case when @p_Profile=-1 then v002.[Id] else @p_Profile  end
	 and m.[MUGroupCode] in (0,1)
	 and c.id in
	 (
	 select caseid from #t_tmpCasesId
	 )
	 group by v002.[Name]

	 
select profile
	,countcasesadult
	,countpatientdaysadult
	,countmedservicesadult
	,casescostadult
	,countcaseschild
	,countpatientdayschild
	,countmedserviceschild
	,casescostchild
	,cast(cast(countpatientdaysadult as float)/cast((case when countcasesadult=0 then 1 else countcasesadult end) as float) as decimal(15,2)) col8
	,cast(cast(countpatientdayschild as float)/cast((case when countcaseschild=0 then 1 else countcaseschild end) as float) as decimal(15,2)) col9
 	from #t_tmpReport 
end
GO
GRANT EXECUTE ON  [dbo].[usp_selectReportOperationsByProfileInHospital] TO [db_AccountOMS]
GO
