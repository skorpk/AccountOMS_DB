SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE VIEW [dbo].[vw_MES_OneColumn]
as
SELECT DISTINCT cc.rf_idRecordCasePatient
	,(SELECT m.MES +';'AS 'data()'
		FROM dbo.t_Case c INNER JOIN dbo.t_MES m ON
				c.id=m.rf_idCase
		WHERE c.DateEnd>='20190101' AND c.rf_idV006<3 AND c.rf_idRecordCasePatient=cc.rf_idRecordCasePatient
		for xml path('')
		) AS MES
FROM dbo.t_Case cc 			
WHERE cc.DateEnd>='20190101' AND cc.rf_idV006<3 
GO
