SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[usp_selectReportMedServices]
@p_ProvideCondition tinyint, -- 1 - стационар, 2 - амбулаторий, 55 - дневной стационар, 57 - стоматология, 60 и 70 - диспансеризация и диагностические случаи
@p_StartRegistrationDate nvarchar(10) = null,
@p_EndRegistrationDate nvarchar(10) = null,
@p_StartReportMonth int,
@p_StartReportYear int,
@p_EndReportMonth int,
@p_EndReportYear int,
@p_InsPlace int, --0 - Волгоградская область, 34 - другой регион
@p_MOCode int --Код медорганизации
AS
BEGIN
IF (@p_ProvideCondition=1/*стационар*/)
begin

CREATE TABLE #t_tmpCMedServices1Level 
(codemedservice nvarchar(200), 
countcases1adult bigint, countmedservices1adult bigint, casescost1adult decimal(15, 2),
countcases1child bigint, countmedservices1child bigint, casescost1child decimal(15, 2))

CREATE TABLE #t_tmpCMedServices2Level 
(codemedservice nvarchar(200),
countcases2adult bigint, countmedservices2adult bigint, casescost2adult decimal(15, 2),
countcases2child bigint, countmedservices2child bigint, casescost2child decimal(15, 2))

CREATE TABLE #t_tmpCMedServices3Level 
(codemedservice nvarchar(200),
countcases3adult bigint, countmedservices3adult bigint, casescost3adult decimal(15, 2),
countcases3child bigint, countmedservices3child bigint, casescost3child decimal(15, 2))

CREATE TABLE #t_tmpCMedServicesIndLevel 
(codemedservice nvarchar(200),
countcasesindadult bigint, countmedservicesindadult bigint, casescostindadult decimal(15, 2),
countcasesindchild bigint, countmedservicesindchild bigint, casescostindchild decimal(15, 2))

--ПЕРВЫЙ УРОВЕНЬ ОПЛАТЫ
INSERT INTO #t_tmpCMedServices1Level 
select 
      (m.MU +' '+ s.[MUName]) as codemedservice
      	,count (distinct case when c.age>=18 then c.id end) as countcases1adult
      	,sum (case when c.age>=18 then m.[Quantity] end) as countmedservices1adult
      	,sum (case when c.age>=18 then ISNULL(m.Price*m.Quantity,0)+ISNULL(mes.Tariff*mes.Quantity,0) else 0 end) as casescost1adult
      	,count (distinct case when c.age<18 then c.id end) as countcases1child
      	,sum (case when c.age<18 then m.[Quantity] end) as countmedservices1child
      	,sum (case when c.age<18 then ISNULL(m.Price*m.Quantity,0)+ISNULL(mes.Tariff*mes.Quantity,0) else 0 end) as casescost1child
		FROM [dbo].[t_Meduslugi] m
  inner JOIN [dbo].[t_Case] c on m.[rf_idCase]=c.[id]
  INNER JOIN [dbo].[vw_sprMU] s on s.[MU]=m.[MU]
  INNER JOIN [dbo].[t_RecordCasePatient] rcp on rcp.id = c.rf_idRecordCasePatient
  INNER JOIN [dbo].[t_RegistersAccounts] ra on ra.id = rcp.rf_idRegistersAccounts
  INNER JOIN [dbo].[t_File] f on f.id = ra.rf_idFiles 
  INNER JOIN [OMS_NSI].[dbo].[tMO] mo on substring(mo.[tfomsCode],1,6)=c.rf_idMO
  INNER JOIN [OMS_NSI].[dbo].[tMSPricePeriod] pp on pp.[rf_MOId] = mo.MOId
  LEFT JOIN [dbo].[t_MES] mes on mes.[rf_idCase]=c.[id]
  
  where
	 ra.ReportYear >= @p_StartReportYear and ra.ReportYear <= @p_EndReportYear 
	 and ra.ReportMonth >= @p_StartReportMonth and ra.ReportMonth <= @p_EndReportMonth  
	 and f.DateRegistration >=@p_StartRegistrationDate and f.DateRegistration-1 <=@p_EndRegistrationDate 
	 and m.MUGroupCode=@p_ProvideCondition 
	 and ((ra.PrefixNumberRegister=@p_InsPlace and @p_InsPlace=34) or (@p_InsPlace<>34 and ra.PrefixNumberRegister<>34))
	 --and pp.[rf_MSConditionId]=@p_ProvideCondition --стационар
	 and (pp.[beginDate]-1)<=@p_EndRegistrationDate and (pp.[endDate]-1)>@p_EndRegistrationDate
	 and pp.[rf_MSLevelId]=1 --первый уровень
	 and f.CodeM = case when @p_MOCode=-1 then f.CodeM else @p_MOCode  end
	 group by m.MU +' '+ s.[MUName]
  
