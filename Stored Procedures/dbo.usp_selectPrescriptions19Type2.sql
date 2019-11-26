
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[usp_selectPrescriptions19Type2]
@rf_idCase bigint
AS

SELECT [rf_idCase]
      ,case when [NAZR]=1 then 'Направлен на консультацию в МО прикрепления' when [NAZR]=2 then 'Направлен на консультацию в иную МО' when [NAZR]=3 then 'Направлен на медобследование' when [NAZR]=4 then 'Направлен в дневной стационар' when [NAZR]=5 then 'Направлен на госпитализацию' when [NAZR]=6 then 'Направлен в реабилитационное отделение' end [NAZR]
      ,cast([rf_idV015] as nvarchar)+' — '+ v21.[SPECNAME] rf_idV015 --специальность
      ,cast([TypeExamination] as nvarchar) +' — '+ v29.N_MET TypeExamination --метод исследования
      ,cast([rf_dV002] as nvarchar) +' — '+ v2.[Name] rf_dV002 --профиль МП
      ,cast([rf_idV020] as nvarchar) +' — '+v20.[name] rf_idV020 --профиль койки
      ,p.[id] --номер по порядку
      ,[DirectionDate] --дата направления
      ,rtrim([DirectionMU]) [DirectionMU] -- код МУ из номенклатуры
	  ,s.[MUName]
      ,[DirectionMO]+' — '+mo.NameS DirectionMO --МО, в которое направили
  FROM [AccountOMS].[dbo].[t_Prescriptions] p
  left join [oms_nsi].[dbo].[sprV021] v21 on rtrim(p.rf_idV015)=v21.[SprV021Id]
  left join [oms_nsi].[dbo].[sprV029] v29 on v29.sprV029Id=p.TypeExamination
  left join [oms_nsi].[dbo].[sprV002] v2 on v2.Id=p.[rf_dV002]
  left join [oms_nsi].[dbo].[sprV020] v20 on v20.[sprV020Id]=p.[rf_idV020]
  left join [dbo].[vw_sprT001] mo on mo.CodeM=p.[DirectionMO]
  LEFT JOIN [dbo].[vw_sprMU] s on s.[MU]=p.[DirectionMU]
  where [rf_idCase]=@rf_idCase
  order by [DirectionDate]

GO

GRANT EXECUTE ON  [dbo].[usp_selectPrescriptions19Type2] TO [AccountsOMS]
GRANT EXECUTE ON  [dbo].[usp_selectPrescriptions19Type2] TO [db_AccountOMS]
GO
