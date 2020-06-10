SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE proc [dbo].[usp_GetReport96]			
AS
;WITH cteMax
AS 
(
	select MAX(id) AS idMax FROM dbo.t_Report_Templates WHERE NameFile='report96.xlsx'
)
select f.DATA,f.NameFile 
FROM dbo.t_Report_Templates f INNER JOIN cteMax c ON
			f.id=c.idMax
WHERE NameFile='report96.xlsx'
GO
