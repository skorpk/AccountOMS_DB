SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[usp_selectB_PROT]
@p_ONK_SLId bigint,
@p_DateEndCase nvarchar(8)
AS

SELECT [DateContraindications] D_PROT, cast([Code] as nvarchar(3))+' — '+ n1.PrOt_NAME PROT
FROM [dbo].[t_Contraindications] d
inner JOIN [oms_nsi].[dbo].[sprN001] n1 on n1.[ID_PrOt]=d.[Code] and @p_DateEndCase between n1.DATEBEG and n1.DATEEND
where [rf_idONK_SL]=@p_ONK_SLId
GO
GRANT EXECUTE ON  [dbo].[usp_selectB_PROT] TO [AccountsOMS]
GO
GRANT EXECUTE ON  [dbo].[usp_selectB_PROT] TO [db_AccountOMS]
GO
