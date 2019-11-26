SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE FUNCTION [dbo].[fn_VK_CodeIndex] (@CaseId int)
RETURNS int
AS
BEGIN
  declare @res int
  set @res = 0
  
  if exists(select top 1 * from t_Meduslugi where rf_idCase = @CaseId and (MU like '2.79.%' or MU like '2.81.%' or MU like '2.83.%' or MU like '2.84.%' or MU like '2.85.%' or MU like '2.86.%' or MU like '2.87.%' or MU like '2.88.%' or MU like '57.1.%'))
    set @res = 1
  
  if exists(select top 1 * from t_Meduslugi where rf_idCase = @CaseId and (MU like '2.80.%' or MU like '2.82.%'))
    set @res = 2
  
  if exists(select top 1 * from t_MES where rf_idCase = @CaseId and (MES like '2.78.%'))
    set @res = 3
  
  if exists(select top 1 * from t_Meduslugi where rf_idCase = @CaseId and (MU like '55.2.%' or MU like '55.3.%' or MU like '55.4.%'))
    set @res = 4
  
  if exists(select top 1 * from t_MES where rf_idCase = @CaseId and (MES like '55.5.%' or MES like '55.6.%' or MES like '55.7.%'))
    set @res = 5
  
  if exists(select top 1 * from t_MES where rf_idCase = @CaseId and (MES like '55.8.%'))
    set @res = 7
  
  if exists(select top 1 * from t_MES mes inner join t_Case c on mes.rf_idCase = c.id inner join t_RecordCasePatient p on c.rf_idRecordCasePatient = p.id inner join t_RegistersAccounts a on p.rf_idRegistersAccounts = a.id where rf_idCase = @CaseId and a.Account not like '%H%' and (MES like '11%' or MES like '12%'))
    set @res = 9
  
  if exists(select top 1 * from t_MES mes inner join t_Case c on mes.rf_idCase = c.id inner join t_RecordCasePatient p on c.rf_idRecordCasePatient = p.id inner join t_RegistersAccounts a on p.rf_idRegistersAccounts = a.id where rf_idCase = @CaseId and a.Account like '%H%' and (MES like '11%' or MES like '12%'))
    set @res = 11
  
  if exists(select top 1 * from t_Meduslugi where rf_idCase = @CaseId and (MU like '71.%'))
    set @res = 12
  
  RETURN @res
END
GO
GRANT EXECUTE ON  [dbo].[fn_VK_CodeIndex] TO [db_AccountOMS]
GO
