SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE VIEW [dbo].[vw_sprReasonDenialPayment]
as
SELECT  t2.rf_idCase,t2.idAkt,f014.Reason AS CodeReason
FROM AccountOMS.dbo.t_ReasonDenialPayment t2 INNER JOIN OMS_NSI.dbo.sprF014 f014 ON
						t2.CodeReason=f014.ID
GO
