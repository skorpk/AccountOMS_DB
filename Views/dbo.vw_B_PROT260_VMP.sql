SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE VIEW [dbo].[vw_B_PROT260_VMP]
AS
SELECT  rf_idONK_SL ,d.Code AS PROT,DateContraindications AS D_PROT 
FROM dbo.t_260order_VMP o INNER JOIN dbo.t_ONK_SL s	on
			o.rf_idCase=s.rf_idCase
						inner join t_Contraindications d ON
			s.id=d.rf_idONK_SL  
GO
