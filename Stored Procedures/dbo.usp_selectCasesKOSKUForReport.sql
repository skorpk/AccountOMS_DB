SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[usp_selectCasesKOSKUForReport]
--declare
    @p_CaseId bigint
AS

select pac2.rf_idCase, typec.Name TypeCheckup, pac2.[DocumentNumber] idAkt, pac2.[DocumentDate], pac2.[AmountDeduction], t.[Reason]
from [dbo].[t_PaymentAcceptedCase2] pac2
inner join [oms_nsi].dbo.[sprTypeCheckup] typec on pac2.TypeCheckup=typec.id
left join [dbo].[vw_PaymnetMekMeeEkmp_ReasonOneRow] t on pac2.[rf_idCase]=t.[rf_idCase] and pac2.[idAkt]=t.[idAkt] and pac2.[TypeCheckup]=t.[TypeCheckup]
where pac2.rf_idCase=@p_CaseId

GO
GRANT EXECUTE ON  [dbo].[usp_selectCasesKOSKUForReport] TO [AccountsOMS]
GO
GRANT EXECUTE ON  [dbo].[usp_selectCasesKOSKUForReport] TO [db_AccountOMS]
GO
