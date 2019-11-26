SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[usp_selectCONS]
@p_CaseId bigint,
@p_DateEndCase nvarchar(8)
AS

SELECT c.[rf_idCase],c.[DateCons] DT_CONS,cast(c.PR_CONS as nvarchar)+' — '+n19.[CONS_NAME] PR_CONS
FROM [AccountOMS].[dbo].[t_Consultation] c
inner JOIN [oms_nsi].[dbo].[sprn019] n19 on n19.[ID_CONS]=c.PR_CONS and @p_DateEndCase between n19.DATEBEG and n19.DATEEND
where [rf_idCase]=@p_CaseId
GO
GRANT EXECUTE ON  [dbo].[usp_selectCONS] TO [AccountsOMS]
GO
GRANT EXECUTE ON  [dbo].[usp_selectCONS] TO [db_AccountOMS]
GO
