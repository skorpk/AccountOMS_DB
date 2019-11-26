SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[usp_selectUslOk]
AS 
begin	

				SELECT 
                            [Id],
                            Name
                    FROM    OMS_NSI.dbo.sprV006 
                    order by [Id]
   
    END
GO
GRANT EXECUTE ON  [dbo].[usp_selectUslOk] TO [AccountsOMS]
GRANT EXECUTE ON  [dbo].[usp_selectUslOk] TO [db_AccountOMS]
GO
