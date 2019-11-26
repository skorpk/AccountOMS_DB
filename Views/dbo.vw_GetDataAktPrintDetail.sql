SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



CREATE VIEW [dbo].[vw_GetDataAktPrintDetail]
as
SELECT a.id AS rf_idAccount,c.idRecordCase AS NumberCase,rp.NumberPolis, d.DiagnosisCode,c.DateBegin,c.DateEnd,'5.1.1.' AS CodeDefect,
	'Нарушения, связанные с оформлением и предъявлением на оплату счетов и реестров счетов: наличие ошибок и/или недостоверной информации в реквизитах счета.' AS NameError
	,SUM(CASE WHEN c.DateEnd>'20170103' THEN c.AmountPayment ELSE 0 END) AS AmountDeduction,r.rf_idActFileBySMO
FROM dbo.t_RefActOfSettledAccountBySMO r INNER JOIN dbo.vw_sprT001 l ON
				r.CodeM=l.CodeM
								INNER JOIN dbo.t_RegistersAccounts a ON
				r.rf_idAccounts=a.id 
								INNER JOIN dbo.t_RecordCasePatient rp ON
				a.id=rp.rf_idRegistersAccounts
								INNER JOIN dbo.t_Case c ON
				rp.id=c.rf_idRecordCasePatient
								INNER JOIN dbo.t_Diagnosis d ON
				c.id=d.rf_idCase
				AND d.TypeDiagnosis=1                             
--WHERE a.id=@id
GROUP BY a.id,c.idRecordCase,rp.NumberPolis, d.DiagnosisCode,c.DateBegin,c.DateEnd,r.rf_idActFileBySMO
UNION ALL
SELECT a.id AS rf_idAccount,c.idRecordCase AS NumberCase,rp.NumberPolis, d.DiagnosisCode,c.DateBegin,c.DateEnd,'5.7.1.' AS CodeDefect,
	'Нарушения, связанные с повторным или необоснованным включением в реестр счетов медицинской помощи: позиция реестра счетов оплачена ранее (повторное выставление счета на оплату случаев оказания медицинской помощи, которые были оплачены ранее).' AS NameError
	,SUM(r.Deduction) AS AmountDeduction,rr.rf_idActFileBySMO
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
								INNER JOIN dbo.t_Diagnosis d ON
				c.id=d.rf_idCase
				AND d.TypeDiagnosis=1                             
WHERE r.TypeEx='МЭК'
GROUP BY a.id,c.idRecordCase,rp.NumberPolis, d.DiagnosisCode,c.DateBegin,c.DateEnd,rr.rf_idActFileBySMO



GO
