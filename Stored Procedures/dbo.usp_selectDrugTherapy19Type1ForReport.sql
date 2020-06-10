SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[usp_selectDrugTherapy19Type1ForReport]
@rf_idCase bigint,
@rf_idN013 bigint,
@rf_idONKUSL bigint
AS


SELECT dt.rf_idCase,dt.DateInjection DATE_INJ,
cast(dt.rf_idV024 as varchar(10)) +' — '+ isnull(v24.[DKKNAME],'') CODE_SH, cast(dt.rf_idV020 as varchar(10)) +' — '+ isnull(n20.MNN,'') REGNUM, cast(dt.rf_idN013 as varchar(10))+' — '+isnull(n13.[TLech_NAME],'') N013,
dt.rf_idN013, dt.rf_idONK_USL
FROM dbo.[t_DrugTherapy] AS dt 
left join [oms_NSI].[dbo].[sprV024] v24 on v24.[IDDKK] = dt.rf_idV024
inner join dbo.t_Case c on c.id = dt.rf_idCase
left join [oms_NSI].[dbo].[sprN020] n20 on n20.[ID_LEKP]=dt.rf_idV020
left join [oms_NSI].[dbo].[sprN013] n13 on n13.[ID_TLech]=dt.rf_idN013
where dt.[rf_idCase]=@rf_idCase and dt.[rf_idN013]=@rf_idN013 and dt.rf_idONK_USL=@rf_idONKUSL
GO
GRANT EXECUTE ON  [dbo].[usp_selectDrugTherapy19Type1ForReport] TO [AccountsOMS]
GO
GRANT EXECUTE ON  [dbo].[usp_selectDrugTherapy19Type1ForReport] TO [db_AccountOMS]
GO
