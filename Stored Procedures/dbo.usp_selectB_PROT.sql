SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[usp_selectB_PROT]
@p_ONK_SLId bigint=null,
@p_DateEndCase nvarchar(17) = null,
@rf_idCase bigint = null
AS

SELECT [DateContraindications] D_PROT, cast([Code] as nvarchar(3))+' — '+ n1.PrOt_NAME PROT
FROM [dbo].[t_Contraindications] d
inner join dbo.t_ONK_SL o on o.[id]=d.[rf_idONK_SL]
inner join dbo.t_Case c on c.id=o.[rf_idCase]
inner JOIN [oms_nsi].[dbo].[sprN001] n1 on n1.[ID_PrOt]=d.[Code] and isnull(@p_DateEndCase,c.DateEnd) between n1.DATEBEG and n1.DATEEND
where [rf_idONK_SL]=@p_ONK_SLId or c.id=@rf_idCase
GO
GRANT EXECUTE ON  [dbo].[usp_selectB_PROT] TO [AccountsOMS]
GO
GRANT EXECUTE ON  [dbo].[usp_selectB_PROT] TO [db_AccountOMS]
GO
