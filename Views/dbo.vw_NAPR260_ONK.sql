SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


CREATE VIEW [dbo].[vw_NAPR260_ONK]
AS
SELECT c.rf_idRecordCasePatient,o.rf_idCase, dm.DirectionDate AS NAPR_DATE, CASE WHEN l.mcod<>o.CODE_MO THEN l.mcod ELSE NULL end AS NAPR_MO ,dm.TypeDirection AS NAPR_V, dm.MethodStudy AS MET_ISSL,dm.DirectionMU AS NAPR_USL        
from dbo.t_260order_ONK o INNER JOIN t_Case c ON
			o.rf_idCase=c.id
					INNER JOIN dbo.t_DirectionMU dm ON 
			c.id=dm.rf_idCase
					INNER JOIN dbo.vw_sprT001 l ON
			dm.DirectionMO=l.CodeM                  
WHERE c.DateEnd>='20190101'


GO
