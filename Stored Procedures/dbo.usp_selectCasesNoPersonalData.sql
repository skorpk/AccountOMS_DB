SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[usp_selectCasesNoPersonalData]
@p_AccountCode int = null,
@p_StartDate nvarchar(10) = null,
@p_EndDate nvarchar(10) = null,
@p_FilialCode int=null,
@p_LPUCode int = null,
@p_LPUManualEnteredCode int=-1,
@p_ManualEnteredPacientName nvarchar(100)='',
@p_ManualEnteredPacSurname nvarchar(100)='',
@p_ManualEnteredPacName nvarchar(100)='',
@p_ManualEnteredPacPatronymic nvarchar(100)='',
@p_PatientBirthYear int=null
AS
--BEGIN
--if (@p_AccountCode is not null)
--begin
--  select --count(*)
--    c.id AS CaseId
--  , c.idRecordCase AS Случай
--  , v6.Name AS УсловияОказания
--  , v8.Name AS ВидПомощи
--  , dmo.NAM_MOK AS Направление
--  , CASE WHEN c.HopitalisationType = 1 THEN 'Плановая' ELSE 'Экстренная' END AS ТипГоспитализации
--  , v2.name AS Профиль
--  , '' AS Тариф
--  , c.NumberHistoryCase AS НомерКарты
--  , c.DateBegin AS Начат
--  , c.DateEnd AS Окончен
--  , c.AmountPayment AS Выставлено
--  , v9.Name AS Результат
--  , v12.Name AS Исход
--  , v4.Name AS СпециальностьМедРаботника
--  , v10.Name AS СпособОплаты
--  , '' AS Пациент
--  , '' AS Пол
--  , '' AS ДатаРождения
--  , '' AS Возраст
--  , '' AS МестоРождения
--  , '' AS Представитель
--  , '' AS ТипДокумента
--  , '' AS Серия
--  , '' AS Номер 
--  , '' AS СНИЛС
--  , '' AS СерияПолиса
--  , '' AS НомерПолиса
--  , '' AS ДатаРегистрации
--  , fil.FilialId AS CodeFilial
--  , f.CodeM AS CodeMO
--  , fil.filialName AS Филиал
--  , mo2.NameS AS МО
--  , '' AS КодДиагноза
--  , '' AS Диагноз
--  , '' as АдресРегистрации
--  , '' as АдресМестаЖительства
  
--  from
--  dbo.t_Case AS c INNER JOIN
--  dbo.t_RecordCasePatient AS rcp ON c.rf_idRecordCasePatient = rcp.id INNER JOIN
--  dbo.t_RegistersAccounts AS ra ON rcp.rf_idRegistersAccounts = ra.id INNER JOIN
--  dbo.t_File AS f ON ra.rf_idFiles = f.id INNER JOIN
--  OMS_NSI.dbo.tMO AS mo1  ON f.CodeM =LEFT(mo1.tfomsCode, 6) INNER JOIN
--  OMS_NSI.dbo.tFilial AS fil ON mo1.rf_FilialId = fil.FilialId INNER JOIN
--  dbo.t_RegisterPatient AS rp ON rp.rf_idRecordCase = rcp.id INNER JOIN
--  OMS_NSI.dbo.sprV002 AS v2 ON c.rf_idV002 = v2.Id INNER JOIN
--  OMS_NSI.dbo.sprV006 AS v6 ON c.rf_idV006 = v6.Id INNER JOIN
--  OMS_NSI.dbo.sprV008 AS v8 ON c.rf_idV008 = v8.Id INNER JOIN 
--  OMS_NSI.dbo.sprV010 AS v10 ON c.rf_idV010 = v10.Id INNER JOIN
--  OMS_NSI.dbo.sprV005 AS v5 ON rp.rf_idV005 = v5.Id INNER JOIN
--  dbo.vw_Diagnosis AS d ON c.id=d.rf_idCase INNER JOIN 
--  OMS_NSI.dbo.sprMKB AS mkb ON mkb.DiagnosisCode=d.DS1 INNER JOIN
--  dbo.vw_sprT001_Report AS mo2 ON mo2.CodeM = f.CodeM LEFT JOIN
--  OMS_NSI.dbo.sprMO AS dmo ON dmo.mcod = c.rf_idDirectMO LEFT JOIN
--  OMS_NSI.dbo.sprV009 AS v9 ON c.rf_idV009 = v9.Id LEFT JOIN 
--  OMS_NSI.dbo.sprV012 AS v12 ON c.rf_idV012 = v12.Id LEFT JOIN
--  dbo.t_RegisterPatientAttendant AS rpa ON rpa.rf_idRegisterPatient = rp.id LEFT JOIN
--  dbo.t_RegisterPatientDocument AS rpd ON rpd.rf_idRegisterPatient = rp.id LEFT JOIN 
--  OMS_NSI.dbo.sprDocumentType AS dt ON rpd.rf_idDocumentType = dt.ID LEFT JOIN 
--  OMS_NSI.dbo.sprMedicalSpeciality AS v4 ON c.rf_idV004 = v4.Id
--  where  ra.id=@p_AccountCode
--  order by c.idRecordCase
--  end
  
  
--  else if(@p_AccountCode is null)
--  begin
--CREATE TABLE #t_tmpCases (caseid bigint, patient nvarchar(255), dateregistration datetime, codefilial bigint
--,filialname nvarchar(30), codemo char(6), idrecordcase int, hospitalisationtype nvarchar(20)
--,ischildtarif nvarchar(10), numberhistorycase nvarchar(50), datebegin date, dateend date, amountpayment decimal(15, 2)
--, rf_idrecordcasepatient int, rf_idv009 smallint ,rf_idv012 smallint, rf_idv002 smallint, rf_idv006 tinyint, rf_idv008 smallint, rf_idv010 tinyint
--, rf_iddirectmo char(6), rf_idv004 int, rcpid int, birthday date, age int, birthplace nvarchar(100)
--, seriapolis varchar(10), numberpolis varchar(20), rf_idrecordcase int, rf_idV005 tinyint, rpid int)
  
