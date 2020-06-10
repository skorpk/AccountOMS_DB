SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[usp_selectCONS]
@p_CaseId bigint,
@p_DateEndCase nvarchar(17) = null
AS

SELECT c.[rf_idCase],c.[DateCons] DT_CONS,cast(c.PR_CONS as nvarchar)+' — '+n19.[CONS_NAME] PR_CONS
FROM [AccountOMS].[dbo].[t_Consultation] c
inner join dbo.t_Case c1 on c1.id=c.rf_idCase
inner JOIN [oms_nsi].[dbo].[sprn019] n19 on n19.[ID_CONS]=c.PR_CONS and isnull(@p_DateEndCase,c1.DateEnd) between n19.DATEBEG and n19.DATEEND
where [rf_idCase]=@p_CaseId
GO
GRANT EXECUTE ON  [dbo].[usp_selectCONS] TO [AccountsOMS]
GO
GRANT EXECUTE ON  [dbo].[usp_selectCONS] TO [db_AccountOMS]
GO
