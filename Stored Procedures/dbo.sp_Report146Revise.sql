SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[sp_Report146Revise]
  @ReportYear int,
  @ReportMonth int,
  @DateRegBegY date,
  @DateRegBegM date,
  @DateRegEnd date  -- до этой даты (не включительно)
AS
BEGIN
  declare @KolvoNoIn146 int -- количество отсутствующих случаев в t_146
  declare @SumCasesY decimal(15, 2) -- сумма по зарегистрированным счетам с начала года
  declare @SumCasesZ decimal(15, 2) -- сумма по зарегистрированным счетам с начала года (по законченным случаям)
  declare @Sum146 decimal(15, 2) -- сумма по всем счетам в таблице t_146 (за год)
  declare @Sum146Y decimal(15, 2) -- сумма по всем счетам в таблице t_146_y (с начала года)
  declare @SumCasesM decimal(15, 2) -- сумма по зарегистрированным счетам за месяц
  declare @Sum146M decimal(15, 2) -- сумма по всем счетам в таблице t_146_m (за месяц)
  
  -- временная таблица с id случаев в 146-м
  select z.id into #tid
  from (select id from t_146) z

  -- проверка отсутствия зарегистрированных случаев в t_146
  select @KolvoNoIn146 = count(c.id) from t_File f
  inner join t_RegistersAccounts a on a.rf_idFiles = f.id
  inner join t_RecordCasePatient p on p.rf_idRegistersAccounts = a.id
  inner join t_Case c on c.rf_idRecordCasePatient = p.id
  where f.DateRegistration > @DateRegBegY and f.DateRegistration < @DateRegEnd
  and a.ReportYear = @ReportYear
  and a.ReportMonth <= @ReportMonth
  and c.id not in (select id from #tid)
  
  -- сумма по зарегистрированным счетам с начала года
  select @SumCasesY = sum(c.AmountPayment) from t_File f
  inner join t_RegistersAccounts a on a.rf_idFiles = f.id
  inner join t_RecordCasePatient p on p.rf_idRegistersAccounts = a.id
  inner join t_Case c on c.rf_idRecordCasePatient = p.id
  where f.DateRegistration > @DateRegBegY and f.DateRegistration < @DateRegEnd
  and a.ReportYear = @ReportYear
  and a.ReportMonth <= @ReportMonth
  
  -- сумма по зарегистрированным счетам с начала года (по законченным случаям)
  select @SumCasesZ = sum(z.AmountPayment) from t_File f
  inner join t_RegistersAccounts a on a.rf_idFiles = f.id
  inner join t_RecordCasePatient p on p.rf_idRegistersAccounts = a.id
  inner join t_CompletedCase z on z.rf_idRecordCasePatient = p.id
  where f.DateRegistration > @DateRegBegY and f.DateRegistration < @DateRegEnd
  and a.ReportYear = @ReportYear
  and a.ReportMonth <= @ReportMonth

  -- сумма по всем счетам в таблице t_146 (за год)
  select @Sum146 = sum(z.AmountPayment) from (select AmountPayment from t_146 group by id, AmountPayment) z
  
  -- сумма по всем счетам в таблице t_146_y (с начала года)
  select @Sum146Y = sum(Stoim) from t_146_y
  
  -- сумма по зарегистрированным счетам за месяц
  select @SumCasesM = sum(c.AmountPayment) from t_File f
  inner join t_RegistersAccounts a on a.rf_idFiles = f.id
  inner join t_RecordCasePatient p on p.rf_idRegistersAccounts = a.id
  inner join t_Case c on c.rf_idRecordCasePatient = p.id
  where f.DateRegistration > @DateRegBegM and f.DateRegistration < @DateRegEnd
  and a.ReportYear = @ReportYear
  and a.ReportMonth <= @ReportMonth
  
  -- сумма по всем счетам в таблице t_146_m (за месяц)
  select @Sum146M = sum(Stoim) from t_146_m
  
  
  select 
    isnull(@KolvoNoIn146, 0) as KolvoNoIn146,
    isnull(@SumCasesY, 0) as SumCasesY,
	isnull(@SumCasesY, 0) as SumCasesZ,
    isnull(@Sum146, 0) as Sum146,
    isnull(@Sum146Y, 0) as Sum146Y,
    isnull(@SumCasesM, 0) as SumCasesM,
    isnull(@Sum146M, 0) as Sum146M
END
GO
