SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[usp_selectMESForReport]
@p_CaseId nvarchar(100)
AS
BEGIN

SELECT  m.[rf_idCase]
      ,rtrim(m.MES) + ' — '+ /*ISNULL(surg.[RBNAME],*/ISNULL(s.[MUName],csg.[name])/*)*/ as [Медуслуга]
      ,m.[Quantity]
      ,tariff as [Price]
      ,cast([tariff]*[Quantity] as decimal(16, 2)) AS [TotalPrice]
      ,null as [DateHelpBegin]
      ,null as [DateHelpEnd]
      ,'' as [rf_idDoctor]
      ,'' AS profile
      ,'' AS spec
      ,'' as comment
 from [dbo].[t_MES] m
 inner join t_Case c on c.id=m.rf_idCase
 left join [OMS_nsi].[dbo].[tCSGroup] csg on csg.code=m.mes
 LEFT JOIN (SELECT DISTINCT MU,MUName from dbo.vw_sprMUAll) s on s.[MU]=m.[MES]
 --LEFT JOIN [OMS_NSI].[dbo].[V0 01] surg on m.[MES]=surg.[IDRB]
 
 where m.[rf_idCase]=@p_CaseId
 order by m.MES,[DateHelpBegin]
      
END
GO
GRANT EXECUTE ON  [dbo].[usp_selectMESForReport] TO [AccountsOMS]
GRANT EXECUTE ON  [dbo].[usp_selectMESForReport] TO [db_AccountOMS]
GO
