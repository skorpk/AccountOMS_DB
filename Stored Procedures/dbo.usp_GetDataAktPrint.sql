SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[usp_GetDataAktPrint]
				@id INT
AS
DECLARE @tM AS TABLE(idMonth TINYINT, NAME varchar(25))

INSERT @tM( idMonth, NAME )
VALUES  (1,'Январь '),(2,'Февраль '),(3,'Март '),(4,'Апрель '),(5,'Май '),(6,'Июнь '),(7,'Июль '),(8,'Август '),(9,'Сентябрь'),(10,'Октябрь '),(11,'Ноябрь '),(12,'Декабрь')


SELECT '№'+CAST(r.NumberAct AS VARCHAR(18))+' от '+CONVERT(VARCHAR(10),r.DateAct, 104) AS InfoAboutAkt,l.NAMES+'  код:'+r.CodeM AS InfoAboutLPU
		,'по реестру счета №'+a.Account +' от '+CONVERT(VARCHAR(10),a.DateRegister,104)+' за отчетный период '+LOWER(mm.NAME)+' '+CAST(a.ReportYear AS VARCHAR(4)) AS InfoAvboutAccount
		,COUNT(c.id) AS CountCase
		,SUM(c.AmountPayment) AS AmountPayment
		,SUM(CASE WHEN c.DateEnd>'20170103' THEN c.AmountPayment ELSE 0 END) AS AmountDeduction
		,count(CASE WHEN c.DateEnd>'20170103' THEN c.id ELSE NULL END) AS CaseDeduction
		,CAST(r.NumberAct AS VARCHAR(18)) AS NumberAct ,r.DateAct,l.NAMES,a.Account,a.DateRegister, s.sNameS, 'МЭК' AS TypeExamine
		,a.id AS rf_idAccount
		,r.rf_idActFileBySMO
FROM dbo.t_RefActOfSettledAccountBySMO r INNER JOIN dbo.vw_sprT001 l ON
				r.CodeM=l.CodeM
								INNER JOIN dbo.vw_sprSMO s ON
				r.CodeSMO=s.smocod                              
								INNER JOIN dbo.t_RegistersAccounts a ON
				r.rf_idAccounts=a.id 
								INNER JOIN dbo.t_RecordCasePatient rp ON
				a.id=rp.rf_idRegistersAccounts
								INNER JOIN dbo.t_Case c ON
				rp.id=c.rf_idRecordCasePatient    
								INNER JOIN @tm mm ON
				a.ReportMonth=mm.idMonth                         
WHERE rf_idActFileBySMO=@id-- AND NumberAct=@nakt               
GROUP BY '№'+CAST(r.NumberAct AS VARCHAR(18))+' от '+CONVERT(VARCHAR(10),r.DateAct, 104),l.NAMES+'  код:'+r.CodeM ,'по реестру счета №'+a.Account +' от '+CONVERT(VARCHAR(10),a.DateRegister,104)+' за отчетный период '+LOWER(mm.NAME)+' '+CAST(a.ReportYear AS VARCHAR(4))
	,CAST(r.NumberAct AS VARCHAR(18)) ,r.DateAct,l.NAMES,a.Account,a.DateRegister, s.sNameS,a.id,r.rf_idActFileBySMO
UNION ALL
SELECT '№'+CAST(r.NumAct AS VARCHAR(18))+' от '+CONVERT(VARCHAR(10),r.DateAct, 104) AS InfoAboutAkt,l.NAMES+'  код:'+r.CodeM AS InfoAboutLPU
		,'по реестру счета №'+a.Account +' от '+CONVERT(VARCHAR(10),a.DateRegister,104)+' за отчетный период '+LOWER(mm.NAME)+' '+CAST(a.ReportYear AS VARCHAR(4)) AS InfoAvboutAccount
		,COUNT(c.id) AS CountCase
		,SUM(c.AmountPayment) AS AmountPayment
		,SUM(r.Deduction) AS AmountDeduction
		,count(c.id) AS CaseDeduction
		,r.NumAct ,r.DateAct,l.NAMES,a.Account,a.DateRegister, s.sNameS, 'МЭК' AS TypeExamine
		,a.id AS rf_idAccount,rr.rf_idActFileBySMO
FROM dbo.t_RefActOfSettledAccount_EKMP_MEE rr INNER JOIN dbo.vw_sprT001 l ON
				rr.CodeM=l.CodeM
								INNER JOIN dbo.vw_sprSMO s ON
				rr.CodeSMO=s.smocod                              
								INNER JOIN dbo.t_RegistersAccounts a ON
				rr.rf_idAccounts=a.id 
								INNER JOIN dbo.t_RecordCasePatient rp ON
				a.id=rp.rf_idRegistersAccounts
								INNER JOIN dbo.t_Case c ON
				rp.id=c.rf_idRecordCasePatient    
				AND rr.rf_idCase=c.id
								INNER JOIN @tm mm ON
				a.ReportMonth=mm.idMonth 
								INNER JOIN dbo.t_Act_Accounts_MEEAndEKMP r ON
				rr.rf_idAct_Accounts_MEEAndEKMP=r.id
				AND rr.rf_idCase=r.rf_idCase
WHERE rr.rf_idActFileBySMO=@id AND r.TypeEx='МЭК'
GROUP BY '№'+CAST(r.NumAct AS VARCHAR(18))+' от '+CONVERT(VARCHAR(10),r.DateAct, 104),l.NAMES+'  код:'+r.CodeM ,'по реестру счета №'+a.Account +' от '+CONVERT(VARCHAR(10),a.DateRegister,104)+' за отчетный период '+LOWER(mm.NAME)+' '+CAST(a.ReportYear AS VARCHAR(4))
	,r.NumAct ,r.DateAct,l.NAMES,a.Account,a.DateRegister, s.sNameS,a.id,rr.rf_idActFileBySMO


GO
GRANT EXECUTE ON  [dbo].[usp_GetDataAktPrint] TO [db_AccountOMS]
GO
