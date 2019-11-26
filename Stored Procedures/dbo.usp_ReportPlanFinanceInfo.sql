SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[usp_ReportPlanFinanceInfo]
		@year SMALLINT,
		@unitCode TINYINT,
		@dateBeginReg DATETIME,
		@dateEndReg DATETIME,
		@dateEndRegRAK DATETIME,
		@quater TINYINT
as
CREATE TABLE #plan1(
					CodeM varchar(6),
					UnitCode int,
					Vm DECIMAL(11,2) NOT NULL DEFAULT(0.0),
					Spred decimal(11,2) NOT NULL DEFAULT(0.0),
					SumPlan DECIMAL(15,2) NOT NULL DEFAULT(0.0),
					SumSpred DECIMAL(15,2) NOT NULL DEFAULT(0.0)
					)
--план заказов расчитывается по новому с 2012-02-24. В качестве отчетного месяца берем данные за квартал 
-------------------------------------------------------------------------------------
declare @monthMax tinyint
		
-------------------------------------------------------------------------------------

declare @t as table
(
		MonthID tinyint
		,QuarterID tinyint
		,partitionQuarterID tinyint
		,QuarterName as (case when QuarterID=1 then 'первый квартал'
								when QuarterID=2 then 'второй квартал' 
								when QuarterID=3 then 'третий квартал' else 'четвертый квартал' end)
)
insert @t values(1,1,1),(2,1,2),(3,1,3),
				(4,2,1),(5,2,2),(6,2,3),
				(7,3,1),(8,3,2),(9,3,3),
				(10,4,1),(11,4,2),(12,4,3)

/*у нас всегда начальный месяц будит 1*/				
select @monthMax=MAX(t1.MonthID)
from @t t inner join @t t1 on
		t.QuarterID=t1.QuarterID
where t.QuarterID=@quater	

;WITH ctePlan
AS(
SELECT      LEFT(mo.tfomsCode,6) AS CodeM, 
            q.QuarterId AS QNum, 
            q.quarterName AS QName, 
            u.unitCode AS UnitCode, 
            u.unitName AS UnitName, 
            ISNULL(SUM(rate),0) AS rate  			
FROM  
(
			SELECT      A.rf_MOId AS rf_MOId, 
						B.rf_QuarterId AS rf_QuarterId, 
						B.rf_PlanUnitId AS rf_PlanUnitId, 
						B.rate AS rate
			FROM  OMS_NSI.dbo.tPlanYear A INNER JOIN OMS_NSI.dbo.tPlan B ON 
							A.PlanYearId = B.rf_PlanYearId 
			WHERE A.[year] = @year 
			UNION ALL 
			SELECT      A.rf_MOId AS rf_MOId, 
						B.rf_QuarterId AS rf_QuarterId, 
						B.rf_PlanUnitId AS rf_PlanUnitId, 
						SUM(C.correctionRate) AS rate
			FROM  OMS_NSI.dbo.tPlanYear A INNER JOIN OMS_NSI.dbo.tPlan B ON 
								A.PlanYearId = B.rf_PlanYearId 
										  INNER JOIN OMS_NSI.dbo.tPlanCorrection C ON 
								B.PlanId = C.rf_PlanId 
			WHERE A.[year] = @year AND c.mec<>1
			GROUP BY A.rf_MOId, B.rf_QuarterId, B.rf_PlanUnitId
													) t INNER JOIN OMS_NSI.dbo.tMO mo ON 
							t.rf_MOId = mo.MOId 
														INNER JOIN OMS_NSI.dbo.tQuarter q ON 
							t.rf_QuarterId = q.QuarterId 
														INNER JOIN OMS_NSI.dbo.tPlanUnit u ON 
							t.rf_PlanUnitId = u.PlanUnitId 
			GROUP BY LEFT(mo.tfomsCode,6),q.QuarterId, q.quarterName, u.unitCode, u.unitName
)
insert #plan1(CodeM,UnitCode,Vm)	
SELECT CodeM,vu.code,SUM(rate) AS Rate
FROM ctePlan c INNER JOIN oms_nsi.dbo.vw_sprFinSecurityUnit vu ON
			c.UnitCode=vu.UnitCode
