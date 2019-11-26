SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE procedure [dbo].[usp_SecurityService]
			@dateStart datetime,
			@dateEnd datetime,
			@reportYear smallint,
			@reportMonthStart tinyint,
			@reportMonthEnd TINYINT,
			@codeM CHAR(6)
as
select ROW_NUMBER() over(order by l.CodeM,a.DateRegister,a.Account,idRecordCase asc) as id,l.CodeM,l.NameS,a.Account,a.DateRegister, a.ReportYear,a.ReportMonth,
		s.sNameS AS SMO
		,c.idRecordCase,p.Fam,p.Im,p.Ot,
		p.Sex,p.BirthDay,pd.SeriaDocument,pd.NumberDocument,pd.SNILS
		,r.SeriaPolis,r.NumberPolis
		,c.DateBegin, c.DateEnd, mkb.DiagnosisCode, mkb.Diagnosis,
		v6.name AS Usl_Ok,v8.Name AS VidPom,c.NumberHistoryCase,v12.name AS ISHOD,
		v9.name AS RSLT,c.AmountPayment
from t_File f inner join t_RegistersAccounts a on
		f.id=a.rf_idFiles
		and a.ReportYear=@reportYear
		and a.ReportMonth>=@reportMonthStart 
		and a.ReportMonth<=@reportMonthEnd
		and f.DateRegistration>=@dateStart and f.DateRegistration<=@dateEnd
			inner join vw_sprT001 l on
		f.CodeM=l.CodeM
			inner join t_RecordCasePatient r on
		a.id=r.rf_idRegistersAccounts			
			inner join t_Case c on
		r.id=c.rf_idRecordCasePatient
			inner join t_RegisterPatient p on
		r.id=p.rf_idRecordCase
		and p.rf_idFiles=f.id
			inner join vw_Diagnosis d on
		c.id=d.rf_idCase
			inner join oms_nsi.dbo.sprMKB mkb on
		d.DS1=mkb.DiagnosisCode
			INNER JOIN RegisterCases.dbo.vw_sprV006 v6 ON
		c.rf_idV006=v6.id  
			INNER JOIN RegisterCases.dbo.vw_sprV08 v8 ON
		c.rf_idV008=v8.ID 
			INNER JOIN RegisterCases.dbo.vw_sprV012 v12 ON
		c.rf_idV012=v12.id 
			INNER JOIN RegisterCases.dbo.vw_sprV009 v9 ON
		c.rf_idV009=v9.id  
			INNER JOIN dbo.vw_sprSMO s  ON
		a.rf_idSMO=s.smocod    
			left join t_RegisterPatientDocument pd on
		p.id=pd.rf_idRegisterPatient
WHERE f.CodeM=@codeM
GO
GRANT EXECUTE ON  [dbo].[usp_SecurityService] TO [db_AccountOMS]
GO
