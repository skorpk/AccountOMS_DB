SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE FUNCTION [dbo].[fn_PlanOrders](@codeLPU varchar(6),@month tinyint,@year smallint)
RETURNS @plan TABLE
					(
						CodeLPU varchar(6),
						UnitCode int,
						Vm int,
						Vdm int,
						Spred int,
						[month] tinyint
					)
AS
begin
declare @plan1 TABLE(
						CodeLPU varchar(6),
						UnitCode int,
						Vm int,
						Vdm int,
						Spred int
					)
--план заказов расчитывается по новому с 2011-12-12. В качестве отчетного месяца бере максимальный месяц из реестра сведений с оплатой 1
-- и сравниваем с @month и берем из них максимальное значения для фильтрации.
-------------------------------------------------------------------------------------
declare @monthMax tinyint

select @monthMax=@month
-------------------------------------------------------------------------------------
declare @t as table(MonthID tinyint,QuarterID tinyint,partitionQuarterID tinyint)
insert @t values(1,1,1),(2,1,2),(3,1,3),
				(4,2,1),(5,2,2),(6,2,3),
				(7,3,1),(8,3,2),(9,3,3),
				(10,4,1),(11,4,2),(12,4,3)
--first query:расчет V суммарный объем планов-заказов, соответствующий всем предшествующим календарным кварталам за текущий год
--second query:расчет N*Int(Vt/3) объема плана-заказа делится на 3 и умножается на порядковый номер отчетного месяца в квартале и остаток от деления Vt-Int(Vt/3)
--third query: расчет Vkm сумарного объема всех изменений планов заказов из tPlanCorrection без МЕК
--third query: расчет Vdm сумарного объема всех изменений планов заказов из tPlanCorrection только МЕК
--------------------------------------------------------------------------------------------------------------------------------
declare @tPlan as table(tfomsCode char(6),unitCode tinyint,Vkm bigint,Vdm bigint, Vt bigint,O bigint,V bigint)
insert @tPlan(tfomsCode,unitCode)
select @codeLPU, unitCode
from oms_NSI.dbo.tPlanUnit


update @tPlan
set Vkm=t.Vkm,Vdm=t.Vdm
from @tPlan p inner join (
						select left(mo.tfomsCode,6) as tfomsCode,pu.unitCode,sum(case when pc.mec=0 then ISNULL(pc.correctionRate,0) else 0 end) as Vkm,
								sum(case when pc.mec=1 then ISNULL(pc.correctionRate,0) else 0 end) as Vdm
						from oms_NSI.dbo.tPlanYear py inner join oms_NSI.dbo.tMO mo on
									py.rf_MOId=mo.MOId and
									py.[year]=@year
										inner join oms_NSI.dbo.tPlan pl on
									py.PlanYearId=pl.rf_PlanYearId and 
									pl.flag='A'
										inner join oms_NSI.dbo.tPlanUnit pu on
									pl.rf_PlanUnitId=pu.PlanUnitId
										left join oms_NSI.dbo.tPlanCorrection pc on
									pl.PlanId=pc.rf_PlanId and pc.rf_MonthId<=@monthMax
						where left(mo.tfomsCode,6)=@codeLPU 
						group by mo.tfomsCode,pu.unitCode
						) t on p.tfomsCode=t.tfomsCode and p.unitCode=t.unitCode

update @tPlan
set Vt=t.Vt, O=t.O
from @tPlan p inner join (						
							select left(mo.tfomsCode,6) as tfomsCode,pu.unitCode,(t.partitionQuarterID*(cast(SUM(pl.rate)/3 as int))) as Vt,
									SUM(pl.rate)-3*cast(SUM(pl.rate)/3 as int) as O
							from oms_NSI.dbo.tPlanYear py inner join oms_NSI.dbo.tMO mo on
										py.rf_MOId=mo.MOId and
										py.[year]=@year
											inner join oms_NSI.dbo.tPlan pl on
										py.PlanYearId=pl.rf_PlanYearId and 
										pl.flag='A'
											inner join oms_NSI.dbo.tPlanUnit pu on
										pl.rf_PlanUnitId=pu.PlanUnitId				
											inner join @t t on
										pl.rf_QuarterId=t.QuarterID
							where left(mo.tfomsCode,6)=@codeLPU and t.MonthID=@monthMax
							group by mo.tfomsCode,pu.unitCode,t.partitionQuarterID
						) t on  p.tfomsCode=t.tfomsCode and p.unitCode=t.unitCode