WHERE QNum<=@quater AND vu.code=@unitCode
GROUP BY CodeM,vu.code
ORDER BY CodeM

--SELECT *
--FROM #plan1 WHERE Vm+Vdm>0 
--ORDER BY CodeM

SELECT c.CodeM,rf_idCase,Quantity,vu.code AS UnitCode,AmountPayment
INTO #tmpCases
FROM AccountOMSReports.dbo.t_CaseFinancePlan c INNER JOIN oms_nsi.dbo.vw_sprFinSecurityUnit vu ON
			c.unitCode=vu.UnitCode 
WHERE c.DateRegistration>=@dateBeginReg AND c.DateRegistration<=@dateEndReg AND c.reportMonth>=1 AND c.reportMonth<=@monthMax AND c.ReportYear=@year AND code=@unitCode

UPDATE c SET c.AmountPayment=c.AmountPayment-p.AmountDeduction
from #tmpCases c INNER JOIN ( SELECT sc.rf_idCase, SUM(sc.AmountDeduction) AS AmountDeduction
							  FROM ExchangeFinancing.dbo.t_AFileIn f INNER JOIN ExchangeFinancing.dbo.t_DocumentOfCheckup p ON 
													f.id = p.rf_idAFile 
																	INNER JOIN ExchangeFinancing.dbo.t_CheckedAccount a ON 
													p.id = a.rf_idDocumentOfCheckup 
																	INNER JOIN ExchangeFinancing.dbo.t_CheckedCase sc ON 
													a.id = sc.rf_idCheckedAccount
																	INNER JOIN #tmpCases cc ON
													sc.rf_idCase=cc.rf_idCase															
								WHERE f.DateRegistration>=@dateBeginReg AND f.DateRegistration<=@dateEndRegRAK
								GROUP BY sc.rf_idCase
							) p ON
			c.rf_idCase=p.rf_idCase   

INSERT #plan1( CodeM ,UnitCode ,Spred ,SumSpred)
SELECT CodeM,UnitCode,SUM(Quantity)  AS Quantity , SUM(CASE WHEN AmountPayment>0 THEN AmountPayment ELSE 0.0 end) AS AmountPayment FROM #tmpCases GROUP BY CodeM,UnitCode 

INSERT #plan1( CodeM ,UnitCode ,SumPlan)
SELECT CodeM,code,SUM(SumPlan) 
FROM oms_nsi.dbo.vw_sprFinanceInfoByQuater WHERE Quater<=@quater AND PlanYear=@year AND code=@unitCode GROUP BY CodeM,code

SELECT l.CodeM+' - '+NAMES AS LPU,SUM(Vm) AS Vm, SUM(Spred) AS spred, SUM(Spred) -SUM(Vm) AS diffPlan
		,CAST(SUM(Spred) AS DECIMAL(15,2))/CASE WHEN SUM(Vm)=0 THEN 1 ELSE CAST(SUM(Vm) AS DECIMAL(15,2)) END AS PercentPlan,
		SUM(SumPlan) AS sumPlan, SUM(SumSpred) AS sumSpred, SUM(SumSpred)-SUM(SumPlan) AS diffSum
		,CAST(SUM(SumSpred) AS DECIMAL(15,2))/CASE WHEN SUM(SumPlan)=0 THEN 1 ELSE CAST(SUM(SumPlan) AS DECIMAL(15,2)) END AS PercentSumPlan
FROM #plan1 p INNER JOIN dbo.vw_sprT001 l ON
		p.CodeM=l.CodeM
GROUP BY l.CodeM, NAMES 
ORDER BY LPU

SELECT DISTINCT code,name FROM oms_nsi.dbo.vw_sprFinSecurityUnit WHERE code=@unitCode
DROP TABLE #plan1
DROP TABLE #tmpCases
GO
