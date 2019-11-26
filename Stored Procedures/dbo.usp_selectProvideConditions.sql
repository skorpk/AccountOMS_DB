SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[usp_selectProvideConditions]
@p_ConditionCodes nvarchar(50)
AS
BEGIN
SELECT [Code]
      ,[ConditionName]
  FROM [dbo].[t_ProvideConditions]  pc
  JOIN   fn_iter_intlist_to_table(@p_ConditionCodes) i ON pc.Code = i.number
END
GO
GRANT EXECUTE ON  [dbo].[usp_selectProvideConditions] TO [db_AccountOMS]
GO