--INSERT INTO #t_tmpCases
--SELECT 
-- c.id
--, rp.Fam + ' ' + rp.Im + ' ' + rp.Ot AS Пациент
--, f.DateRegistration AS ДатаРегистрации
--, fil.FilialId AS CodeFilial
--, fil.filialName AS Филиал
--, f.CodeM AS CodeMO
--, c.idRecordCase AS НомерСлучая 
--, CASE WHEN c.HopitalisationType = 1 THEN 'Плановая' ELSE 'Экстренная' END AS ТипГоспитализации
--, CASE WHEN c.IsChildTariff = 0 THEN 'Взрослый' ELSE 'Детский' END AS Тариф
--, c.NumberHistoryCase AS НомерКарты
--, c.DateBegin AS Начат
--, c.DateEnd AS Окончен
--, c.AmountPayment AS Выставлено
--, c.rf_idRecordCasePatient
--, c.rf_idV009
--, c.rf_idV012
--, c.rf_idV002
--, c.rf_idV006
--, c.rf_idV008
--, c.rf_idV010
--, c.rf_idDirectMO
--, c.rf_idV004
--, rcp.id
--, rp.BirthDay AS ДатаРождения
--, c.age AS Возраст
--, rp.BirthPlace AS МестоРождения
--, rcp.SeriaPolis AS СерияПолиса
--, rcp.NumberPolis AS НомерПолиса
--, rp.rf_idRecordCase
--, rp.rf_idV005
--, rp.id 

--FROM  dbo.t_Case AS c INNER JOIN
--               dbo.t_RecordCasePatient AS rcp ON c.rf_idRecordCasePatient = rcp.id INNER JOIN
--               dbo.t_RegistersAccounts AS ra ON rcp.rf_idRegistersAccounts = ra.id INNER JOIN
--               dbo.t_File AS f ON ra.rf_idFiles = f.id INNER JOIN
--               OMS_NSI.dbo.tMO AS mo  ON f.CodeM =LEFT(mo.tfomsCode, 6) INNER JOIN
--               OMS_NSI.dbo.tFilial AS fil ON mo.rf_FilialId = fil.FilialId INNER JOIN
--               dbo.t_RegisterPatient AS rp ON rp.rf_idRecordCase = rcp.id
--  where  f.DateRegistration >=@p_StartDate and f.DateRegistration <=@p_EndDate 
--  and fil.FilialId = case when @p_FilialCode=-1 then fil.FilialId else @p_FilialCode end
--  and f.CodeM = case when @p_LPUCode=-1 then f.CodeM else @p_LPUCode end
--  and f.CodeM = case when @p_LPUManualEnteredCode=-1 then f.CodeM else @p_LPUManualEnteredCode end
--  --and rp.Fam + ' ' + rp.Im + ' ' + rp.Ot like case when @p_ManualEnteredPacientName='' then '%' else @p_ManualEnteredPacientName end
--  and rp.Fam like case when @p_ManualEnteredPacSurname='' then '%' else @p_ManualEnteredPacSurname end
--  and rp.Im like case when @p_ManualEnteredPacName='' then '%' else @p_ManualEnteredPacName end
--  and rp.Ot like case when @p_ManualEnteredPacPatronymic='' then '%' else @p_ManualEnteredPacPatronymic end
--  and ra.PrefixNumberRegister <> 34

  
--  select --count(*)
--    tmpC.caseid AS CaseId
--  , tmpC.idrecordcase AS Случай
--  , tmpC.amountpayment AS Выставлено
--  , v6.Name AS УсловияОказания
--  , v8.Name AS ВидПомощи
--  , dmo.NAM_MOK AS Направление
--  , tmpC.hospitalisationtype  AS ТипГоспитализации
--  , v2.name AS Профиль
--  , tmpC.ischildtarif AS Тариф
--  , tmpC.numberhistorycase AS НомерКарты
--  , tmpC.datebegin AS Начат
--  , tmpC.dateend AS Окончен
--  , tmpC.amountpayment AS Выставлено
--  , v9.Name AS Результат
--  , v12.Name AS Исход
--  , v4.Name AS СпециальностьМедРаботника
--  , v10.Name AS СпособОплаты
--  , tmpC.patient AS Пациент
--  , v5.Name AS Пол
--  , tmpC.birthday AS ДатаРождения
--  , tmpC.age AS Возраст
--  , tmpC.birthplace AS МестоРождения
--  , rpa.Fam+' '+rpa.Im+' '+rpa.Ot AS Представитель
--  , dt.Name AS ТипДокумента
--  , rpd.SeriaDocument AS Серия
--  , rtrim(rpd.NumberDocument) AS Номер 
--  , rpd.SNILS AS СНИЛС
--  , tmpC.seriapolis AS СерияПолиса
--  , tmpC.numberpolis AS НомерПолиса
--  , tmpC.dateregistration AS ДатаРегистрации
--  , tmpC.filialname AS Филиал
--  , tmpC.codemo AS CodeMO
--  , tmpC.codefilial AS CodeFilial
--  , mo.NameS AS МО
--  , d.DS1 AS КодДиагноза
--  , mkb.Diagnosis AS Диагноз
--  , rpd.OKATO /*okato1.namel*/ as АдресРегистрации
--  , rpd.OKATO_place /*okato2.namel*/ as АдресМестаЖительства
  
