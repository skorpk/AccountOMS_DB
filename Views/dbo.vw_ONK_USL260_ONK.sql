SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE VIEW [dbo].[vw_ONK_USL260_ONK]
AS
SELECT  s.id AS rf_idONK_SL,rf_idN013 AS USL_TIP,TypeSurgery AS HIR_TIP,TypeDrug AS LEK_TIP_L,TypeCycleOfDrug AS LEK_TIP_V,TypeRadiationTherapy AS LUCH_TIP,PPTR 
FROM dbo.t_260order_ONK o INNER JOIN dbo.t_ONK_SL s	on
			o.rf_idCase=s.rf_idCase
						inner join dbo.t_ONK_USL u ON
		s.rf_idCase=u.rf_idCase 
GO
