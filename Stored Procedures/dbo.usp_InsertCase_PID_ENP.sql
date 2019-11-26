SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE procedure [dbo].[usp_InsertCase_PID_ENP]
				@year char(4)
as
declare @dateStart datetime=@year+'0101',
		@dateEnd datetime=GETDATE()--@year+'1231 23:59:59'

--процедура по заполнению данными для случаев по гражданам которые застразхованных в метсных СМО
--Заполняем PID и ЕНП для подсчета населения по некоторым отчетам
create table #t
(
	GUID_Case uniqueidentifier,
	id bigint
)

insert #t
select distinct c.GUID_Case,c.id
from t_File f inner join t_RegistersAccounts a on
		f.id=a.rf_idFiles
		and f.DateRegistration >=@dateStart
		and f.DateRegistration <=@dateEnd
			inner join (select smocod from vw_sprSMO where smocod!='34') smo on	
		a.rf_idSMO=smo.smocod
			inner join t_RecordCasePatient r on
		a.id=r.rf_idRegistersAccounts
		and a.ReportMonth>0
		and a.ReportMonth<13
			inner join t_Case c on
		r.id=c.rf_idRecordCasePatient
		--	left join t_Case_PID_ENP p on
		--c.id=p.rf_idCase
where NOT EXISTS(SELECT pid FROM t_Case_PID_ENP p WHERE c.id=p.rf_idCase)

if EXISTS(select * from #t)
begin
	insert dbo.t_Case_PID_ENP
	SELECT TOP 1 WITH ties t.id,t.PID,t.UniqueNumberPolicy,[Type],YearReport
	from (
			SELECT t.id,cd.PID,cd.UniqueNumberPolicy,1 as [Type],YEAR(c.DateEnd) AS YearReport
			from #t t inner join RegisterCases.dbo.t_Case c on
								t.GUID_Case=c.GUID_Case
								and c.DateEnd>=@dateStart
								and c.DateEnd<=@dateEnd
									inner join RegisterCases.dbo.t_RefCasePatientDefine rf on
								c.id=rf.rf_idCase
									inner join RegisterCases.dbo.t_CaseDefine cd on 
								rf.id=cd.rf_idRefCaseIteration
			where cd.PID IS NOT NULL			
			union all
			SELECT t.id,null,cf.UniqueNumberPolicy,2 as [Type],YEAR(c.DateEnd) AS YearReport
			from #t t inner join RegisterCases.dbo.t_Case c on
					t.GUID_Case=c.GUID_Case
					and c.DateEnd>=@dateStart
					and c.DateEnd<=@dateEnd
						inner join RegisterCases.dbo.t_RefCasePatientDefine rf on
					c.id=rf.rf_idCase
						inner join RegisterCases.dbo.t_CaseDefineZP1Found cf on 
					rf.id=cf.rf_idRefCaseIteration	
			where cf.UniqueNumberPolicy is not null			
		) t
	ORDER BY ROW_NUMBER() OVER(PARTITION BY t.id ORDER BY t.[Type] )
end

UPDATE e SET e.PID=p.id
FROM dbo.t_Case_PID_ENP e INNER JOIN PolicyRegister.dbo.PEOPLE p ON
				e.ENP=p.ENP
WHERE e.ReportYear=CAST(@year AS SMALLINT) AND e.PID IS NULL

UPDATE e SET e.PID=p.id
FROM dbo.t_Case_PID_ENP e INNER JOIN PolicyRegister.dbo.HISTENP p ON
				e.ENP=p.ENP
WHERE e.ReportYear=CAST(@year AS SMALLINT) AND e.PID IS NULL

drop table #t
GO
GRANT EXECUTE ON  [dbo].[usp_InsertCase_PID_ENP] TO [db_AccountOMS]
GO
