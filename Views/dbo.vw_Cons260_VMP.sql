SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE VIEW [dbo].[vw_Cons260_VMP]
AS
SELECT o.rf_idCase,PR_CONS,DateCons AS DT_CONS 
FROM dbo.t_260order_VMP o INNER JOIN dbo.t_Consultation c ON
			o.rf_idCase=c.rf_idCase
GO
