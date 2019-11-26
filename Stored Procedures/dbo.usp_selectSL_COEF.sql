SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[usp_selectSL_COEF]
@p_CaseId bigint,
@p_DateEndCase nvarchar(8)
AS

SELECT [rf_idCase],cast([Code_SL] as nvarchar(4))+ ' — ' +slp.descriptionMinZdrav ID_SL,[Coefficient] VAL_C
FROM [AccountOMS].[dbo].[t_Coefficient] c
inner JOIN [oms_nsi].[dbo].[tSLP] slp on slp.[code]=c.[Code_SL] 
inner JOIN [oms_nsi].[dbo].[tSLPperiods] per on per.rf_SLPId=slp.SLPId and @p_DateEndCase between per.DATEBEG and per.DATEEND
where [rf_idCase]=@p_CaseId
GO
GRANT EXECUTE ON  [dbo].[usp_selectSL_COEF] TO [AccountsOMS]
GO
GRANT EXECUTE ON  [dbo].[usp_selectSL_COEF] TO [db_AccountOMS]
GO
