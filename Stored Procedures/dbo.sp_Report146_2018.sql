SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


CREATE PROCEDURE [dbo].[sp_Report146_2018]
  @ReportYear int,
  @ReportMonth int,
  @DateRegBegY date,
  @DateRegBegM date,
  @DateRegEnd date  -- до этой даты (не включительно)
AS
BEGIN
  if Object_ID(N't_146', N'U') is not null drop table [t_146];
  if Object_ID(N't_146_m', N'U') is not null drop table [t_146_m];
  if Object_ID(N't_146_y', N'U') is not null drop table [t_146_y];
  
  create table t_146 (
    DateRegistration datetime,
    id int,
    rf_idSMO int,
    rf_idMO int,
    MUGroupCode tinyint,
    MUUnGroupCode tinyint,
    MUCode smallint,
    MUSurgery varchar(20),
    Quantity decimal(6, 2),
    AmountPayment decimal(15, 2),
	ENP varchar(16),
    Age smallint,
    VMP_K varchar(1),
    UE varchar(20),
    AdultUET numeric(5, 2),
    ChildUET numeric(5, 2)
  ) on [PRIMARY];
  
  -- проверка уникальности записей справочника по стоматологии
  declare @countErr int
  select @CountErr = count(*)
  from
  (
    select mu.code, uet.rf_AgeGroupId, count(mu.code) as countCode
    from OMS_NSI.dbo.sprDentalMUUET uet
    inner join OMS_NSI.dbo.sprDentalMU mu on mu.DentalMUId = uet.rf_DentalMUId
    where uet.dateBeg < '20190101' and uet.dateEnd > '20180101'
    group by mu.code, uet.rf_AgeGroupId
    having count(mu.code) > 1
  ) z
  
  if @CountErr > 0
  begin
    select 1
    return
  end
  
  -- подготовка #vmpk
  select * into #vmpk from
    (VALUES ('1', 'Первичная медико-санитарная'), ('3', 'Специализированная, в том числе высокотехнологичная'), 
    ('2', 'Скорая, в том числе специализированная (санитарно-авиационная), медицинская помощь')) t (id,name)
  
  -- отбор #files
  select id, DateRegistration into #files from t_File where DateRegistration > @DateRegBegY and DateRegistration < @DateRegEnd
  
  -- отбор accounts
  select id, rf_idFiles, Letter, rf_idSMO into #accounts from t_RegistersAccounts 
  where ReportYear = @ReportYear and ReportMonth <= @ReportMonth

  -- подготовка ует по медуслугам
  select gr.MUGroupCode * 100000 + ug.MUUnGroupCode * 1000 + mu.MUCode as MUInt, mu.AdultUET, mu.ChildUET
  into #uet_mu
  from OMS_NSI.dbo.sprMUGroup gr
  inner join OMS_NSI.dbo.sprMUUnGroup ug on ug.rf_MUGroupId = gr.MUGroupId
  inner join OMS_NSI.dbo.sprMU mu ON ug.MUUnGroupId = mu.rf_MUUnGroupId 
  
  -- подготовка ует по услугам стоматологии
  select z.code, z.AdultUET, z.ChildUET
  into #uet_st
  from (
  select code,
  (select uet.UET from OMS_NSI.dbo.sprDentalMUUET as uet where (uet.dateBeg<'20190101') and (uet.dateEnd>'20180101') and (uet.rf_DentalMUId = mu.DentalMUId) and (uet.rf_AgeGroupId=1)) as AdultUET,
  (select uet.UET from OMS_NSI.dbo.sprDentalMUUET as uet where (uet.dateBeg<'20190101') and (uet.dateEnd>'20180101') and (uet.rf_DentalMUId = mu.DentalMUId) and (uet.rf_AgeGroupId=2)) as ChildUET
  from OMS_NSI.dbo.sprDentalMU as mu
  ) z
  where (z.AdultUET is not null or z.ChildUET is not null)

  -- выборка по медуслугам без стоматологии
  insert into t_146
  select f.DateRegistration, c.id, a.rf_idSMO, c.rf_idMO, m.MUGroupCode, m.MUUnGroupCode, m.MUCode, m.MUSurgery, 
    case 
	when 
	(
	  (c.rf_idV006 = 3 and m.MUGroupCode = 2 and c.rf_IdV008 in (1, 11, 12) and a.Letter <> 'T' and a.Letter <> 'K' and m.MUUnGroupCode <> 4 and m.MUUnGroupCode <> 90 and m.MUUnGroupCode <> 91)
      or (c.rf_idV006 = 2 and m.MUGroupCode = 55)
      or (c.rf_idV006 = 4)
      or (c.rf_idV006 = 3 and m.MUGroupCode = 2 and c.rf_IdV008 in (13, 31, 21) and a.Letter <> 'T' and a.Letter <> 'K')
      or (c.rf_idV006 = 1 and m.MUGroupCode = 1 and m.MUUnGroupCode = 11)
      or (a.Letter = 'K')
	)
	then m.Quantity else 0 end as Quantity,
    c.AmountPayment, 
	case when (m.MUGroupCode = 60 and m.MUUnGroupCode = 3) then null else ps.ENP end as ENP,
	c.Age,
    case when ((c.rf_idV006 = 3 and a.Letter <> 'T' and a.Letter <> 'K' and c.rf_IdV008 in (1, 11, 12)) or (c.rf_idV006 = 2 and m.MUInt = 5501003) or (a.Letter = 'T')) then '1' 
       else case when (c.rf_idV006 = 4) then '2' else '3' end end as VMP_K,
    case when (c.rf_idV006 = 4) then 'вызов СМП' 
       else case when (a.Letter = 'K') then 'отдельные услуги' 
       else case when ((c.rf_idV006 = 3) and ((a.Letter <> 'T' and a.Letter <> 'K' and c.rf_IdV008 in (1, 11, 12)) or (a.Letter <> 'T' and a.Letter <> 'K' and m.MUGroupCode = 2 and c.rf_IdV008 in (13, 31, 21)) or (m.MUGroupCode = 60 and m.MUUnGroupCode = 3))) then 'врачебные приемы' 
       else case when ((c.rf_idV006 = 1) and ((m.MUGroupCode = 1 and m.MUUnGroupCode = 11) or (m.MUGroupCode = 60 and m.MUUnGroupCode = 3))) then 'койко-день'
       else case when ((c.rf_idV006 = 2) and ((m.MUGroupCode = 55) or (m.MUGroupCode = 60 and m.MUUnGroupCode = 3))) then 'пациенто-день' 
       else null end end end end end as UE,
    isnull(#uet_mu.AdultUET, 0) as AdultUET, isnull(#uet_mu.ChildUET, 0) as ChildUET
  from #files f
  inner join #accounts a on a.rf_idFiles = f.id
  inner join t_RecordCasePatient p on p.rf_idRegistersAccounts = a.id
  inner join t_Case c on c.rf_idRecordCasePatient = p.id
  inner join t_PatientSMO ps on ps.rf_idRecordCasePatient = p.id
  inner join t_Meduslugi m on m.rf_idCase = c.id
  left join #uet_mu on #uet_mu.MUInt = m.MUInt
  left join t_MES mes on mes.rf_idCase = c.id
  where (c.rf_idV006 = 3 and c.rf_IdV008 in (1, 11, 12) and a.Letter <> 'T' and a.Letter <> 'K')
    or (c.rf_idV006 = 2 and m.MUGroupCode = 55)
    or (c.rf_idV006 = 4)
    or (c.rf_idV006 = 3 and m.MUGroupCode = 2 and c.rf_IdV008 in (13, 31, 21) and a.Letter <> 'T' and a.Letter <> 'K')
    or (c.rf_idV006 = 3 and m.MUGroupCode = 60 and m.MUUnGroupCode = 3)
    or (c.rf_idV006 = 1 and m.MUGroupCode = 1 and m.MUUnGroupCode = 11)
    or (c.rf_idV006 = 1 and m.MUGroupCode = 60 and m.MUUnGroupCode = 3)
    or (c.rf_idV006 = 2 and m.MUGroupCode = 60 and m.MUUnGroupCode = 3)
    or (a.Letter = 'K')
  
  -- выборка по стоматологии
  insert into t_146
  select f.DateRegistration, c.id, a.rf_idSMO, c.rf_idMO, m.MUGroupCode, m.MUUnGroupCode, m.MUCode, m.MUSurgery, 
    case when (c.rf_idv006 = 1 or c.rf_idv006 = 2) and (m.MUGroupCode = 0) then 0 else m.Quantity end as Quantity,
    c.AmountPayment, ps.ENP, c.Age,
    '1' as VMP_K,
    'УЕТ' as UE,
    isnull(#uet_st.AdultUET, 0) as AdultUET, isnull(#uet_st.ChildUET, 0) as ChildUET
  from #files f
  inner join #accounts a on a.rf_idFiles = f.id
  inner join t_RecordCasePatient p on p.rf_idRegistersAccounts = a.id
  inner join t_Case c on c.rf_idRecordCasePatient = p.id
  inner join t_PatientSMO ps on ps.rf_idRecordCasePatient = p.id
  inner join t_Meduslugi m on m.rf_idCase = c.id
  left join #uet_st on #uet_st.code = m.MUSurgery
  where (a.Letter = 'T' and m.MUGroupCode <> 2)
  
  -- удалить записи с UE = null
  --delete from t_146 where UE is null

  -- агрегированные данные за месяц
  select mo.filialName, mo.CodeM, mo.NameS, s.smocod, s.sNameS, zz.VMP_K, #vmpk.name as VidMP, zz.UE,
         sum(zz.idKey) as C, sum(zz.Quantity) as Q, sum(zz.AmountPayment) as Stoim
  into t_146_m
  from
  (
    select case when z.ENP is null then 0 else 1 end as idKey, z.rf_idSMO, z.rf_idMO, sum(z.AmountPayment) as AmountPayment, sum(z.Quantity) as Quantity,
           z.VMP_K, z.UE, z.ENP
    from
    ( -- группировка по случаям
      select id, rf_idSMO, rf_idMO, AmountPayment, VMP_K, UE, ENP,
             sum(case when Age < 18 then ChildUET * Quantity else AdultUET * Quantity end) as Quantity
      from t_146
      where DateRegistration > @DateRegBegM and DateRegistration < @DateRegEnd
      group by id, rf_idSMO, rf_idMO, AmountPayment, VMP_K, UE, ENP
    ) z
    group by z.rf_idSMO, z.rf_idMO, z.VMP_K, z.UE, z.ENP
  ) zz
  inner join #vmpk on #vmpk.id = zz.VMP_K
  inner join OMS_NSI.dbo.vw_sprT001_A as mo on mo.CodeM = zz.rf_idMO
  inner join (select smocod, sNameS from OMS_NSI.dbo.tSMO union all select '34', 'Иногородние') as s on zz.rf_idSMO = s.smocod
  group by mo.filialName, mo.CodeM, mo.NameS, s.smocod, s.sNameS, zz.VMP_K, #vmpk.name, zz.UE

  -- агрегированные данные за год
  select mo.filialName, mo.CodeM, mo.NameS, s.smocod, s.sNameS, zz.VMP_K, #vmpk.name as VidMP, zz.UE,
         sum(zz.idKey) as C, sum(zz.Quantity) as Q, sum(zz.AmountPayment) as Stoim
  into t_146_y
  from
  (
    select case when z.ENP is null then 0 else 1 end as idKey, z.rf_idSMO, z.rf_idMO, sum(z.AmountPayment) as AmountPayment, sum(z.Quantity) as Quantity,
           z.VMP_K, z.UE, z.ENP
    from
    ( -- группировка по случаям
      select id, rf_idSMO, rf_idMO, AmountPayment, VMP_K, UE, ENP,
             sum(case when Age < 18 then ChildUET * Quantity else AdultUET * Quantity end) as Quantity
      from t_146
      group by id, rf_idSMO, rf_idMO, AmountPayment, VMP_K, UE, ENP
    ) z
    group by z.rf_idSMO, z.rf_idMO, z.VMP_K, z.UE, z.ENP
  ) zz
  inner join #vmpk on #vmpk.id = zz.VMP_K
  inner join OMS_NSI.dbo.vw_sprT001_A as mo on mo.CodeM = zz.rf_idMO
  inner join (select smocod, sNameS from OMS_NSI.dbo.tSMO union all select '34', 'Иногородние') as s on zz.rf_idSMO = s.smocod
  group by mo.filialName, mo.CodeM, mo.NameS, s.smocod, s.sNameS, zz.VMP_K, #vmpk.name, zz.UE
  
  select 0
END

GO
