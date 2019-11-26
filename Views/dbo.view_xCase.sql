SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE VIEW [dbo].[view_xCase]
AS
SELECT
	   dbo.t_Case.id as rf_idCase,
	   dbo.view_MO.mNameS,
	   dbo.view_MO.mcod,
       dbo.view_MO.tfomsCode,
       RTRIM(dbo.t_RegistersAccounts.PrefixNumberRegister) + '-' + CAST (dbo.t_RegistersAccounts.NumberRegister AS varchar (6)) + '-' + 
			CAST (dbo.t_RegistersAccounts.PropertyNumberRegister AS CHAR (1)) + ISNULL(dbo.t_RegistersAccounts.Letter, '') AS AccNum,
	   dbo.t_RegistersAccounts.id as rf_idAccount,
       dbo.t_RegistersAccounts.DateRegister as DateAcc,
	   dbo.t_RegistersAccounts.ReportMonth,
	   dbo.t_RegistersAccounts.ReportYear,
	   dbo.t_RegistersAccounts.AmountPayment as AmountAcc,
--	   dbo.t_PatientSMO.OKATO,
--       dbo.view_sprRegionTFOMS.nameRegion,
       dbo.t_Case.idRecordCase,
	   dbo.t_Case.Age,
       dbo.t_RegisterPatient.Fam,
       dbo.t_RegisterPatient.Im,
       dbo.t_RegisterPatient.Ot,
       dbo.t_RegisterPatient.BirthDay,
	   dbo.t_RegisterPatient.BirthPlace,
       dbo.t_RegisterPatient.Sex AS V005,
       dbo.view_sprV002.Name AS V002,
       dbo.view_sprV008.Name AS V008,
       dbo.t_Case.IsChildTariff,
       dbo.view_sprV009.Name AS V009,
       dbo.view_sprV010.Name AS V010,
       dbo.t_Case.DateBegin,
       dbo.t_Case.DateEnd,
	   dbo.t_Case.GUID_Case,
	   dbo.view_sprV004.Name AS V004,
	   dbo.view_sprV006.Name AS V006,
       dbo.t_Case.AmountPayment,
	   dbo.t_Case.NumberHistoryCase,
       dbo.view_sprV012.Name AS V012,
       dbo.t_RegisterPatientDocument.rf_idDocumentType,
	   dbo.t_RegisterPatientDocument.SeriaDocument,
	   dbo.t_RegisterPatientDocument.SNILS,
	   dbo.t_RegisterPatientDocument.NumberDocument,
	   dbo.t_RegisterPatientDocument.SeriaDocument + ' '+ dbo.t_RegisterPatientDocument.NumberDocument as docnum,
	   RTRIM(isnull(dbo.t_RecordCasePatient.SeriaPolis, '')) as SerPol,
	   RTRIM(isnull(dbo.t_RecordCasePatient.NumberPolis, '')) as NumPol,
	   RTRIM(isnull(dbo.t_RecordCasePatient.SeriaPolis, '')) + ' ' + RTRIM(isnull(dbo.t_RecordCasePatient.NumberPolis, '')) as NumberPolis,
	   dbo.t_RegisterPatientDocument.OKATO as OKATO_P1,
	   ISNULL(dbo.t_RegisterPatientDocument.OKATO_Place, dbo.t_RegisterPatientDocument.OKATO) as OKATO_P2,
	   view_MES.MES as MUCodes

FROM dbo.t_Case
     INNER JOIN dbo.t_RecordCasePatient ON dbo.t_Case.rf_idRecordCasePatient = dbo.t_RecordCasePatient.id
	 INNER JOIN dbo.t_RegistersAccounts ON dbo.t_RecordCasePatient.rf_idRegistersAccounts = dbo.t_RegistersAccounts.id
	 INNER JOIN dbo.t_RegisterPatient ON dbo.t_RecordCasePatient.id = dbo.t_RegisterPatient.rf_idRecordCase

	 INNER JOIN dbo.t_File ON t_File.id = t_RegistersAccounts.rf_idFiles
	 
	 LEFT JOIN dbo.t_RegisterPatientDocument ON dbo.t_RegisterPatient.id = dbo.t_RegisterPatientDocument.rf_idRegisterPatient
--     INNER JOIN dbo.t_PatientSMO ON dbo.t_RecordCasePatient.id = dbo.t_PatientSMO.rf_idRecordCasePatient     
	 INNER JOIN view_sprMonth ON dbo.t_RegistersAccounts.ReportMonth = view_sprMonth.MonthId
     INNER JOIN dbo.view_MO ON dbo.t_Case.rf_idMO = dbo.view_MO.tfomsCode
--     INNER JOIN dbo.view_sprTFOMS ON dbo.t_PatientSMO.OKATO = dbo.view_sprTFOMS.TF_OKATO
--     INNER JOIN dbo.view_sprRegionTFOMS ON dbo.view_sprTFOMS.TF_KOD = dbo.view_sprRegionTFOMS.TF_KOD
     LEFT JOIN dbo.view_sprV002 ON dbo.t_Case.rf_idV002 = dbo.view_sprV002.Id
	 LEFT JOIN dbo.view_sprV004 ON dbo.view_sprV004.Id = dbo.t_Case.rf_idV004
     LEFT JOIN dbo.view_sprV008 ON dbo.t_Case.rf_idV008 = dbo.view_sprV008.Id
     LEFT JOIN dbo.view_sprV009 ON dbo.t_Case.rf_idV009 = dbo.view_sprV009.Id
     LEFT JOIN dbo.view_sprV010 ON dbo.t_Case.rf_idV010 = dbo.view_sprV010.Id
     LEFT JOIN dbo.view_sprV006 ON dbo.t_Case.rf_idV006 = dbo.view_sprV006.Id
     LEFT JOIN dbo.view_sprV012 ON dbo.t_Case.rf_idV012 = dbo.view_sprV012.Id 
	 LEFT  JOIN view_MES   ON view_MES.rf_idCase = t_Case.id

WHERE
	dbo.t_RegistersAccounts.rf_idSMO <> 34
	AND 
	t_RegistersAccounts.ReportYear IN (2012, 2013)
	AND
	  dbo.t_File.DateRegistration > '2012.31.01'
GO
GRANT SELECT ON  [dbo].[view_xCase] TO [db_AccountOMS]
GO
