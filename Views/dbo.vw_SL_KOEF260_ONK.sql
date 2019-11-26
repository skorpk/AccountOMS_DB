SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE VIEW [dbo].[vw_SL_KOEF260_ONK]
AS
SELECT o.rf_idCase,  cc.Code_SL AS IDSL,cc.Coefficient AS Z_SL
from dbo.t_260order_ONK o INNER JOIN dbo.t_Coefficient cc ON
                  o.rf_idCase=cc.rf_idCase  
GO
