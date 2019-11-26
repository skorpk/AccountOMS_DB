SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[usp_InsertDataToPlanDDTables]					
as                    
CREATE TABLE #t(rf_idCase BIGINT)

-------------вставка во временную таблицу-----------------

IF EXISTS(SELECT * FROM dbo.tmp_FileSynchPlanDD)
BEGIN
INSERT PlanDD.dbo.t_File( id ,DateRegistration ,CodeM ,CodeSMO)
SELECT f1.id,f1.DateRegistration,f1.CodeM,a.rf_idSMO
FROM AccountOMS.dbo.tmp_FileSynchPlanDD f INNER JOIN AccountOMS.dbo.t_File f1 ON
			f.rf_idFile=f1.id
					INNER JOIN AccountOMS.dbo.t_RegistersAccounts a ON
					f1.id=a.rf_idFiles

INSERT PlanDD.dbo.t_RegistersAccounts( rf_idFiles ,id ,rf_idMO ,ReportYear ,ReportMonth ,DateRegister ,AmountPayment ,Account)
SELECT a.rf_idFiles,a.id,a.rf_idMO ,a.ReportYear ,a.ReportMonth ,a.DateRegister ,a.AmountPayment ,a.Account
FROM AccountOMS.dbo.tmp_FileSynchPlanDD f INNER JOIN dbo.t_RegistersAccounts a ON
					f.rf_idFile=a.rf_idFiles

INSERT PlanDD.dbo.t_RecordCasePatient( id ,rf_idRegistersAccounts ,idRecord ,ID_Patient ,rf_idF008 ,SeriaPolis ,NumberPolis ,AttachLPU ,ENP)
SELECT r.id ,r.rf_idRegistersAccounts ,r.idRecord ,r.ID_Patient ,r.rf_idF008 ,r.SeriaPolis ,r.NumberPolis ,r.AttachLPU ,s.ENP
FROM AccountOMS.dbo.tmp_FileSynchPlanDD f INNER JOIN AccountOMS.dbo.t_RegistersAccounts a ON
					f.rf_idFile=a.rf_idFiles
								INNER JOIN AccountOMS.dbo.t_RecordCasePatient r ON
					a.id=r.rf_idRegistersAccounts
								INNER JOIN AccountOMS.dbo.t_PatientSMO s ON
					r.id=s.rf_idRecordCasePatient 

INSERT PlanDD.dbo.t_Case( id ,rf_idRecordCasePatient ,idRecordCase ,GUID_Case ,rf_idV006 ,rf_idV008 ,rf_idMO ,rf_idV002 ,IsChildTariff ,NumberHistoryCase ,DateBegin ,DateEnd ,rf_idV009 ,
						rf_idV012 ,AmountPayment ,Comments ,Age ,rf_idDoctor , IsFirstDS ,IsNeedDisp)
OUTPUT INSERTED.id INTO #t(rf_idCase)
SELECT c.id ,c.rf_idRecordCasePatient ,c.idRecordCase ,c.GUID_Case ,c.rf_idV006 ,c.rf_idV008 ,c.rf_idMO ,c.rf_idV002 ,c.IsChildTariff ,c.NumberHistoryCase ,c.DateBegin ,c.DateEnd ,c.rf_idV009 ,
						c.rf_idV012 ,c.AmountPayment ,c.Comments ,c.Age ,c.rf_idDoctor , c.IsFirstDS ,c.IsNeedDisp

FROM AccountOMS.dbo.tmp_FileSynchPlanDD f INNER JOIN AccountOMS.dbo.t_RegistersAccounts a ON
					f.rf_idFile=a.rf_idFiles
								INNER JOIN AccountOMS.dbo.t_RecordCasePatient r ON
					a.id=r.rf_idRegistersAccounts
								INNER JOIN AccountOMS.dbo.t_Case c ON
					r.id=c.rf_idRecordCasePatient  

INSERT PlanDD.dbo.t_DispInfo
        ( rf_idCase ,
          TypeDisp ,
          IsMobileTeam ,
          TypeFailure
        )
SELECT d.rf_idCase ,d.TypeDisp ,d.IsMobileTeam ,d.TypeFailure
FROM #t c INNER JOIN AccountOMS.dbo.t_DispInfo d ON
		c.rf_idCase=d.rf_idCase

INSERT PlanDD.dbo.t_DS2_Info
        ( rf_idCase ,
          DiagnosisCode ,
          IsFirst ,
          IsNeedDisp
        )
SELECT d.rf_idCase ,d.DiagnosisCode ,d.IsFirst ,d.IsNeedDisp
FROM #t c INNER JOIN AccountOMS.dbo.t_DS2_Info d ON
		c.rf_idCase=d.rf_idCase

INSERT PlanDD.dbo.t_Prescriptions
        ( rf_idCase ,
          NAZR ,
          rf_idV015 ,
          TypeExamination ,
          rf_dV002 ,
          rf_idV020
        )
SELECT d.rf_idCase ,NAZR ,rf_idV015 ,TypeExamination ,rf_dV002 ,rf_idV020
FROM #t c INNER JOIN AccountOMS.dbo.t_Prescriptions d ON
		c.rf_idCase=d.rf_idCase	                            

INSERT PlanDD.dbo.t_RegisterPatient( id ,rf_idFiles ,ID_Patient ,Fam ,Im ,Ot ,rf_idV005 ,BirthDay ,rf_idRecordCase ,TEL)
SELECT p.id ,p.rf_idFiles ,p.ID_Patient ,p.Fam ,p.Im ,p.Ot ,p.rf_idV005 ,p.BirthDay,p.rf_idRecordCase ,p.TEL
FROM AccountOMS.dbo.tmp_FileSynchPlanDD f INNER JOIN AccountOMS.dbo.t_RegisterPatient p ON
				f.rf_idFile=p.rf_idFiles
WHERE p.fam IS NOT null

INSERT PlanDD.dbo.t_RegisterPatient( id ,rf_idFiles ,ID_Patient ,Fam ,Im ,Ot ,rf_idV005 ,BirthDay ,rf_idRecordCase ,TEL)
SELECT p.id ,p.rf_idFiles ,p.ID_Patient ,pt.Fam ,pt.Im ,pt.Ot ,pt.rf_idV005 ,pt.BirthDay ,p.rf_idRecordCase ,p.TEL
FROM AccountOMS.dbo.tmp_FileSynchPlanDD f INNER JOIN AccountOMS.dbo.t_RegisterPatient p ON
				f.rf_idFile=p.rf_idFiles
								INNER JOIN AccountOMS.dbo.t_RegisterPatientAttendant pt ON
				p.id=pt.rf_idRegisterPatient                              
WHERE p.fam IS null

END

DROP TABLE #t
GO
