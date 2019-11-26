SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE VIEW [dbo].[vw_summaDispanserizacia]
as
SELECT SUM(c.AmountPayment) AS TotalSumByCase
FROM dbo.t_File f INNER JOIN dbo.t_RegistersAccounts a ON
		f.id=a.rf_idFiles
				INNER JOIN (VALUES('D'),('R'),('O'),('F'),('V'),('U'),('I')) v(Letter) ON
		a.Letter=v.Letter
				INNER JOIN dbo.t_RecordCasePatient r ON
		a.id=r.rf_idRegistersAccounts
				INNER JOIN dbo.t_Case c WITH(INDEX(IX_Case_idRecordCasePatient_ID_DateEnd)) ON
		r.id=c.rf_idRecordCasePatient
		--AND c.DateEnd>'20130101'
		--AND c.DateEnd<'20131001'
WHERE f.DateRegistration>'20130101' AND f.DateRegistration<'20131008' AND a.ReportYearMonth>=201301 AND a.ReportYearMonth<201310

/*
--считаю по счетам т.к. опускаться на уровень случая не следует
SELECT SUM(a.AmountPayment) AS TotalSumByCase
FROM dbo.t_File f INNER JOIN dbo.t_RegistersAccounts a ON
		f.id=a.rf_idFiles
				INNER JOIN (VALUES('D'),('R'),('O'),('F'),('V'),('U'),('I')) v(Letter) ON
		a.Letter=v.Letter				
WHERE f.DateRegistration>'20130101' AND f.DateRegistration<'20131008' AND a.ReportYearMonth>=201301 AND a.ReportYearMonth<201310
*/

GO
GRANT SELECT ON  [dbo].[vw_summaDispanserizacia] TO [db_AccountOMS]
GO
