SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[usp_selectPrescriptions19Type2]
@rf_idCase BIGINT
AS

SELECT [rf_idCase]
      ,CASE WHEN [NAZR]=1 THEN 'Направлен на консультацию в МО прикрепления' WHEN [NAZR]=2 THEN 'Направлен на консультацию в иную МО' WHEN [NAZR]=3 THEN 'Направлен на медобследование' WHEN [NAZR]=4 THEN 'Направлен в дневной стационар' WHEN [NAZR]=5 THEN 'Направлен на госпитализацию' WHEN [NAZR]=6 THEN 'Направлен в реабилитационное отделение' END [NAZR]
      ,CAST([rf_idV015] AS NVARCHAR)+' — '+ v21.[SPECNAME] rf_idV015 --специальность
      ,CAST([TypeExamination] AS NVARCHAR) +' — '+ v29.N_MET TypeExamination --метод исследования
      ,CAST([rf_dV002] AS NVARCHAR) +' — '+ v2.[Name] rf_dV002 --профиль МП
      ,CAST([rf_idV020] AS NVARCHAR) +' — '+v20.[name] rf_idV020 --профиль койки
      ,p.[id] --номер по порядку
      ,[DirectionDate] --дата направления
      ,RTRIM([DirectionMU]) [DirectionMU] -- код МУ из номенклатуры
	  ,s.[MUName]
      ,[DirectionMO]+' — '+mo.NameS DirectionMO --МО, в которое направили
  FROM [AccountOMS].[dbo].[t_Prescriptions] p
  INNER JOIN dbo.t_Case c ON c.id = p.[rf_idCase]
  LEFT JOIN [oms_nsi].[dbo].[sprV021] v21 ON RTRIM(p.rf_idV015)=v21.IDSPEC
  LEFT JOIN [oms_nsi].[dbo].[sprV029] v29 ON v29.sprV029Id=p.TypeExamination
  LEFT JOIN [oms_nsi].[dbo].[sprV002] v2 ON v2.Id=p.[rf_dV002]
  LEFT JOIN [oms_nsi].[dbo].[sprV020] v20 ON v20.[sprV020Id]=p.[rf_idV020] AND c.DateEnd BETWEEN v20.DateBeg AND v20.DateEnd
  LEFT JOIN [dbo].[vw_sprT001] mo ON mo.CodeM=p.[DirectionMO]
  LEFT JOIN [dbo].[vw_sprMU] s ON s.[MU]=p.[DirectionMU]
  WHERE p.[rf_idCase]=@rf_idCase
  ORDER BY [DirectionDate]

GO

GRANT EXECUTE ON  [dbo].[usp_selectPrescriptions19Type2] TO [AccountsOMS]
GRANT EXECUTE ON  [dbo].[usp_selectPrescriptions19Type2] TO [db_AccountOMS]
GO
