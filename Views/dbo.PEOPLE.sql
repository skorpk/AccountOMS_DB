SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE view [dbo].[PEOPLE]
as		
	select p.rf_idRecordCase,p.id ,p.rf_idFiles
			,case when UPPER(isnull(p.Fam,'НЕТ'))='НЕТ' then pa.Fam else p.Fam end as FAM
			,case when UPPER(isnull(p.Im ,'НЕТ'))='НЕТ' then pa.Im else p.Im end as Im
			,case when UPPER(isnull(p.Fam,'НЕТ'))='НЕТ' then pa.Ot else p.Ot end Ot
			,case when UPPER(ISNULL(p.Fam,'НЕТ'))='НЕТ' then pa.BirthDay else p.BirthDay end as DR
			,ps.ENP, p.rf_idV005 AS W
	from t_File f INNER JOIN t_RegisterPatient p ON
			f.id=p.rf_idFiles  
					INNER JOIN dbo.t_RecordCasePatient r ON
			p.rf_idRecordCase=r.id
					INNER JOIN dbo.t_PatientSMO ps ON
			r.id=ps.rf_idRecordCasePatient                  
				  INNER JOIN t_RegisterPatientAttendant pa on
			p.id=pa.rf_idRegisterPatient	
	WHERE f.DateRegistration>'20180101'
	union all
	select p.rf_idRecordCase,p.id,p.rf_idFiles,p.Fam as FAM,p.Im as Im	,p.Ot as Ot	,p.BirthDay as BirthDay,ps.ENP, p.rf_idV005 AS W
	from t_File f INNER JOIN t_RegisterPatient p ON
			f.id=p.rf_idFiles  	
				  INNER JOIN dbo.t_RecordCasePatient r ON
			p.rf_idRecordCase=r.id
				INNER JOIN dbo.t_PatientSMO ps ON
			r.id=ps.rf_idRecordCasePatient                  			
	WHERE f.DateRegistration>'20180101' AND NOT EXISTS(SELECT * FROM t_RegisterPatientAttendant pa WHERE pa.rf_idRegisterPatient=p.id)												



GO
