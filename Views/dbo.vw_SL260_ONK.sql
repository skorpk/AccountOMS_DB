SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


CREATE VIEW [dbo].[vw_SL260_ONK]
AS
SELECT c.rf_idRecordCasePatient,o.rf_idCase,c.GUID_Case AS SL_ID,c.rf_idSubMO AS LPU_1,c.rf_idDepartmentMO AS PODR,c.rf_idV002 AS PROFIL,PROFIL_K,DET,p.rf_idV025 AS P_CEL,
		NHISTORY,TypeTranslation AS P_PER,DATE_1,DATE_2,c.KD,DS1
		,o.C_ZAB,o.DS_ONK, p.DN, CASE WHEN c.rf_idV002=158 THEN 1 ELSE NULL END AS REAB
		,PRVS,VERS_SPEC,ISNULL(IDDOKT,o.lpu+'1') AS IDDOKT,Quantity AS ED_COL, SUM_M AS TARIF, SUM_M --для амбулаторки ставим сумму случая
FROM dbo.t_260order_ONK o INNER JOIN t_Case c ON
			o.rf_idCase=c.id
					LEFT JOIN dbo.t_PurposeOfVisit p ON
			c.id=p.rf_idCase                  
					LEFT JOIN dbo.vw_DS_ONK rd ON
			c.id=rd.rf_idCase                  
WHERE c.DateEnd>='20190101'

GO
