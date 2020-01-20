SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[usp_ClearRecordDeletedRak]
AS
DELETE FROM dbo.t_PaymentAcceptedCase2
FROM dbo.t_CompletedCase c INNER JOIN dbo.t_Case cc ON
             c.rf_idRecordCasePatient=cc.rf_idRecordCasePatient
									INNER JOIN dbo.t_DeleteCheckedCase d ON
					c.id=d.rf_idCase
									INNER JOIN  dbo.t_PaymentAcceptedCase2 p on
			cc.id=p.rf_idCase
			AND p.idAkt=d.idAct
WHERE p.DateRegistration>'20191201'

GO