--ВТОРОЙ УРОВЕНЬ ОПЛАТЫ  
  INSERT INTO #t_tmpCMedServices2Level
select 
      (m.MU +' '+ s.[MUName]) as codemedservice
      	,count (distinct case when c.age>=18 then c.id end) as countcases1adult
      	,sum (case when c.age>=18 then m.[Quantity] end) as countmedservices1adult
      	,sum (case when c.age>=18 then ISNULL(m.Price*m.Quantity,0)+ISNULL(mes.Tariff*mes.Quantity,0) else 0 end) as casescost1adult
      	,count (distinct case when c.age<18 then c.id end) as countcases1child
      	,sum (case when c.age<18 then m.[Quantity] end) as countmedservices1child
      	,sum (case when c.age<18 then ISNULL(m.Price*m.Quantity,0)+ISNULL(mes.Tariff*mes.Quantity,0) else 0 end) as casescost1child
		FROM [dbo].[t_Meduslugi] m
  inner JOIN [dbo].[t_Case] c on m.[rf_idCase]=c.[id]
  INNER JOIN [dbo].[vw_sprMU] s on s.[MU]=m.[MU]
  INNER JOIN [dbo].[t_RecordCasePatient] rcp on rcp.id = c.rf_idRecordCasePatient
  INNER JOIN [dbo].[t_RegistersAccounts] ra on ra.id = rcp.rf_idRegistersAccounts
  INNER JOIN [dbo].[t_File] f on f.id = ra.rf_idFiles 
  INNER JOIN [OMS_NSI].[dbo].[tMO] mo on substring(mo.[tfomsCode],1,6)=c.rf_idMO
  INNER JOIN [OMS_NSI].[dbo].[tMSPricePeriod] pp on pp.[rf_MOId] = mo.MOId
  LEFT JOIN [dbo].[t_MES] mes on mes.[rf_idCase]=c.[id]
  
  where
	 ra.ReportYear >= @p_StartReportYear and ra.ReportYear <= @p_EndReportYear 
	 and ra.ReportMonth >= @p_StartReportMonth and ra.ReportMonth <= @p_EndReportMonth  
	 and f.DateRegistration >=@p_StartRegistrationDate and f.DateRegistration-1 <=@p_EndRegistrationDate 
	 and m.MUGroupCode=@p_ProvideCondition 
	 and ((ra.PrefixNumberRegister=@p_InsPlace and @p_InsPlace=34) or (@p_InsPlace<>34 and ra.PrefixNumberRegister<>34))
	 --and pp.[rf_MSConditionId]=@p_ProvideCondition --стационар
	 and (pp.[beginDate]-1)<=@p_EndRegistrationDate and (pp.[endDate]-1)>@p_EndRegistrationDate
	 and pp.[rf_MSLevelId]=2 --второй уровень
	 and f.CodeM = case when @p_MOCode=-1 then f.CodeM else @p_MOCode  end
	 group by m.MU +' '+ s.[MUName]
	 
