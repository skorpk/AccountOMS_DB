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
FROM [OMS_NSI].[dbo].[sprSMO] 
where TF_OKATO=18000 and [D_END]>='20190101'
order by [SMOKOD]
GO
GRANT EXECUTE ON  [dbo].[usp_selectSMOs] TO [db_AccountOMS]
GO
