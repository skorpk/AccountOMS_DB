SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
create proc [dbo].[usp_LoadDataToHelthDepartment]
as
--имзеняем только даты с учетом кварталов

CREATE TABLE #t
(
	CodeM varchar(6) NULL,
	id int NOT NULL,
	Fam nvarchar(40) NOT NULL,
	Im nvarchar(40) NOT NULL,
	Ot nvarchar(40) NULL,
	BirthDay date NOT NULL,
	Sex char(1) NOT NULL,
	SeriaPolis varchar(10) NULL,
	NumberPolis varchar(20) NOT NULL,
	DS1 char(10) NULL,
	DS2 char(10) NULL,
	DateBegin date NOT NULL,
	DateEnd date NOT NULL
)
insert #t
select distinct f.CodeM		
		,p.id
		,p.Fam
		,p.Im
		,p.Ot
		,p.BirthDay
		,p.Sex
		,r.SeriaPolis
		,r.NumberPolis
		,d.DS1,d.DS2
		,c.DateBegin
		,c.DateEnd
from t_File f inner join t_RegistersAccounts a on
		f.id=a.rf_idFiles
		and a.ReportMonth>0--тут
		and a.ReportMonth<4--тут
		and a.ReportYear=2012--тут	
				inner join t_RecordCasePatient r on
		a.id=r.rf_idRegistersAccounts
				inner join t_RegisterPatient p on
		r.id=p.rf_idRecordCase
				inner join t_Case c on
		r.id=c.rf_idRecordCasePatient
		and c.DateEnd>'20120101'--тут
		and c.DateEnd<'20120401'--тут
				inner join vw_Diagnosis d on
		c.id=d.rf_idCase
				inner join t_Meduslugi m on
		c.id=m.rf_idCase
		and m.MUGroupCode=2
where f.DateRegistration>='20120101' and f.DateRegistration<'20120401' --и тут

select l.NameS,l.ogrn,Fam,Im,Ot, BirthDay,t.Sex,SeriaPolis,NumberPolis,
		DS1,DS2,t.DateBegin,t.DateEnd,sprD.Name,d.SeriaDocument,d.NumberDocument
		,d.OKATO,d.OKATO_Place,d.SNILS
into tmp_HelthDeartment
from #t t inner join vw_sprT001_Report l on
				t.CodeM=l.CodeM
		left join t_RegisterPatientDocument d on
				t.id=d.rf_idRegisterPatient
		left join oms_nsi.dbo.sprDocumentType sprD on
				d.rf_idDocumentType=sprD.ID			
drop table #t
GO
GRANT EXECUTE ON  [dbo].[usp_LoadDataToHelthDepartment] TO [db_AccountOMS]
GO
