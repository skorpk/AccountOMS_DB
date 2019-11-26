SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[usp_selectProfiles]
AS
BEGIN
SELECT [Id]
      ,cast([Id] as nvarchar(10)) + ' — ' + [Name]
  FROM [OMS_NSI].[dbo].[sprV002] 
  order by [Id]
END
GO
GRANT EXECUTE ON  [dbo].[usp_selectProfiles] TO [AccountsOMS]
GRANT EXECUTE ON  [dbo].[usp_selectProfiles] TO [db_AccountOMS]
GO
