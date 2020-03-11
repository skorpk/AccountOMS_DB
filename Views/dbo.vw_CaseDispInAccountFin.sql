SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




CREATE VIEW [dbo].[vw_CaseDispInAccountFin]
AS
SELECT f.DateRegistration,f.CodeM,a.NumberRegister,ps.ENP,a.ReportYear,v.TypeDisp, c.id,(c.AmountPayment-pc.AmountDeduction) AS AmountPay
FROM dbo.t_File f INNER JOIN dbo.t_RegistersAccounts a ON
			f.id=a.rf_idFiles
					INNER JOIN dbo.t_RecordCasePatient r ON
			a.id=r.rf_idRegistersAccounts		
					INNER JOIN dbo.t_PatientSMO ps ON
			r.id=ps.rf_idRecordCasePatient
					INNER JOIN dbo.t_Case c ON
			r.id=c.rf_idRecordCasePatient
					 INNER JOIN dbo.t_DispInfo d ON
			c.id=d.rf_idCase
					INNER JOIN (VALUES('ДВ2','ДВ2'),('ДВ1','ДВ'),('ДВ4','ДВ'),('ОПВ','ДВ'),('ДC1','ДC'),('ДУ1','ДC'),('ДУ2','ДC'),('ОН1','ОН'),('ОН2','ОН')) v(id,TypeDisp) ON
            d.TypeDisp=v.id
					INNER JOIN (
								SELECT f.rf_idCase,SUM(AmountDeduction) AS AmountDeduction
								FROM dbo.t_PaymentAcceptedCase2	f
								WHERE f.DateRegistration>='20200101' AND f.DateRegistration<=GETDATE()
								GROUP BY f.rf_idCase
								)  pc ON
			c.id=pc.rf_idCase                  
WHERE f.DateRegistration>'20200101' AND c.DateEnd>'20191231' AND (c.AmountPayment-pc.AmountDeduction)>0


GO
GRANT SELECT ON  [dbo].[vw_CaseDispInAccountFin] TO [db_AccountOMS]
GO
