SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE VIEW [dbo].[vw_ClinicalExaminationAdults]
as
SELECT DateRegistration,ReportMonth,ReportYear,Comments,Sex, letter,
		SUM(Step1Amount) AS Step1Amount,SUM(Step1Count) AS Step1Count,
		SUM(Step2Amount) AS Step2Amount,SUM(Step2Count) AS Step2Count
FROM (
		SELECT f.DateRegistration,a.ReportMonth,a.ReportYear,c.Comments,p.Sex,c.id,a.Letter,
			   (CASE WHEN s.Step=1 THEN c.AmountPayment ELSE 0 END) AS Step1Amount,
			   (CASE WHEN s.Step=1 THEN 1 ELSE 0 END) AS Step1Count,
			   (CASE WHEN s.Step=2 THEN c.AmountPayment ELSE 0 END) AS Step2Amount,
			   (CASE WHEN s.Step=2 THEN 1 ELSE 0 END) AS Step2Count
		FROM dbo.t_File f INNER JOIN dbo.t_RegistersAccounts a ON
					f.id=a.rf_idFiles
						  inner join dbo.t_RecordCasePatient r on
					a.id=r.rf_idRegistersAccounts
						  inner join t_Case c on
					r.id=c.rf_idRecordCasePatient
					AND c.Age>=18
							INNER JOIN dbo.t_RegisterPatient p ON
					r.id=p.rf_idRecordCase
					AND f.id=p.rf_idFiles
						  INNER JOIN RegisterCases.dbo.vw_IsSpecialCase s ON
					c.IsSpecialCase=s.OS_SLUCH
					AND s.IsClinincalExamination=1
		WHERE f.DateRegistration>'20130601' AND f.DateRegistration<GETDATE() AND a.ReportYear=2013 AND c.DateEnd>'20130101'and Letter='O'
	) t
GROUP BY DateRegistration,ReportMonth,ReportYear,Comments,Sex,Letter

GO
GRANT SELECT ON  [dbo].[vw_ClinicalExaminationAdults] TO [db_AccountOMS]
GO
