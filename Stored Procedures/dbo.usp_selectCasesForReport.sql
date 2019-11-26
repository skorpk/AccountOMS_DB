SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[usp_selectCasesForReport]
@p_CaseId bigint,
@p_CanSeePersonalData nvarchar(1) = 0
AS
BEGIN
if (@p_CanSeePersonalData='1')
  select 
    c.id AS Id
  , c.idRecordCase AS Случай
  , f.DateRegistration AS DateOfRegistrationOfAccount
  , mo1.mNameS AS МО
  , ra.[PrefixNumberRegister]+'-'+CONVERT(varchar, ra.[NumberRegister])+'-'+CONVERT(varchar, ra.[PropertyNumberRegister])+isnull(ra.[Letter],'') as НомерСчета
  , ra.[DateRegister] as ДатаСчета
  , ra.ReportMonth AS ОтчетныйМесяц
  , ra.ReportYear AS ОтчетныйГод
  , v6.Name AS Условия
  , v8.Name AS ВидПомощи
  , dmo.NAM_MOK AS Направление
  , CASE WHEN c.HopitalisationType = 1 THEN 'Плановая' ELSE 'Экстренная' END AS ТипГоспитализации
  , v2.name AS Профиль
  , CASE WHEN c.IsChildTariff = 0 THEN 'Взрослый' ELSE 'Детский' END AS Тариф
  , c.NumberHistoryCase AS НомерКарты
  , c.DateBegin AS Начат
  , c.DateEnd AS Окончен
  , c.AmountPayment AS Выставлено
  , v9.Name AS Результат
  , v12.Name AS Исход
  , smo.[Наименование краткое] as СМО
  , v4.Name AS СпециальностьМедРаботника
  , v10.Name AS СпособОплаты
  , rp.Fam + ' ' + rp.Im + ' ' + ISNULL(rp.Ot,'') AS Пациент
  , v5.Name AS Пол
  , rp.BirthDay AS ДатаРождения
  , c.age AS Возраст
  , rp.BirthPlace AS МестоРождения
  , rpa.Fam+' '+rpa.Im+' '+ISNULL(rpa.Ot,'') AS [Сопровождающий]
  , dt.Name AS [ВидУдостоверения]
  , rpd.SeriaDocument AS Серия
  , rtrim(rpd.NumberDocument) AS Номер 
  , rpd.SNILS  AS СНИЛС_Пац
  , rcp.SeriaPolis AS СерияПолиса
  , rcp.NumberPolis AS НомерПолиса
  , fil.FilialId AS CodeFilial
  , f.CodeM AS CodeMO
  , fil.filialName AS Филиал
  --, mo2.NameS AS МО
  , d.DS1 AS КодДиагноза
  , mkb.Diagnosis AS НаимБолезни
  ,/*rpd.OKATO*/okato1.namel AS АдресПsрописки
  ,/*rpd.OKATO_place*/okato2.namel  AS АдресПроживания
  , ra.[AmountPayment] as [СуммаСчета]
  , v14.[NAME] as  ФормаМП
  , rcp.[BirthWeight] as ВесНоворожденного
  , cast(v18.[Code] as varchar)+' — '+v18.Name as ВидВМП
  , cast(v19.[Code] as varchar)+' — '+v19.Name as МетодВМП
  , cast([rf_idDoctor] as bigint) as СНИЛС_Врача
  , RTRIM(rcp.[NewBorn]) as NewBorn
  from
  dbo.t_Case AS c INNER JOIN
  dbo.t_RecordCasePatient AS rcp ON c.rf_idRecordCasePatient = rcp.id INNER JOIN
  dbo.t_RegistersAccounts AS ra ON rcp.rf_idRegistersAccounts = ra.id INNER JOIN
  OMS_NSI.dbo.V_SMO smo on ra.[rf_idSMO]=smo.[Код СМО] inner join
  dbo.t_File AS f ON ra.rf_idFiles = f.id INNER JOIN
  OMS_NSI.dbo.tMO AS mo1  ON f.CodeM =LEFT(mo1.tfomsCode, 6) INNER JOIN
  OMS_NSI.dbo.tFilial AS fil ON mo1.rf_FilialId = fil.FilialId INNER JOIN
  dbo.t_RegisterPatient AS rp ON rp.rf_idRecordCase = rcp.id INNER JOIN
  OMS_NSI.dbo.sprV002 AS v2 ON c.rf_idV002 = v2.Id INNER JOIN
  OMS_NSI.dbo.sprV006 AS v6 ON c.rf_idV006 = v6.Id INNER JOIN
  OMS_NSI.dbo.sprV008 AS v8 ON c.rf_idV008 = v8.Id INNER JOIN 
  OMS_NSI.dbo.sprV010 AS v10 ON c.rf_idV010 = v10.Id INNER JOIN
  OMS_NSI.dbo.sprV005 AS v5 ON rp.rf_idV005 = v5.Id INNER JOIN 
  dbo.vw_Diagnosis AS d ON c.id=d.rf_idCase INNER JOIN  
  OMS_NSI.dbo.sprMKB AS mkb ON mkb.DiagnosisCode=d.DS1  
  
  LEFT JOIN
  OMS_NSI.dbo.sprMO AS dmo ON dmo.mcod = c.rf_idDirectMO LEFT JOIN
  OMS_NSI.dbo.sprV009 AS v9 ON c.rf_idV009 = v9.Id LEFT JOIN 
  OMS_NSI.dbo.sprV012 AS v12 ON c.rf_idV012 = v12.Id LEFT JOIN
  dbo.t_RegisterPatientAttendant AS rpa ON rpa.rf_idRegisterPatient = rp.id LEFT JOIN
  dbo.t_RegisterPatientDocument AS rpd ON rpd.rf_idRegisterPatient = rp.id LEFT JOIN 
  OMS_NSI.dbo.vw_Accounts_OKATO okato1 on rpd.OKATO=okato1.okato LEFT JOIN 
  OMS_NSI.dbo.vw_Accounts_OKATO okato2 on rpd.OKATO_place=okato2.okato LEFT JOIN 
  OMS_NSI.dbo.sprDocumentType AS dt ON rpd.rf_idDocumentType = dt.ID LEFT JOIN 
  --OMS_NSI.dbo.sprMedicalSpeciality AS v4 ON c.rf_idV004 = v4.Id LEFT JOIN 
  dbo.vw_sprMedicalSpeciality v4 on c.rf_idV004=v4.id AND c.DateEnd>=v4.DateBeg AND c.DateEnd<v4.DateEnd LEFT JOIN
  OMS_NSI.dbo.sprV018 AS v18 ON c.rf_idV018 = v18.Code LEFT JOIN 
  OMS_NSI.dbo.sprV019 AS v19 on v19.Code = c.rf_idV019 and v19.DateBeg<=c.DateEnd and v19.DateEnd>c.DateEnd LEFT JOIN
  OMS_NSI.dbo.sprV014 AS v14 ON c.rf_idV014 = v14.IDFRMMP 
  where  c.id=@p_CaseId
  
  
  
  else if (@p_CanSeePersonalData='0')
  select 1 
  --SELECT [id]
  --    ,[DateOfRegistrationOfAccount]
  --    ,[CodeLPU]
  --    ,[LPU]
  --    ,[НомерСчета]
  --    ,[ДатаСчета]
  --    ,[НаимБолезни]
  --    ,[КодФилиала]
  --    ,[КодСчета]
  --    ,[КодКонтингента]
  --    ,[Контингент]
  --    ,[КодРегионаПрописки]
  --    ,[РайонПрописки]
  --    ,[КодРегионаРаботы]
  --    ,[РайонРаботы]
  --    ,[Продолжаемость]
  --    ,[КодИсхода]
  --    ,[Исход]
  --    ,[КодУсловий]
  --    ,[Условия]
  --    ,[КодВидаУдостоврения]
  --    ,[ВидУдостоверения]
  --    ,[КодДиагноза]
  --    ,[Случай]
  --    ,[Начат]
  --    ,[Окончен]
  --    ,[Выставлено]
  --    ,[АдресПрописки]
  --    ,[МестоРаботы]
  --    ,[Пациент]
  --    ,[ДатаРождения]
  --    ,[Возраст]
  --    ,[Пол]
  --    ,[СерияПолиса]
  --    ,[НомерПолиса]
  --    ,[Сопровождающий]
  --    ,[Серия]
  --    ,[Номер]
  --    ,[СНИЛС]
  --    ,[КодСМО]
  --    ,[СМО]
  --    ,[СуммаСчета]
  --FROM [oms_accounts].[dbo].[vw_СлучаиБезПерсональныхДанных]
  --where [id] = @p_CaseId
END
GO
GRANT EXECUTE ON  [dbo].[usp_selectCasesForReport] TO [AccountsOMS]
GRANT EXECUTE ON  [dbo].[usp_selectCasesForReport] TO [db_AccountOMS]
GO
