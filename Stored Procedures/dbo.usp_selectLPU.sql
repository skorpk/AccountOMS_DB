SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[usp_selectLPU]
@p_FilialId int = -1, 
@p_PFA int = -1,
@p_PFS int = -1
AS
BEGIN
SELECT LEFT(a.CodeM, 6) as CodeMO
      ,LEFT(a.CodeM, 6)+' '+a.[NameS]
      ,a.[NameS] as MO
  FROM [oms_NSI].[dbo].[vw_sprT001] a
  where a.[FilialId]=case when (@p_FilialId=-1 or @p_FilialId=0)  then a.[FilialId] else @p_FilialId end
  and a.PFA=case when (@p_PFA=-1) then a.PFA else @p_PFA end
  and a.PFS=case when (@p_PFS=-1) then a.PFS else @p_PFS end
  order by LEFT(a.CodeM, 6)
END
GO
GRANT EXECUTE ON  [dbo].[usp_selectLPU] TO [AccountsOMS]
GRANT EXECUTE ON  [dbo].[usp_selectLPU] TO [db_AccountOMS]
GO
