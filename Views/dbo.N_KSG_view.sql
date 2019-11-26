SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




CREATE VIEW [dbo].[N_KSG_view]
AS
SELECT A.codeMinZdrav as N_KSG, B.coefficient as KOEF_Z, B.dateBeg as DATEBEG_KOEF_Z, B.dateEnd as DATEEND_KOEF_Z,
       C.coefficient as KOEF_UP, C.dateBeg as DATEBEG_KOEF_UP, C.dateEnd as DATEEND_KOEF_UP,
	   D.price as BZTSZ, D.dateBeg as DATEBEG_BZTSZ, D.dateEnd as DATEEND_BZTSZ
FROM oms_nsi.dbo.tCSGroup A
     inner join oms_nsi.dbo.tCSGResourceConsuming B on A.CSGroupId = B.rf_CSGroupId
	 inner join oms_nsi.dbo.tCSGManagement C on A.CSGroupId = C.rf_CSGroupId
	 inner join oms_nsi.dbo.tCSGBasePrice D on A.rf_MSConditionId = D.rf_MSConditionId
WHERE A.dateBeg >= '20190101' and D.dateBeg >= '20190101'




GO
