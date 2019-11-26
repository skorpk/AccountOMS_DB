SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[usp_fill_t_MU_Type2]
as

truncate table dbo.t_CasesFilters_MU_Type2
truncate table dbo.t_CasesFilters_DS_Type2

/*МУ*/
SELECT m.rf_idCase,case when IsNeedUsl=1 then 1 else 0 end isRejected, case when IsNeedUsl=2 then 1 else 0 end isMedIndications, case when DateBegin>DateHelpBegin then 1 else 0 end isEarlyMU
into #t
FROM [AccountOMS].[dbo].[t_Meduslugi] m
inner join dbo.t_Case c on c.id=m.rf_idCase
where DateEnd>='20190101' and (IsNeedUsl in (1,2) or DateBegin>DateHelpBegin)
--group by m.rf_idCase,case when IsNeedUsl=1 then 1 else 0 end, case when IsNeedUsl=2 then 1 else 0 end, case when DateBegin>DateHelpBegin then 1 else 0 end

/*DS1*/
SELECT d.[rf_idCase]
	  ,case when IsNeedDisp in (1,2) then 1 else 0 end isDObservation
	  ,case when IsNeedDisp = 2 then 1 else 0 end isDTaken
	  into #t1
FROM dbo.[t_Diagnosis] AS d 
inner join dbo.t_Case c on c.id = d.rf_idCase
where DateEnd>='20190101' and IsNeedDisp in (1,2)

/*DS2*/
insert into #t1 (rf_idCase,isDObservation,isDTaken)
SELECT d.[rf_idCase]
	  ,case when IsNeedDisp in (1,2) then 1 else 0 end isDObservation
	  ,case when IsNeedDisp = 2 then 1 else 0 end isDTaken
FROM [dbo].[t_DS2_Info] d
where IsNeedDisp in (1,2) 


insert into dbo.t_CasesFilters_MU_Type2 (rf_idCase,isRejected,isMedIndications,isEarlyMU)
(select rf_idCase, max(isRejected) isRejected, max(isMedIndications) isMedIndications, max(isEarlyMU) isEarlyMU
from #t
group by rf_idCase
)

insert into dbo.t_CasesFilters_DS_Type2 (rf_idCase,isDObservation,isDTaken)
(select rf_idCase,  max(isDObservation) isDObservation, max(isDTaken) isDTaken
from #t1
group by rf_idCase
)



--select * from t_MU_Type2
--where isDObservation+isDTaken>0

--drop table #t
GO
