SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



CREATE VIEW [dbo].[vw_Pacient260_VMP]
AS
SELECT id AS idFile,v.rf_idRecordCasePatient,N_ZAP,ID_PAC,VPOLIS
,CASE WHEN v.rf_idSMO<>'34' THEN '18000' ELSE null end AS ST_OKATO,SPOLIS,NPOLIS
	,CASE WHEN v.rf_idSMO<>'34' THEN v.rf_idSMO ELSE v.CodeSMO34 end AS SMO	
	,NOVOR, MONTH,YEAR 
from dbo.t_260order_VMP v 



GO
