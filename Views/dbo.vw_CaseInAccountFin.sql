SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE VIEW dbo.vw_CaseInAccountFin
AS
SELECT f.DateRegistration,f.CodeM,a.NumberRegister,ps.ENP,a.ReportYear,c.id,(c.AmountPayment-pc.AmountDeduction) AS AmountPay
		,c.DateBegin,c.DateEnd, r.NewBorn, d.DiagnosisCode AS DS1, c.rf_idV006
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
					INNER JOIN (
								SELECT f.rf_idCase,SUM(AmountDeduction) AS AmountDeduction
								FROM dbo.t_PaymentAcceptedCase2	f
								WHERE f.DateRegistration>='20170101' AND f.DateRegistration<=GETDATE()
								GROUP BY f.rf_idCase
								)  pc ON
			c.id=pc.rf_idCase                  
WHERE f.DateRegistration>'20170101' AND c.DateEnd>'20161231' and d.TypeDiagnosis=1 AND c.rf_idV006 <3 AND (c.AmountPayment-pc.AmountDeduction)>0
GO
GRANT SELECT ON  [dbo].[vw_CaseInAccountFin] TO [db_AccountOMS]
GO
