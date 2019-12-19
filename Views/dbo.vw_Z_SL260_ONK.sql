SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




CREATE VIEW [dbo].[vw_Z_SL260_ONK]
AS
SELECT DISTINCT o.id AS idFile,o.rf_idRecordCasePatient,N_ZAP, IDCASE,USL_OK,VIDPOM,FOR_POM
		,NPR_MO ,dd.DirectionDate AS NPR_DATE
		,l.mcod AS LPU,DATE_Z_1,Date_Z_2,KD_Z,RSLT
		,ISHOD,cc.VB_P, IDSP,o.AmountPayment AS SUMV , o.MONTH, o.YEAR
FROM dbo.t_260order_ONK o INNER JOIN vw_sprT001 l ON
			o.LPU=l.CodeM
							INNER JOIN dbo.t_CompletedCase cc ON
			o.rf_idRecordCasePatient=cc.rf_idRecordCasePatient                          
							LEFT JOIN dbo.t_DirectionDate dd ON
			o.rf_idCase = dd.rf_idCase




GO