--  from #t_tmpCases tmpC INNER JOIN
--  OMS_NSI.dbo.sprV002 AS v2 ON tmpC.rf_idV002 = v2.Id INNER JOIN
--  OMS_NSI.dbo.sprV006 AS v6 ON tmpC.rf_idV006 = v6.Id INNER JOIN
--  OMS_NSI.dbo.sprV008 AS v8 ON tmpC.rf_idV008 = v8.Id INNER JOIN 
--  OMS_NSI.dbo.sprV010 AS v10 ON tmpC.rf_idV010 = v10.Id INNER JOIN
--  OMS_NSI.dbo.sprV005 AS v5 ON tmpC.rf_idV005 = v5.Id INNER JOIN
--  dbo.vw_Diagnosis AS d ON tmpC.caseid=d.rf_idCase    INNER JOIN 
--  OMS_NSI.dbo.sprMKB AS mkb ON mkb.DiagnosisCode=d.DS1 INNER JOIN 
--  dbo.vw_sprT001_Report AS mo ON mo.CodeM = tmpC.codemo LEFT JOIN
--  OMS_NSI.dbo.sprMO AS dmo ON dmo.mcod = tmpC.rf_idDirectMO LEFT JOIN
--  OMS_NSI.dbo.sprV009 AS v9 ON tmpC.rf_idV009 = v9.Id LEFT JOIN 
--  OMS_NSI.dbo.sprV012 AS v12 ON tmpC.rf_idV012 = v12.Id LEFT JOIN
--  dbo.t_RegisterPatientAttendant AS rpa ON rpa.rf_idRegisterPatient = tmpC.rpid LEFT JOIN
--  dbo.t_RegisterPatientDocument AS rpd ON rpd.rf_idRegisterPatient = tmpC.rpid LEFT JOIN 
--  OMS_NSI.dbo.sprDocumentType AS dt ON rpd.rf_idDocumentType = dt.ID LEFT JOIN 
--  OMS_NSI.dbo.sprMedicalSpeciality AS v4 ON tmpC.rf_idV004 = v4.Id /*LEFT OUTER JOIN  
--  dbo.vw_ОКАТОДляСлучаев AS okato1 ON okato1.ter + okato1.kod1 + okato1.kod2 + okato1.kod3 = rpd.OKATO LEFT OUTER JOIN
--  dbo.vw_ОКАТОДляСлучаев AS okato2 ON okato2.ter + okato2.kod1 + okato2.kod2 + okato2.kod3 = rpd.OKATO_Place*/
               
--  drop table #t_tmpCases
--  end
  
  
--END

GO
GRANT EXECUTE ON  [dbo].[usp_selectCasesNoPersonalData] TO [AccountsOMS]
GO
GRANT EXECUTE ON  [dbo].[usp_selectCasesNoPersonalData] TO [db_AccountOMS]
GO
