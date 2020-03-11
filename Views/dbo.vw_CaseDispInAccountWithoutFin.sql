SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



CREATE VIEW [dbo].[vw_CaseDispInAccountWithoutFin]
AS
SELECT f.CodeM,a.NumberRegister,ps.ENP,a.ReportYear,v.TypeDisp, c.id
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
WHERE f.DateRegistration>'20200101' AND c.DateEnd>'20191231' 
		AND NOT	EXISTS(SELECT 1
						FROM dbo.t_PaymentAcceptedCase2	f
						WHERE f.DateRegistration>='20200101' AND f.DateRegistration<=GETDATE() AND f.rf_idCase=c.id)

GO
GRANT SELECT ON  [dbo].[vw_CaseDispInAccountWithoutFin] TO [db_AccountOMS]
GO
