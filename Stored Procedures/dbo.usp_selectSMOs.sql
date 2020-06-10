SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[usp_selectSMOs]
@p_selectedTabIdx bigint
AS 

if (@p_selectedTabIdx<3)

SELECT [SMOKOD] ,[SMOKOD] + ' — ' + [NAM_SMOK]
FROM [OMS_NSI].[dbo].[sprSMO] where TF_OKATO=18000
order by [SMOKOD]

else 

SELECT [SMOKOD] ,[SMOKOD] + ' — ' + [NAM_SMOK]
FROM [OMS_NSI].[dbo].[sprSMO] s1
inner join [oms_nsi].[dbo].[sprSMOInOMS] s2 on s1.[UId]=s2.[rf_sprSMOUId]
where TF_OKATO=18000 and s2.[dateEnd]>='20190101'
order by [SMOKOD]

GO
GRANT EXECUTE ON  [dbo].[usp_selectSMOs] TO [AccountsOMS]
GO
GRANT EXECUTE ON  [dbo].[usp_selectSMOs] TO [db_AccountOMS]
GO
