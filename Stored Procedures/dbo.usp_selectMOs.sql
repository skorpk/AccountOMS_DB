SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[usp_selectMOs]
@p_FilialId int = -1, 
@p_selectedTabIndex int = 0, --выбранная вкладка в программе счетов
@p_ReportYear int,
@p_PFA int = -1,
@p_PFS int = -1
AS

if (@p_selectedTabIndex in (4,6)) --счета/случаи второго типа
BEGIN
SELECT distinct LEFT(a.CodeM, 6) as CodeMO
      ,LEFT(a.CodeM, 6)+' '+a.[NameS]
      ,a.[NameS] as MO
  FROM [oms_NSI].[dbo].[vw_sprT001] a
  inner join [oms_NSI].[dbo].[tClinicalExamMO] ce on a.MOId=ce.[rf_MOId] and ce.[year]=@p_ReportYear
  where a.[FilialId]=case when (@p_FilialId=-1 or @p_FilialId=0)  then a.[FilialId] else @p_FilialId end
  and a.PFA=case when (@p_PFA=-1) then a.PFA else @p_PFA end
  and a.PFS=case when (@p_PFS=-1) then a.PFS else @p_PFS end
  order by LEFT(a.CodeM, 6)
END
else
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
GRANT EXECUTE ON  [dbo].[usp_selectMOs] TO [AccountsOMS]
GRANT EXECUTE ON  [dbo].[usp_selectMOs] TO [db_AccountOMS]
GO
