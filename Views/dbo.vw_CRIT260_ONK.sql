SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE VIEW [dbo].[vw_CRIT260_ONK]
AS
SELECT o.rf_idCase,a.rf_idAddCretiria AS CRIT
from dbo.t_260order_ONK o INNER JOIN dbo.t_AdditionalCriterion a ON
			o.rf_idCase=a.rf_idCase          

GO
