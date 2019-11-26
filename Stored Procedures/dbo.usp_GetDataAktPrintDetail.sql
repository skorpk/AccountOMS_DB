SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[usp_GetDataAktPrintDetail]
				--@id INT				
AS
SELECT a.id AS rf_idAccount,c.idRecordCase AS NumberCase,rp.NumberPolis, d.DiagnosisCode,c.DateBegin,c.DateEnd,'5.1.1.' AS CodeDefect,
	'Нарушения, связанные с оформлением и предъявлением на оплату счетов и реестров счетов: наличие ошибок и/или недостоверной информации в реквизитах счета.' AS NameError
	,SUM(CASE WHEN c.DateEnd>'20170103' THEN c.AmountPayment ELSE 0 END) AS AmountDeduction
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
GROUP BY a.id,c.idRecordCase,rp.NumberPolis, d.DiagnosisCode,c.DateBegin,c.DateEnd
GO
