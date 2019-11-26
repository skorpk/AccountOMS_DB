SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[usp_selectONK_USL19Type1]
@rf_idCase bigint
AS

SELECT ou.[rf_idCase]
	  ,ou.rf_idN013 N013
	  ,ou.id rf_idONKUSL
      ,cast(ou.rf_idN013 as varchar(10))+' — '+n13.[TLech_NAME] USL_TIP
      ,cast(ou.[TypeSurgery] as varchar(10))+' — '+[THir_NAME] HIR_TIP
      ,cast(ou.[TypeDrug] as varchar(10))+' — '+[TLek_NAME_L] LEK_TIP_L
      ,cast(ou.[TypeCycleOfDrug] as varchar(10))+' — '+[TLek_NAME_V] LEK_TIP_V
      ,cast(ou.[TypeRadiationTherapy] as varchar(10))+' — '+[TLuch_NAME] LUCH_TIP
      ,case when [PPTR]=1 then 'Применена' else 'Нет' end [PPTR]
  FROM [AccountOMS].[dbo].[t_ONK_USL] ou
  inner join [oms_NSI].[dbo].[sprN013] n13 on n13.[ID_TLech]=ou.rf_idN013
  left join [oms_NSI].[dbo].[sprN014] n14 on n14.[ID_THir]=ou.[TypeSurgery]
  left join [oms_NSI].[dbo].[sprN015] n15 on n15.[ID_TLek_L]=ou.[TypeDrug]
  left join [oms_NSI].[dbo].[sprN016] n16 on n16.[ID_TLek_V]=ou.[TypeCycleOfDrug]
  left join [oms_NSI].[dbo].[sprN017] n17 on n17.[ID_TLuch]=ou.[TypeRadiationTherapy]
  where ou.[rf_idCase]=@rf_idCase

GO
GRANT EXECUTE ON  [dbo].[usp_selectONK_USL19Type1] TO [AccountsOMS]
GRANT EXECUTE ON  [dbo].[usp_selectONK_USL19Type1] TO [db_AccountOMS]
GO