----ТРЕТИЙ УРОВЕНЬ ОПЛАТЫ
INSERT INTO #t_tmpCMedServices3Level 
select 
      (m.MU +' '+ s.[MUName]) as codemedservice
      	,count (distinct case when c.age>=18 then c.id end) as countcases1adult
      	,sum (case when c.age>=18 then m.[Quantity] end) as countmedservices1adult
      	,sum (case when c.age>=18 then ISNULL(m.Price*m.Quantity,0)+ISNULL(mes.Tariff*mes.Quantity,0) else 0 end) as casescost1adult
      	,count (distinct case when c.age<18 then c.id end) as countcases1child
      	,sum (case when c.age<18 then m.[Quantity] end) as countmedservices1child
      	,sum (case when c.age<18 then ISNULL(m.Price*m.Quantity,0)+ISNULL(mes.Tariff*mes.Quantity,0) else 0 end) as casescost1child
		FROM [dbo].[t_Meduslugi] m
  inner JOIN [dbo].[t_Case] c on m.[rf_idCase]=c.[id]
  INNER JOIN [dbo].[vw_sprMU] s on s.[MU]=m.[MU]
  INNER JOIN [dbo].[t_RecordCasePatient] rcp on rcp.id = c.rf_idRecordCasePatient
  INNER JOIN [dbo].[t_RegistersAccounts] ra on ra.id = rcp.rf_idRegistersAccounts
  INNER JOIN [dbo].[t_File] f on f.id = ra.rf_idFiles 
  INNER JOIN [OMS_NSI].[dbo].[tMO] mo on substring(mo.[tfomsCode],1,6)=c.rf_idMO
  INNER JOIN [OMS_NSI].[dbo].[tMSPricePeriod] pp on pp.[rf_MOId] = mo.MOId
  LEFT JOIN [dbo].[t_MES] mes on mes.[rf_idCase]=c.[id]
  
  where
	 ra.ReportYear >= @p_StartReportYear and ra.ReportYear <= @p_EndReportYear 
	 and ra.ReportMonth >= @p_StartReportMonth and ra.ReportMonth <= @p_EndReportMonth  
	 and f.DateRegistration >=@p_StartRegistrationDate and f.DateRegistration-1 <=@p_EndRegistrationDate 
	 and m.MUGroupCode=@p_ProvideCondition 
	 and ((ra.PrefixNumberRegister=@p_InsPlace and @p_InsPlace=34) or (@p_InsPlace<>34 and ra.PrefixNumberRegister<>34))
	 --and pp.[rf_MSConditionId]=@p_ProvideCondition --стационар
	 and (pp.[beginDate]-1)<=@p_EndRegistrationDate and (pp.[endDate]-1)>@p_EndRegistrationDate
	 and pp.[rf_MSLevelId]=3 --третий уровень
	 and f.CodeM = case when @p_MOCode=-1 then f.CodeM else @p_MOCode  end
	 group by m.MU +' '+ s.[MUName]
  
--ИНДИВИДУАЛЬНЫЙ УРОВЕНЬ ОПЛАТЫ  
  INSERT INTO #t_tmpCMedServicesIndLevel
