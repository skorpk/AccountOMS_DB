SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


CREATE VIEW [dbo].[vw_ActFilePrint]
AS
--убрать коментарий после переформирования документов
SELECT DISTINCT aa.id,ActFileName,DateCreate,l.CodeM, l.filialCode
FROM dbo.t_ActFileBySMO aa INNER JOIN dbo.vw_sprT001 l ON
			aa.CodeM=l.CodeM
							INNER JOIN dbo.t_RefActOfSettledAccountBySMO r ON
			aa.id=r.rf_idActFileBySMO
							INNER JOIN dbo.t_RegistersAccounts a ON
				r.rf_idAccounts=a.id 
							INNER JOIN dbo.t_RecordCasePatient rp ON
				a.id=rp.rf_idRegistersAccounts
							INNER JOIN dbo.t_Case c ON
				rp.id=c.rf_idRecordCasePatient                              
WHERE c.DateEnd>'20170103'
UNION ALL
SELECT DISTINCT aa.id,ActFileName,DateCreate,l.CodeM, l.filialCode
FROM dbo.t_ActFileBySMO aa INNER JOIN dbo.vw_sprT001 l ON
			aa.CodeM=l.CodeM
							INNER JOIN dbo.t_RefActOfSettledAccount_EKMP_MEE r ON
			aa.id=r.rf_idActFileBySMO
							INNER JOIN dbo.t_Act_Accounts_MEEAndEKMP ae ON
			ae.id=r.rf_idAct_Accounts_MEEAndEKMP                          
							INNER JOIN dbo.t_RegistersAccounts a ON
				r.rf_idAccounts=a.id 
							INNER JOIN dbo.t_RecordCasePatient rp ON
				a.id=rp.rf_idRegistersAccounts
							INNER JOIN dbo.t_Case c ON
				rp.id=c.rf_idRecordCasePatient                              
WHERE ae.TypeEx='МЭК'

GO
GRANT SELECT ON  [dbo].[vw_ActFilePrint] TO [db_AccountOMS]
GO
