SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[usp_selectAccounts2019]
@p_StartDate nvarchar(8),
@p_EndDate nvarchar(8),
@p_StartReportPeriod varchar(6)=null,
@p_EndReportPeriod varchar(6)=null,
@p_FilialCode int,
@p_LPUCode int,
@p_LPUManualEnteredCode bigint=-1,
@p_Type int
AS
declare @startDate datetime = CONVERT(datetime, @p_StartDate)
declare @endDate datetime = CONVERT(datetime, @p_EndDate + ' 23:59:59')

create table #t (fid int, fdr datetime, codem varchar(6), mnames varchar(250), ryear smallint, rmonth int, datereg date, ampay decimal(15, 2),
				 acc varchar(25),idsmo char(5), raid int, smoname varchar(250), fil varchar(50), cn int)
create table #casesn (raid int, cn int)

SELECT case when @p_Type=1 then 'H' when @p_Type=2 then 'F' end pType INTO #pT 

insert into #t
SELECT 
      f.[id],
      f.[DateRegistration] as ДатаРегистрации,
      f.[CodeM] as КодМО,
      mo.[mNameS] as МО,
      ra.[ReportYear] as ОтчетныйГод,
      ra.[ReportMonth] as ОтчетныйМесяц,
      ra.[DateRegister] as ДатаСчета,
      ra.[AmountPayment] as Выставлено,
	  ra.Account as НомерСчета,
      ra.[rf_idSMO] as КодСМО,
      ra.id raid,
      smo.[Наименование краткое] as СМО,
      fil.[filialName] as Филиал,
	  f.[CountSluch] cn 
  FROM [dbo].[t_File] f
  inner join dbo.t_RegistersAccounts ra on ra.[rf_idFiles]=f.[id]
  inner join [OMS_NSI].[dbo].[V_SMO] smo on ra.[rf_idSMO]=smo.[Код СМО]
  inner join [OMS_NSI].[dbo].[tMO] mo on f.[CodeM]=LEFT(mo.tfomsCode, 6) 
  inner join [OMS_NSI].[dbo].[tFilial] fil on fil.[filialId]=mo.[rf_FilialId]
  inner join #pT pt on pt.pType=f.TypeFile
 where 
 f.[DateRegistration] >=@startDate and f.[DateRegistration] <=@endDate 
 and ra.ReportYearMonth between @p_StartReportPeriod and @p_EndReportPeriod
 --and fil.[filialId] = case when @p_FilialCode=-1 then fil.[filialId] else @p_FilialCode end
 and f.[CodeM] = case when @p_LPUCode=-1 then f.[CodeM] else @p_LPUCode end
 --and f.[CodeM] = case when @p_LPUManualEnteredCode=-1 then f.[CodeM] else @p_LPUManualEnteredCode end
 and ra.[PrefixNumberRegister]<>'34' --без иногородних
 
 --insert into #casesn
 --select     t.raid, 
 --     count (c.id) as КоличествоСлучаев
 --from #t as t
 --inner join dbo.t_RecordCasePatient rcp on rcp.rf_idregistersAccounts=t.raid
 --inner join dbo.t_Case c on c.[rf_idRecordCasePatient] = rcp.id
 --group by t.raid
 
 select  
	  t.fid as id,
      t.fdr as ДатаРегистрации,
      t.codem as КодМО,
      t.codem + ' — ' + t.mnames as МО,
      t.ryear as ОтчетныйГод,
      t.rmonth as ОтчетныйМесяц,
      t.datereg as ДатаСчета,
      t.ampay as Выставлено,
      t.idsmo as КодСМО,
      t.acc as НомерСчета,
      t.idsmo + ' — ' +t.smoname as СМО,
      t.fil as Филиал,
      t.cn as КоличествоСлучаев
      from #t t
      --inner join #casesn cn on cn.raid=t.raid
      
      
  drop table #t
  drop table #casesn
  
  
GO
GRANT EXECUTE ON  [dbo].[usp_selectAccounts2019] TO [AccountsOMS]
GRANT EXECUTE ON  [dbo].[usp_selectAccounts2019] TO [db_AccountOMS]
GO
