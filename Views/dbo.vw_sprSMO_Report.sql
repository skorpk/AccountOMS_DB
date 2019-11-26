SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

create view [dbo].[vw_sprSMO_Report]
as
select smocod,sNameF,sNameS
		,case when smocod='34001' then 44
			  when smocod='34002' then 45
			  when smocod='34003' then 46
			else 47	end CodeSMO
from oms_nsi.dbo.tSMO where smocod is not null
union
select '34','ГОСУДАРСТВЕННОЕ УЧРЕЖДЕНИЕ "ТЕРРИТОРИАЛЬНЫЙ ФОНД ОБЯЗАТЕЛЬНОГО МЕДИЦИНСКОГО СТРАХОВАНИЯ ВОЛГОГРАДСКОЙ ОБЛАСТИ"' as sNameF,
		'ТФОМС Волгоградской области' as sNameS,34

GO
GRANT SELECT ON  [dbo].[vw_sprSMO_Report] TO [db_AccountOMS]
GO
