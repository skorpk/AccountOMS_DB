SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



CREATE view [dbo].[vw_getIdFileNumber]
as
select f.id,f.CodeM,f.DateRegistration,f.FileNameHR,a.PrefixNumberRegister,a.NumberRegister,a.PropertyNumberRegister,a.ReportMonth,a.ReportYear,a.Letter,
		a.Account
from t_File f inner join t_RegistersAccounts a on
		f.id=a.rf_idFiles
		


GO
GRANT SELECT ON  [dbo].[vw_getIdFileNumber] TO [db_AccountOMS]
GO
