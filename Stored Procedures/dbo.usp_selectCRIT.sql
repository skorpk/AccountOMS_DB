SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[usp_selectCRIT]
@p_CaseId bigint,
@p_DateEndCase nvarchar(8)
AS

SELECT ac.[rf_idCase], ac.rf_idAddCretiria+' — '+v24.DKKNAME CRIT 
FROM [AccountOMS].[dbo].[t_AdditionalCriterion] ac
inner JOIN [oms_nsi].[dbo].[sprV024] v24 on ac.[rf_idAddCretiria]=v24.[IDDKK] and @p_DateEndCase between v24.DATEBEG and v24.DATEEND
where [rf_idCase]=@p_CaseId
GO
GRANT EXECUTE ON  [dbo].[usp_selectCRIT] TO [AccountsOMS]
GO
GRANT EXECUTE ON  [dbo].[usp_selectCRIT] TO [db_AccountOMS]
GO
