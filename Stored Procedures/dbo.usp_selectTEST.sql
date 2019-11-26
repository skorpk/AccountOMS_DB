SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[usp_selectTEST]
@p_StartRegistrationDate nvarchar(10) = null,
@p_EndRegistrationDate nvarchar(10) = null,
@p_StartReportMonth int,
@p_StartReportYear int,
@p_EndReportMonth int,
@p_EndReportYear int,
@p_InsPlace int, --0 - Волгоградская область, 34 - другой регион
@p_MOCode nvarchar(2000) --Код медорганизации
AS
begin

select 
	  f.CodeM
	  ,t001.[NameS]
	  , count(distinct case when (mes.MES='70.5.1') then c.id end)
      , sum(case when (mes.MES='70.5.1') then ISNULL(m.Quantity,0) end)
	  , count(distinct case when (mes.MES='70.5.2') then c.id end)
      , sum(case when (mes.MES='70.5.2') then ISNULL(m.Quantity,0) end)
	  , count(distinct c.id)
      , sum(ISNULL(m.Quantity,0))
      
		FROM [dbo].[t_Meduslugi] m
   inner JOIN [dbo].[t_Case] c on m.[rf_idCase]=c.[id]
   INNER JOIN [dbo].[t_RecordCasePatient] rcp on rcp.id = c.rf_idRecordCasePatient
   INNER JOIN [dbo].[t_RegistersAccounts] ra on ra.id = rcp.rf_idRegistersAccounts
   INNER JOIN [dbo].[t_File] f on f.id = ra.rf_idFiles 
 --inner JOIN fn_iter_intlist_to_table(@p_MOCode) i ON f.CodeM = i.number
   inner join [oms_NSI].[dbo].[vw_sprT001] t001 on t001.[CodeM] = f.CodeM
   LEFT JOIN [dbo].[t_MES] mes on mes.[rf_idCase]=c.[id]
   
  where
	 ra.ReportYearMonth >= (CONVERT([int],CONVERT([char](4),@p_StartReportYear,0)+right('0'+CONVERT([varchar](2),@p_StartReportMonth,0),(2)),0)) and ra.ReportYearMonth <= (CONVERT([int],CONVERT([char](4),@p_EndReportYear,0)+right('0'+CONVERT([varchar](2),@p_EndReportMonth,0),(2)),0)) 
	 and f.DateRegistration >=@p_StartRegistrationDate and f.DateRegistration-1 <=@p_EndRegistrationDate 
	 and ((ra.PrefixNumberRegister=@p_InsPlace and @p_InsPlace=34) or (@p_InsPlace<>34 and ra.PrefixNumberRegister<>34))
	 and m.MUGroupCode=2 --амбулаторная помощь 
	 and mes.MES like '70.5%'
	 group by f.CodeM ,t001.[NameS]
	 
end
GO
GRANT EXECUTE ON  [dbo].[usp_selectTEST] TO [db_AccountOMS]
GO
