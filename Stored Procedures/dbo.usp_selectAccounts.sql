SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[usp_selectAccounts]
@p_StartDate nvarchar(10),--='19000101',
@p_EndDate nvarchar(10),--='20111201',
@p_FilialCode int,
@p_LPUCode int,
@p_LPUManualEnteredCode bigint=-1
AS
create table #t (fid int, fdr datetime, codem varchar(6), mnames varchar(250), ryear smallint, rmonth int, datereg date, ampay decimal(15, 2),
				 acc varchar(25),idsmo char(5), raid int, smoname varchar(250), fil varchar(50))
create table #casesn (raid int, cn int)

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
      fil.[filialName] as Филиал 
  FROM [dbo].[t_File] f
  inner join dbo.t_RegistersAccounts ra on ra.[rf_idFiles]=f.[id]
  inner join [OMS_NSI].[dbo].[V_SMO] smo on ra.[rf_idSMO]=smo.[Код СМО]
  inner join [OMS_NSI].[dbo].[tMO] mo on f.[CodeM]=LEFT(mo.tfomsCode, 6) 
  --inner join [OMS_NSI].[dbo].[tFilial] fil on fil.[filialCode]=mo.[rf_FilialId]
  inner join [OMS_NSI].[dbo].[tFilial] fil on fil.[filialId]=mo.[rf_FilialId]
 where 
 f.[DateRegistration] >=@p_StartDate and f.[DateRegistration] -1 <=@p_EndDate 
 and fil.[filialId] = case when @p_FilialCode=-1 then fil.[filialId] else @p_FilialCode end
 and f.[CodeM] = case when @p_LPUCode=-1 then  f.[CodeM] else @p_LPUCode end
 and f.[CodeM] = case when @p_LPUManualEnteredCode=-1 then f.[CodeM] else @p_LPUManualEnteredCode end
 and ra.[PrefixNumberRegister]<>'34' --без иногородних
 
 insert into #casesn
 select     t.raid, 
      count (c.id) as КоличествоСлучаев
 from #t as t
 inner join dbo.t_RecordCasePatient rcp on rcp.rf_idregistersAccounts=t.raid
 inner join dbo.t_Case c on c.[rf_idRecordCasePatient] = rcp.id
 group by t.raid
 
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
      cn.cn as КоличествоСлучаев
      from #t t
      inner join #casesn cn on cn.raid=t.raid
      
      
  drop table #t
  drop table #casesn
  
  
GO
GRANT EXECUTE ON  [dbo].[usp_selectAccounts] TO [AccountsOMS]
GRANT EXECUTE ON  [dbo].[usp_selectAccounts] TO [db_AccountOMS]
GO