update @tPlan
set V=t.V
from @tPlan p inner join (						
							select left(mo.tfomsCode,6) as tfomsCode,SUM(pl.rate) as V,pu.unitCode
							from oms_NSI.dbo.tPlanYear py inner join oms_NSI.dbo.tMO mo on
										py.rf_MOId=mo.MOId and
										py.[year]=@year
											inner join oms_NSI.dbo.tPlan pl on
										py.PlanYearId=pl.rf_PlanYearId and pl.flag='A'
											inner join oms_NSI.dbo.tPlanUnit pu on
										pl.rf_PlanUnitId=pu.PlanUnitId
											inner join @t t on
										pl.rf_QuarterId<t.QuarterID				
							where left(mo.tfomsCode,6)=@codeLPU and t.MonthID=@monthMax
							group by mo.tfomsCode,pu.unitCode
						) t on  p.tfomsCode=t.tfomsCode and p.unitCode=t.unitCode

insert @plan1(CodeLPU,UnitCode,Vm,Vdm)
select p.tfomsCode,p.unitCode,isnull(p.V,0)+isnull(p.Vt,0)+isnull(p.O,0)+isnull(p.Vkm,0),isnull(p.Vdm,0)
from @tPlan p
 
declare @tS as table(CodeLPU char(6),unitCode tinyint,Rate int)
--берутся все случаи представленные в реестрах СП и ТК с типом оплаты 1 и если данный случай не является иногородним
insert @tS
select c.rf_idMO
		,t1.unitCode
		,SUM(case when m.IsChildTariff=1 then m.Quantity*t1.ChildUET else m.Quantity*t1.AdultUET end) as Quantity
from t_Case c inner join (
							select rf_idCase,GUID_MU,MUCode,MUGroupCode,MUUnGroupCode,Quantity,IsChildTariff
							from t_Meduslugi
							group by rf_idCase,GUID_MU,MUCode,MUGroupCode,MUUnGroupCode,Quantity,IsChildTariff
						 ) m on
				c.id=m.rf_idCase 
				and c.rf_idMO=@codeLPU
						inner join dbo.vw_sprMU t1 on
				m.MUGroupCode=t1.MUGroupCode
				and m.MUUnGroupCode=t1.MUUnGroupCode
				and m.MUCode=t1.MUCode
						inner join t_RecordCasePatient rc on
				c.rf_idRecordCasePatient=rc.id
						inner join t_RegistersAccounts r on
				rc.rf_idRegistersAccounts=r.id and
				r.ReportMonth>0 and r.ReportMonth<=@monthMax and
				r.ReportYear=@year			
						inner join (select * from vw_sprSMO where smocod<>'34') s on
				r.rf_idSMO=s.smocod				
group by c.rf_idMO,t1.unitCode		
			
--insert @tS select CodeLPU,unitCode,RATE from t_PlanOrders2011 where CodeLPU=@codeLPU 
insert @tS
select CodeLPU,unitCode,SUM(Rate)
from RegisterCases.dbo.t_PlanOrders2011 
where CodeLPU=@codeLPU and MonthRate<=@monthMax and YearRate=@year
group by CodeLPU,unitCode
--------------------------------------------------------------------------------------
insert @plan1(CodeLPU,UnitCode,Vm,Vdm,Spred)
select t.CodeLPU,t.unitCode,0,0,t.Rate
from @tS t
	
insert @plan(CodeLPU,UnitCode,Vm,Vdm,Spred,[month])
select CodeLPU,UnitCode,sum(Vm),sum(Vdm),isnull(sum(Spred),0),@monthMax
from @plan1 
group by CodeLPU,UnitCode
		
	RETURN
end;
GO
GRANT SELECT ON  [dbo].[fn_PlanOrders] TO [db_AccountOMS]
GO