select 
      (m.MU +' '+ s.[MUName]) as codemedservice
      	,count (distinct case when c.age>=18 then c.id end) as countcases1adult
      	,sum (case when c.age>=18 then m.[Quantity] end) as countmedservices1adult
      	,sum (case when c.age>=18 then ISNULL(m.Price*m.Quantity,0)+ISNULL(mes.Tariff*mes.Quantity,0) else 0 end) as casescost1adult
      	,count (distinct case when c.age<18 then c.id end) as countcases1child
      	,sum (case when c.age<18 then m.[Quantity] end) as countmedservices1child
      	,sum (case when c.age<18 then ISNULL(m.Price*m.Quantity,0)+ISNULL(mes.Tariff*mes.Quantity,0) else 0 end) as casescost1child
		FROM [dbo].[t_Meduslugi] m
  inner JOIN [dbo].[t_Case] c on m.[rf_idCase]=c.[id]
  INNER JOIN [dbo].[vw_sprMU] s on s.[MU]=m.[MU]
  INNER JOIN [dbo].[t_RecordCasePatient] rcp on rcp.id = c.rf_idRecordCasePatient
  INNER JOIN [dbo].[t_RegistersAccounts] ra on ra.id = rcp.rf_idRegistersAccounts
  INNER JOIN [dbo].[t_File] f on f.id = ra.rf_idFiles 
  INNER JOIN [OMS_NSI].[dbo].[tMO] mo on substring(mo.[tfomsCode],1,6)=c.rf_idMO
  INNER JOIN [OMS_NSI].[dbo].[tMSPricePeriod] pp on pp.[rf_MOId] = mo.MOId
  LEFT JOIN [dbo].[t_MES] mes on mes.[rf_idCase]=c.[id]
  
  where
	 ra.ReportYear >= @p_StartReportYear and ra.ReportYear <= @p_EndReportYear 
	 and ra.ReportMonth >= @p_StartReportMonth and ra.ReportMonth <= @p_EndReportMonth  
	 and f.DateRegistration >=@p_StartRegistrationDate and f.DateRegistration-1 <=@p_EndRegistrationDate 
	 and m.MUGroupCode=@p_ProvideCondition 
	 and ((ra.PrefixNumberRegister=@p_InsPlace and @p_InsPlace=34) or (@p_InsPlace<>34 and ra.PrefixNumberRegister<>34))
	 --and pp.[rf_MSConditionId]=@p_ProvideCondition --стационар
	 and (pp.[beginDate]-1)<=@p_EndRegistrationDate and (pp.[endDate]-1)>@p_EndRegistrationDate
	 and pp.[rf_MSLevelId]=4 --индивидуальный уровень
	 and f.CodeM = case when @p_MOCode=-1 then f.CodeM else @p_MOCode  end
	 group by m.MU +' '+ s.[MUName]
	
	
select case when ISNULL(L1.codemedservice,L2.codemedservice) is not null then ISNULL(L1.codemedservice,L2.codemedservice) 
       when ISNULL(L3.codemedservice,LInd.codemedservice) is not null then ISNULL(L3.codemedservice,LInd.codemedservice) end,
ISNULL(L1.countcases1adult,0), ISNULL(L1.countmedservices1adult,0), ISNULL(L1.casescost1adult,0),
ISNULL(L1.countcases1child,0), ISNULL(L1.countmedservices1child,0), ISNULL(L1.casescost1child,0), 
ISNULL(L2.countcases2adult,0), ISNULL(L2.countmedservices2adult,0), ISNULL(L2.casescost2adult,0),
ISNULL(L2.countcases2child,0), ISNULL(L2.countmedservices2child,0), ISNULL(L2.casescost2child,0),
ISNULL(L3.countcases3adult,0), ISNULL(L3.countmedservices3adult,0), ISNULL(L3.casescost3adult,0),
ISNULL(L3.countcases3child,0), ISNULL(L3.countmedservices3child,0), ISNULL(L3.casescost3child,0), 
ISNULL(LInd.countcasesindadult,0), ISNULL(LInd.countmedservicesindadult,0), ISNULL(LInd.casescostindadult,0),
ISNULL(LInd.countcasesindchild,0), ISNULL(LInd.countmedservicesindchild,0), ISNULL(LInd.casescostindchild,0),
(ISNULL(L1.countcases1adult,0)+ISNULL(L1.countcases1child,0)+ISNULL(L2.countcases2adult,0)+ISNULL(L2.countcases2child,0)+ISNULL(L3.countcases3adult,0)+ISNULL(L3.countcases3child,0)+ISNULL(LInd.countcasesindadult,0)+ISNULL(LInd.countcasesindchild,0)) as Col26,
(ISNULL(L1.countmedservices1adult,0)+ISNULL(L1.countmedservices1child,0)+ISNULL(L2.countmedservices2adult,0)+ISNULL(L2.countmedservices2child,0)+ISNULL(L3.countmedservices3adult,0)+ISNULL(L3.countmedservices3child,0)+ISNULL(LInd.countmedservicesindadult,0)+ISNULL(LInd.countmedservicesindchild,0)) as Col27,
(ISNULL(L1.casescost1adult,0)+ISNULL(L1.casescost1child,0)+ISNULL(L2.casescost2adult,0)+ISNULL(L2.casescost2child,0)+ISNULL(L3.casescost3adult,0)+ISNULL(L3.casescost3child,0)+ISNULL(LInd.casescostindadult,0)+ISNULL(LInd.casescostindchild,0)) as Col28

