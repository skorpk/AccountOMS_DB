SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE VIEW [dbo].[vw_AmbCaseInAccountWithoutFin]
AS
SELECT f.CodeM,a.NumberRegister,ps.ENP,a.ReportYear, c.id,c.DateBegin,c.DateEnd, r.NewBorn, d.DiagnosisCode AS DS1, c.rf_idV006,c.rf_idV002, c.rf_idV004
FROM dbo.t_File f INNER JOIN dbo.t_RegistersAccounts a ON
			f.id=a.rf_idFiles
					INNER JOIN dbo.t_RecordCasePatient r ON
			a.id=r.rf_idRegistersAccounts		
					INNER JOIN dbo.t_PatientSMO ps ON
			r.id=ps.rf_idRecordCasePatient
					INNER JOIN dbo.t_Case c ON
			r.id=c.rf_idRecordCasePatient
					 INNER JOIN dbo.t_Diagnosis d ON
					c.id=d.rf_idCase
WHERE f.DateRegistration>'20170101' AND c.DateEnd>'20161231' AND f.TypeFile='H' and d.TypeDiagnosis=1 AND c.rf_idV006 =3 AND c.rf_idV002<>34  
		AND NOT	EXISTS(SELECT 1
						FROM dbo.t_PaymentAcceptedCase2	f
						WHERE f.DateRegistration>='20170101' AND f.DateRegistration<=GETDATE() AND f.rf_idCase=c.id)
GO
GRANT SELECT ON  [dbo].[vw_AmbCaseInAccountWithoutFin] TO [db_AccountOMS]
GO
