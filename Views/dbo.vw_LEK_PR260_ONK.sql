SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


CREATE VIEW [dbo].[vw_LEK_PR260_ONK]
AS		
SELECT  s.id AS rf_idONK_SL,o.rf_idCase ,d.rf_idN013 AS USL_TIP,rf_idV020 AS REGNUM
,CASE WHEN d.rf_idV024='нет' AND c.Age>17 THEN ad.rf_idAddCretiria ELSE d.rf_idV024 END AS CODE_SH
,DateInjection AS DATE_INJ 
FROM dbo.t_260order_ONK o JOIN t_Case c ON
			o.rf_idCase=c.id 
						INNER JOIN dbo.t_ONK_SL s	ON
			o.rf_idCase=s.rf_idCase
						INNER JOIN dbo.t_ONK_USL u ON
			s.rf_idCase=u.rf_idCase						                      
						INNER JOIN  dbo.t_DrugTherapy d ON
			u.rf_idCase=d.rf_idCase
			AND u.rf_idN013 = d.rf_idN013
						LEFT JOIN dbo.t_AdditionalCriterion ad ON
            o.rf_idCase=ad.rf_idCase
GO
