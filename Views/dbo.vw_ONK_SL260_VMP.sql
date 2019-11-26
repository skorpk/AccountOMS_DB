SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE VIEW [dbo].[vw_ONK_SL260_VMP]
AS
SELECT s.id,s.rf_idCase, s.DS1_T,s.rf_idN002 AS STAD,s.rf_idN003 AS ONK_T, s.rf_idN004 AS ONK_N, s.rf_idN005 AS ONK_M, s.IsMetastasis AS MTSTZ, s.TotalDose AS SOD
		,s.K_FR,CAST(s.WEI AS DECIMAL(5,1)) AS WEI,s.HEI, s.BSA
FROM dbo.t_260order_VMP o INNER JOIN dbo.t_ONK_SL s	on
			o.rf_idCase=s.rf_idCase
GO
