SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[usp_selectResults]
AS 
begin	

				SELECT 

                            v12.[Id],
                            cast(v12.[Id] as nvarchar(10)) + ' — ' + v12.Name
                           
                    FROM   
                            OMS_NSI.dbo.sprV012 AS v12
                    where v12.DateEnd>GETDATE()
                    order by v12.[Id]

   
    END
GO
GRANT EXECUTE ON  [dbo].[usp_selectResults] TO [AccountsOMS]
GRANT EXECUTE ON  [dbo].[usp_selectResults] TO [db_AccountOMS]
GO