from #t_tmpCMedServices1Level L1
FULL JOIN #t_tmpCMedServices2Level L2 on L1.codemedservice=L2.codemedservice
FULL JOIN #t_tmpCMedServices3Level L3 on L1.codemedservice=L3.codemedservice
FULL JOIN #t_tmpCMedServicesIndLevel LInd on L1.codemedservice=LInd.codemedservice

end
ELSE IF (@p_ProvideCondition<>1/*не стационар*/)
begin
select 
      (m.MU +' '+ s.[MUName]) as codemedservice
      	,ISNULL(count(distinct case when c.age>=18 then c.id end),0) as countcasesadult
      	,ISNULL(sum(case when c.age>=18 then m.[Quantity] end),0) as countmedservicesadult
      	,cast((sum (case when c.age>=18 then ISNULL(m.Price*m.Quantity,0)/*+ISNULL(mes.Tariff*mes.Quantity,0)*/ else 0 end)) as decimal(15,2)) as casescostadult
      	,ISNULL(count (distinct case when c.age<18 then c.id end),0) as countcaseschild
      	,ISNULL(sum(case when c.age<18 then m.[Quantity] end),0) as countmedserviceschild
      	,cast((sum (case when c.age<18 then ISNULL(m.Price*m.Quantity,0)/*+ISNULL(mes.Tariff*mes.Quantity,0)*/ else 0 end)) as decimal(15,2)) as casescostchild
		,ISNULL(count (distinct case when c.age>=18 then c.id end),0) + ISNULL(count (distinct case when c.age<18 then c.id end),0) as col8
		,ISNULL(sum(case when c.age>=18 then m.[Quantity] end),0) +  ISNULL(sum(case when c.age<18 then m.[Quantity] end),0) as col9
		,sum (case when c.age>=18 then ISNULL(m.Price*m.Quantity,0)/*+ISNULL(mes.Tariff*mes.Quantity,0)*/ else 0 end)+sum (case when c.age<18 then ISNULL(m.TotalPrice,0)/*+ISNULL(mes.Tariff,0)*/ else 0 end) as col10
		FROM [dbo].[t_Meduslugi] m
  inner JOIN [dbo].[t_Case] c on m.[rf_idCase]=c.[id]
  INNER JOIN [dbo].[vw_sprMU] s on s.[MU]=m.[MU]
  INNER JOIN [dbo].[t_RecordCasePatient] rcp on rcp.id = c.rf_idRecordCasePatient
  INNER JOIN [dbo].[t_RegistersAccounts] ra on ra.id = rcp.rf_idRegistersAccounts
  INNER JOIN [dbo].[t_File] f on f.id = ra.rf_idFiles 
  INNER JOIN [OMS_NSI].[dbo].[tMO] mo on substring(mo.[tfomsCode],1,6)=c.rf_idMO
  LEFT JOIN [dbo].[t_MES] mes on mes.[rf_idCase]=c.[id]
  
  where
	 ra.ReportYear >= @p_StartReportYear and ra.ReportYear <= @p_EndReportYear 
	 and ra.ReportMonth >= @p_StartReportMonth and ra.ReportMonth <= @p_EndReportMonth  
	 and f.DateRegistration >=@p_StartRegistrationDate and f.DateRegistration-1 <=@p_EndRegistrationDate 
	 and m.MUGroupCode=@p_ProvideCondition 
	 and ((ra.PrefixNumberRegister=@p_InsPlace and @p_InsPlace=34) or (@p_InsPlace<>34 and ra.PrefixNumberRegister<>34))
	 and f.CodeM = case when @p_MOCode=-1 then f.CodeM else @p_MOCode  end
	 group by m.MU +' '+ s.[MUName]
end
END
GO
GRANT EXECUTE ON  [dbo].[usp_selectReportMedServices] TO [db_AccountOMS]
GO
