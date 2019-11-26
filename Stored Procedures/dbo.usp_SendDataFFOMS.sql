SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[usp_SendDataFFOMS]
				@typeV6 TINYINT,
				@letter CHAR(1)
as
--для PID=2441987 идет затроение  
SELECT DISTINCT a.Account,c.idRecordCase,ISNULL(s.SeriaPolis,'')+s.NumberPolis
		,CASE WHEN s.rf_idV005=1 THEN 'М' ELSE 'Ж' END AS [Пол],s.BirthDay,s.CodeM,l.NAMES AS [Наименование МО]
		,s.DateBegin,s.DateEnd, v6.name AS [Условия оказания],s.DS1,m.Diagnosis,v9.name,
		s.MES, csg.name,CAST(s.AmountPayment AS MONEY) AS [Сумма], s.PVT,s.IDPeople as PID, p.Fam+' '+p.Im+' '+ISNULL(p.Ot,'') AS FIo,r.NewBorn,
		DENSE_RANK() OVER (ORDER BY s.IDPeople,s.DS1 ) AS Priz
FROM dbo.t_File f INNER JOIN dbo.t_RegistersAccounts a ON
			f.id=a.rf_idFiles
					INNER JOIN dbo.t_RecordCasePatient r ON
			a.id=r.rf_idRegistersAccounts
					INNER JOIN dbo.t_Case c ON
			r.id=c.rf_idRecordCasePatient
					INNER JOIN dbo.t_SendingDataIntoFFOMS s ON
			c.id=s.rf_idCase  
					INNER JOIN RegisterCases.dbo.vw_sprV006 v6 ON
			s.rf_idV006=v6.id                  
					INNER JOIN dbo.vw_sprMKB10 m ON
			s.DS1=m.DiagnosisCode   
					INNER JOIN RegisterCases.dbo.vw_sprV009 v9 ON
			s.rf_idV009=v9.id 
					INNER JOIN dbo.vw_sprCSG csg ON
		    s.MES=csg.code      
					INNER JOIN dbo.vw_sprT001 l ON
			s.CodeM=l.CodeM   					
					INNER JOIN dbo.t_RegisterPatient p on
			r.id=p.rf_idRecordCase
			AND f.id=p.rf_idFiles	
WHERE s.rf_idV006=@typeV6 AND IsDisableCheck=0 AND a.Letter=@letter
	AND EXISTS(SELECT * FROM dbo.t_SendingDataIntoFFOMS WHERE rf_idV006=s.rf_idV006 and IDPeople=s.IDPeople AND DS1=s.DS1 AND PVT>0)
ORDER BY s.IDPeople, s.DS1, s.DateBegin
GO
GRANT EXECUTE ON  [dbo].[usp_SendDataFFOMS] TO [db_AccountOMS]
GO
