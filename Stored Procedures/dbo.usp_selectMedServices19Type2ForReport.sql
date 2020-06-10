SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[usp_selectMedServices19Type2ForReport]
@p_CaseId nvarchar(max)
AS

SELECT * INTO #rf_idCases FROM fn_iter_intlist_to_table(@p_CaseId) 

SELECT m.[rf_idCase]
      ,m.[MU]
      ,s.[MUName]
      ,cast(m.[Quantity] as int) [Quantity]
      ,[Price]
      ,[DateHelpBegin] 
      ,[DateHelpEnd] 
      ,m.[rf_idDoctor]
      ,cast(m.[rf_idV002] as varchar(4)) +' — '+ v002.[Name] AS profil
      ,v4.[Name] AS spec
	  ,case when c.rf_idMO<>m.rf_idMO then m.rf_idMO+' — '+case when m.rf_idMO='00000' then 'Патологоанатомическое бюро' else isnull(mo.NAMES,'') end end MO
	  ,case when m.IsNeedUsl=0 then 'Нет' when m.IsNeedUsl=1 then 'Да' when m.IsNeedUsl=2 then 'По показаниям' end IsNeedUsl
	  , c.DateBegin
  FROM [dbo].[t_Meduslugi] m
  inner join [dbo].[t_Case] c on m.[rf_idCase]=c.[id]
  inner join [OMS_NSI].[dbo].[sprV002] v002 on v002.id=m.[rf_idV002]
  inner JOIN [dbo].[vw_sprMedicalSpeciality] v4 on m.rf_idV004=v4.id AND c.DateEnd>=v4.DateBeg AND c.DateEnd<v4.DateEnd
  inner JOIN [dbo].[vw_sprT001] mo on m.rf_idMO=mo.CodeM
  inner join #rf_idCases c1 on c1.number=c.id
  LEFT JOIN [dbo].[vw_sprMU] s on s.[MU]=m.[MU]
  order by m.MUGroupCode,m.MUUnGroupCode,m.MUCode


GO

GRANT EXECUTE ON  [dbo].[usp_selectMedServices19Type2ForReport] TO [AccountsOMS]
GRANT EXECUTE ON  [dbo].[usp_selectMedServices19Type2ForReport] TO [db_AccountOMS]
GO
