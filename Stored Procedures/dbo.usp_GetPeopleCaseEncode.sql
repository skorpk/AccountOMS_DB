SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[usp_GetPeopleCaseEncode]
as
--добавить прибавление максимального значения из t_People_Case
SELECT RANK() OVER(ORDER BY t.ID)+31957136 AS ID, rf_idCase,ReportYear
FROM  (
       SELECT ENP AS ID, rf_idCase,ReportYear FROM  dbo.t_Case_PID_ENP WHERE  PID IS NULL AND ENP IS NOT NULL AND ReportYear>2014
		 UNION ALL
		 SELECT ENP,c.id,a.ReportYear
		 FROM dbo.t_File f INNER JOIN dbo.t_RegistersAccounts a ON
				f.id=a.rf_idFiles
							INNER JOIN dbo.t_RecordCasePatient r ON
				a.id=r.rf_idRegistersAccounts
							INNER JOIN dbo.t_PatientSMO p ON
				r.id=p.rf_idRecordCasePatient
							INNER JOIN dbo.t_Case c ON
				r.id=c.rf_idRecordCasePatient
		  WHERE f.DateRegistration>'20170123' AND a.ReportYear>2016 AND c.DateEnd>='20170101' AND ENP IS NOT NULL   
       ) t

GO
