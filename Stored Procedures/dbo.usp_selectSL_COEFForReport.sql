SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[usp_selectSL_COEFForReport]

@p_CaseId nvarchar(max),
@p_DateEndCase nvarchar(17) = null
as
--declare @query nvarchar(max)=
--'SELECT [rf_idCase],cast([Code_SL] as nvarchar(4))+ '' — '' +slp.descriptionMinZdrav ID_SL,[Coefficient] VAL_C
--FROM [AccountOMS].[dbo].[t_Coefficient] c
--inner JOIN [oms_nsi].[dbo].[tSLP] slp on slp.[code]=c.[Code_SL] 
--inner JOIN [oms_nsi].[dbo].[tSLPperiods] per on per.rf_SLPId=slp.SLPId and @p_DateEndCase between per.DATEBEG and per.DATEEND
--where [rf_idCase] in ('+@p_CaseId+')'

--print(@query)
--exec(@query)

SELECT [rf_idCase],cast([Code_SL] as nvarchar(4))+ ' — ' +slp.descriptionMinZdrav ID_SL,[Coefficient] VAL_C
FROM [AccountOMS].[dbo].[t_Coefficient] c
inner join dbo.t_Case c1 on c1.id=c.rf_idCase
inner JOIN [oms_nsi].[dbo].[tSLP] slp on slp.[code]=c.[Code_SL] 
inner JOIN [oms_nsi].[dbo].[tSLPperiods] per on per.rf_SLPId=slp.SLPId and isnull(@p_DateEndCase,c1.DateEnd) between per.DATEBEG and per.DATEEND
where [rf_idCase]=@p_CaseId


GO
GRANT EXECUTE ON  [dbo].[usp_selectSL_COEFForReport] TO [AccountsOMS]
GO
GRANT EXECUTE ON  [dbo].[usp_selectSL_COEFForReport] TO [db_AccountOMS]
GO
