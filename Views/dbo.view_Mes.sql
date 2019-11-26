SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE VIEW [dbo].[view_Mes]
AS
SELECT     MES, rf_idCase, TypeMES, Quantity, Tariff
FROM         --AccountOMS.dbo.t_MES
	t_MES
GO
GRANT SELECT ON  [dbo].[view_Mes] TO [db_AccountOMS]
GO
