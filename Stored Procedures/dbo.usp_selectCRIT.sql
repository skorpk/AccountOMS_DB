SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[usp_selectCRIT]
@p_CaseId bigint,
@p_DateEndCase nvarchar(17)=null
AS

SELECT ac.[rf_idCase], ac.rf_idAddCretiria+' — '+v24.DKKNAME CRIT 
FROM [AccountOMS].[dbo].[t_AdditionalCriterion] ac
inner join dbo.t_Case c on c.id=ac.rf_idCase
inner JOIN [oms_nsi].[dbo].[sprV024] v24 on ac.[rf_idAddCretiria]=v24.[IDDKK] and isnull(@p_DateEndCase,c.DateEnd) between v24.DATEBEG and v24.DATEEND
where [rf_idCase]=@p_CaseId
GO
GRANT EXECUTE ON  [dbo].[usp_selectCRIT] TO [AccountsOMS]
GO
GRANT EXECUTE ON  [dbo].[usp_selectCRIT] TO [db_AccountOMS]
GO
