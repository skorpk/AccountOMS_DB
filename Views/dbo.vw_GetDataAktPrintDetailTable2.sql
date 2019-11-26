SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



CREATE VIEW [dbo].[vw_GetDataAktPrintDetailTable2]
AS   

SELECT a.id AS rf_idAccount,r.rf_idActFileBySMO,v2.name AS Profil,COUNT(c.id) AS CountID
	,SUM(c.AmountPayment) AS AmountPayment
	,count(CASE WHEN c.DateEnd>'20170103' THEN c.id ELSE null END) AS CountDeduction
	,SUM(CASE WHEN c.DateEnd>'20170103' THEN c.AmountPayment ELSE 0 END) AS AmountDeduction
FROM dbo.t_RefActOfSettledAccountBySMO r INNER JOIN dbo.vw_sprT001 l ON
				r.CodeM=l.CodeM
								INNER JOIN dbo.t_RegistersAccounts a ON
				r.rf_idAccounts=a.id 
								INNER JOIN dbo.t_RecordCasePatient rp ON
				a.id=rp.rf_idRegistersAccounts
								INNER JOIN dbo.t_Case c ON
				rp.id=c.rf_idRecordCasePatient
								INNER JOIN RegisterCases.dbo.vw_sprV002 v2 ON
				c.rf_idV002=v2.id								                        
GROUP BY a.id,r.rf_idActFileBySMO,v2.name
UNION ALL
SELECT a.id AS rf_idAccount,rr.rf_idActFileBySMO,v2.name AS Profil,COUNT(c.id) AS CountID
	,SUM(c.AmountPayment) AS AmountPayment
	,count(c.id) AS CountDeduction
	,SUM(r.Deduction) AS AmountDeduction
FROM dbo.t_RefActOfSettledAccount_EKMP_MEE rr INNER JOIN dbo.vw_sprT001 l ON
				rr.CodeM=l.CodeM
								INNER JOIN dbo.t_RegistersAccounts a ON
				rr.rf_idAccounts=a.id 
								INNER JOIN dbo.t_RecordCasePatient rp ON
				a.id=rp.rf_idRegistersAccounts
								INNER JOIN dbo.t_Case c ON
				rp.id=c.rf_idRecordCasePatient
				AND rr.rf_idCase=c.id
								INNER JOIN dbo.t_Act_Accounts_MEEAndEKMP r ON
				rr.rf_idAct_Accounts_MEEAndEKMP=r.id
				AND rr.rf_idCase=r.rf_idCase
								INNER JOIN RegisterCases.dbo.vw_sprV002 v2 ON
				c.rf_idV002=v2.id								                        
GROUP BY a.id,rr.rf_idActFileBySMO,v2.name



GO
