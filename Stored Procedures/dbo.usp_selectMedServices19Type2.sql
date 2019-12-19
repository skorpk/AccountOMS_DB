SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[usp_selectMedServices19Type2]
@rf_idCase bigint
AS

SELECT m.[rf_idCase]
      ,m.[MU]
      ,m.[MU]+' — '+isnull(mu.[Name],'') MUName
      ,cast(m.[Quantity] as int) [Quantity]
      ,[Price]
      ,cast ([DateHelpBegin] as date) as [DateHelpBegin] 
      ,cast ([DateHelpEnd] as date) as [DateHelpEnd] 
      ,m.[rf_idDoctor]
      ,cast(m.[rf_idV002] as varchar(4)) +' — '+ v002.[Name] AS profil
      ,v4.[Name] AS spec
	  ,case when c.rf_idMO<>m.rf_idMO then m.rf_idMO+' — '+mo.NAMES end MO
	  ,case when m.IsNeedUsl=0 then 'Нет' when m.IsNeedUsl=1 then 'Да' when m.IsNeedUsl=2 then 'По показаниям' end IsNeedUsl
	  , c.DateBegin
	  , m.Comments
	  , m.[rf_idDepartmentMO] PODR
	  , m.[MUSurgery] +' — '+ isnull(surg.NameMU,'') MUSurgery
  FROM [dbo].[t_Meduslugi] m
  inner join [dbo].[t_Case] c on m.[rf_idCase]=c.[id]
  inner join [OMS_NSI].[dbo].[sprV002] v002 on v002.id=m.[rf_idV002]
  inner JOIN [dbo].[vw_sprMedicalSpeciality] v4 on m.rf_idV004=v4.id AND m.DateHelpEnd>=v4.DateBeg AND c.DateEnd<v4.DateEnd
  inner JOIN [dbo].[vw_sprT001] mo on m.rf_idMO=mo.CodeM
  LEFT JOIN oms_nsi.dbo.vw_sprMUandCSG mu on mu.[code]=m.[MU]
  --LEFT JOIN [dbo].[vw_sprMU] s on s.[MU]=m.[MU]
  LEFT JOIN [dbo].[vw_sprNomenclMU] surg on surg.[CodeMU]=m.[MUSurgery] AND m.DateHelpEnd>=surg.DateBeg AND c.DateEnd<surg.DateEnd
  where m.[rf_idCase]=@rf_idCase
  order by m.[MU]

GO

GRANT EXECUTE ON  [dbo].[usp_selectMedServices19Type2] TO [AccountsOMS]
GRANT EXECUTE ON  [dbo].[usp_selectMedServices19Type2] TO [db_AccountOMS]
GO
