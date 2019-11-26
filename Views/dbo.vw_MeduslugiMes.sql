SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
create view [dbo].[vw_MeduslugiMes]
as
select m.rf_idCase,cast(m.MUCode as varchar(2))+'.'+cast(m.MUUnGroupCode as varchar(2))+'.'+cast(m.MUCode as varchar(3)) as MUCode
		,m.IsChildTariff,m.Quantity,m.Price,m.rf_idV002
from t_Meduslugi m
union all
select mes.rf_idCase,mes.MES as MUCode,c.IsChildTariff,mes.Quantity,mes.Tariff,c.rf_idV002
from t_MES mes inner join t_Case c on
		mes.rf_idCase=c.id
GO
GRANT SELECT ON  [dbo].[vw_MeduslugiMes] TO [db_AccountOMS]
GO
