SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



CREATE VIEW [dbo].[vw_Z_SL260_VMP]
AS
--SELECT id AS idFile,rf_idRecordCasePatient,N_ZAP, IDCASE,USL_OK,VIDPOM,FOR_POM,NPR_MO, dd.DirectionDate AS NPR_DATE,l.mcod AS LPU,DATE_Z_1,Date_Z_2,KD_Z,RSLT
--		,ISHOD, IDSP,AmountPayment AS SUMV
--from dbo.t_260order_VMP o INNER JOIN vw_sprT001 l ON
--			o.LPU=l.CodeM
--							LEFT JOIN dbo.t_DirectionDate dd ON
--			o.rf_idCase = dd.rf_idCase
WITH cteVMP
AS
(
	SELECT id AS idFile,rf_idRecordCasePatient,N_ZAP, IDCASE,USL_OK,VIDPOM,FOR_POM,NPR_MO, dd.DirectionDate AS NPR_DATE,l.mcod AS LPU,DATE_Z_1,Date_Z_2,KD_Z,RSLT
			,ISHOD, IDSP,AmountPayment AS SUMV,SUM(ISNULL(p.AmountDeduction,0.0)) AS SANK_IT
	from dbo.t_260order_VMP o INNER JOIN vw_sprT001 l ON
				o.LPU=l.CodeM
								LEFT JOIN dbo.t_DirectionDate dd ON
				o.rf_idCase = dd.rf_idCase
								LEFT JOIN dbo.t_PaymentAcceptedCase2 p ON
					o.rf_idCase=p.rf_idCase
	GROUP BY o.id ,o.rf_idRecordCasePatient,N_ZAP, IDCASE,USL_OK,VIDPOM,FOR_POM,NPR_MO, dd.DirectionDate ,l.mcod ,DATE_Z_1,Date_Z_2,KD_Z,RSLT,ISHOD,IDSP,o.AmountPayment
)
SELECT  idFile ,rf_idRecordCasePatient ,N_ZAP ,IDCASE ,USL_OK ,VIDPOM ,FOR_POM 
	,NPR_MO,NPR_DATE ,LPU ,DATE_Z_1 ,Date_Z_2 ,KD_Z ,RSLT ,ISHOD ,IDSP ,SUMV 
	,CASE WHEN SANK_IT=0.0 THEN 1 ELSE 3 END AS OPLATA ,SUMV-SANK_IT AS SUMP,CASE WHEN SANK_IT=0.0 THEN NULL ELSE SANK_IT END AS SANK_IT 
FROM cteVMP
WHERE SUMV>SANK_IT 


GO
