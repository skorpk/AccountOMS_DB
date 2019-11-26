SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[usp_selectVNOV_M]
@p_CaseId bigint
AS

SELECT [rf_idCase], [BirthWeight] VNOV_M
FROM [AccountOMS].[dbo].[t_BirthWeight]
where [rf_idCase]=@p_CaseId
GO
GRANT EXECUTE ON  [dbo].[usp_selectVNOV_M] TO [AccountsOMS]
GO
GRANT EXECUTE ON  [dbo].[usp_selectVNOV_M] TO [db_AccountOMS]
GO
