SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE VIEW [dbo].[vw_KSG_KPG260_ONK]
AS
SELECT c.rf_idRecordCasePatient,o.rf_idCase, nc.N_KSG,2020 AS VER_KSG, 0 AS KSG_PG,nc.KOEF_Z ,nc.KOEF_UP ,nc.BZTSZ ,1.00 AS KOEF_D,v.KOEF_U,
	   s.SL_K, c.IT_SL
FROM dbo.t_260order_ONK o INNER JOIN t_Case c ON
			o.rf_idCase=c.id						
					INNER JOIN dbo.t_MES m ON
			c.id=m.rf_idCase
					INNER JOIN dbo.N_KSG_view nc ON
			m.MES=nc.N_KSG                  
					INNER JOIN dbo.t_SLK s ON
			c.id=s.rf_idCase                  
					INNER JOIN dbo.vw_sprT001 l ON
			c.rf_idMO=l.CodeM
					INNER JOIN dbo.V_KOEF_U v ON
			l.mcod=v.LPU
			AND ISNULL(c.rf_idSubMO,'99')=ISNULL(v.LPU_1,'99')                  
			AND ISNULL(c.rf_idDepartmentMO,'99')=ISNULL(v.PODR,'99')
			AND o.USL_OK=v.USL_OK
WHERE c.DateEnd>='20190101' AND o.Date_Z_2 BETWEEN nc.DATEBEG_KOEF_Z AND nc.DATEEND_KOEF_Z AND o.Date_Z_2 BETWEEN nc.DATEBEG_KOEF_UP AND nc.DATEEND_KOEF_UP
		AND o.Date_Z_2 BETWEEN nc.DATEBEG_BZTSZ AND nc.DATEEND_BZTSZ AND o.Date_Z_2 BETWEEN v.DATEBEG_KOEF_U AND v.DATEEND_KOEF_U
		AND o.Date_Z_2 BETWEEN v.DATEBEG_LEVEL AND v.DATEEND_LEVEL AND o.Date_Z_2 BETWEEN v.DATEBEG_KOEF_U AND v.DATEEND_KOEF_U
GO
