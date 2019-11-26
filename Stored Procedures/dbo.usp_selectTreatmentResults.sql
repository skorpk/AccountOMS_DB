SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[usp_selectTreatmentResults]
AS 
begin	

SELECT v9.[Id], cast(v9.[Id] as nvarchar(10)) + ' — ' + v9.Name      
FROM OMS_NSI.dbo.[sprV009] AS v9
where v9.DateEnd>GETDATE()
order by v9.[Id]

   
END
GO
GRANT EXECUTE ON  [dbo].[usp_selectTreatmentResults] TO [AccountsOMS]
GRANT EXECUTE ON  [dbo].[usp_selectTreatmentResults] TO [db_AccountOMS]
GO
