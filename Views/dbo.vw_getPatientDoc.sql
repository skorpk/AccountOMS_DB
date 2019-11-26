SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
create view [dbo].[vw_getPatientDoc]
as
select rp.id,ID_Patient,rpd.rf_idDocumentType,rpd.SeriaDocument,rpd.NumberDocument,rpd.OKATO,rpd.SNILS,rpd.OKATO_Place
from AccountOMS.dbo.t_RegisterPatient rp left join AccountOMS.dbo.t_RegisterPatientDocument rpd on
				rp.id=rpd.rf_idRegisterPatient
where rpd.rf_idDocumentType is null
group by rp.id,ID_Patient,rpd.rf_idDocumentType,rpd.SeriaDocument,rpd.NumberDocument,rpd.OKATO,rpd.SNILS,rpd.OKATO_Place
GO
GRANT SELECT ON  [dbo].[vw_getPatientDoc] TO [db_AccountOMS]
GO
