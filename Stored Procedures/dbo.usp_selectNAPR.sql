SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[usp_selectNAPR]
@p_CaseId bigint,
@p_DateEndCase nvarchar(17) = null
AS

SELECT d.[rf_idCase],d.[DirectionDate] NAPR_DATE,isnull(d.[DirectionMO],'')+' — '+isnull(isnull(mo1.[NAMES],mo2.[NAMES]),'Без направления') NAPR_MO,v28.[N_VN] NAPR_V,v29.[N_MET] MET_ISSL,d.[DirectionMU]+' — '+isnull(s.RBNAME,'') NAPR_USL   
FROM [AccountOMS].[dbo].[t_DirectionMU] d
inner join AccountOMS.dbo.t_Case c on d.rf_idCase=c.id
LEFT JOIN [oms_nsi].[dbo].[V001] s on s.[IDRB]=d.[DirectionMU] and isnull(@p_DateEndCase,c.DateEnd) between s.DATEBEG and s.DATEEND
LEFT JOIN [oms_nsi].[dbo].[sprV029] v29 on d.[MethodStudy]=v29.[IDMET]
LEFT JOIN [oms_nsi].[dbo].[sprV028] v28 on d.[TypeDirection]=v28.[IDVN]
LEFT JOIN [dbo].[vw_sprT001] mo1 on mo1.[CodeM]=d.[DirectionMO]
LEFT JOIN [dbo].[vw_sprT001] mo2 on mo2.[mcod]=d.[DirectionMO]
where [rf_idCase]=@p_CaseId
GO
GRANT EXECUTE ON  [dbo].[usp_selectNAPR] TO [AccountsOMS]
GO
GRANT EXECUTE ON  [dbo].[usp_selectNAPR] TO [db_AccountOMS]
GO
