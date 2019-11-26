SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE VIEW [dbo].[vw_sprReisterPatientDoc]
as
SELECT rpd.rf_idRegisterPatient, okato1.namel AS OKATO_Name,NULL AS OKATO_Reg
FROM t_RegisterPatientDocument rpd INNER JOIN OMS_NSI.dbo.vw_Accounts_OKATO okato1 on 
					ISNULL(rpd.OKATO,'0')=okato1.okato
UNION ALL
SELECT rpd.rf_idRegisterPatient,NULL, okato1.namel 
FROM t_RegisterPatientDocument rpd INNER JOIN OMS_NSI.dbo.vw_Accounts_OKATO okato1 on 
					ISNULL(rpd.OKATO_place,'0')=okato1.okato
GO
GRANT SELECT ON  [dbo].[vw_sprReisterPatientDoc] TO [db_AccountOMS]
GO
