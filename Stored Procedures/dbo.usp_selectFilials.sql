SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[usp_selectFilials]
@p_AvailableFilialCode int -- от 0 до 6 — коды филиалов, -1 — все филиалы, -2 — ни одного
AS
BEGIN
SELECT [filialId]
      ,[filialName]
      ,[filialCode]
  FROM [OMS_NSI].[dbo].[tFilial]
  where [filialID] = case when @p_AvailableFilialCode=-2 then null
						when @p_AvailableFilialCode=-1 then [filialID]
						else @p_AvailableFilialCode end
END
GO
GRANT EXECUTE ON  [dbo].[usp_selectFilials] TO [AccountsOMS]
GRANT EXECUTE ON  [dbo].[usp_selectFilials] TO [db_AccountOMS]
GO
