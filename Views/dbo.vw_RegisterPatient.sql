SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE view [dbo].[vw_RegisterPatient]
as		
	select p.rf_idRecordCase,p.id,p.rf_idFiles,p.ID_Patient
			,case when UPPER(isnull(p.Fam,'НЕТ'))='НЕТ' then pa.Fam else p.Fam end as FAM
			,case when UPPER(isnull(p.Im ,'НЕТ'))='НЕТ' then pa.Im else p.Im end as Im
			,case when UPPER(isnull(p.Fam,'НЕТ'))='НЕТ' then pa.Ot else p.Ot end Ot
			,p.rf_idV005 as rf_idV005
			,case when UPPER(ISNULL(p.Fam,'НЕТ'))='НЕТ' then pa.BirthDay else p.BirthDay end as BirthDay
			,p.BirthPlace
	from t_RegisterPatient p INNER JOIN t_RegisterPatientAttendant pa on
			p.id=pa.rf_idRegisterPatient	
	union all
	select p.rf_idRecordCase,p.id,p.rf_idFiles,p.ID_Patient,p.Fam as FAM,p.Im as Im	,p.Ot as Ot	,p.rf_idV005 as rf_idV005,p.BirthDay as BirthDay,p.BirthPlace
	from t_RegisterPatient p 
	WHERE NOT EXISTS(SELECT * FROM t_RegisterPatientAttendant pa WHERE pa.rf_idRegisterPatient=p.id)												


GO
