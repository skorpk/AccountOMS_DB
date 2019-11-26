SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
create view [dbo].[vw_sprSMO]
as
select smocod,sNameF,sNameS
from oms_nsi.dbo.tSMO where smocod is not null
union
select '34','ГОСУДАРСТВЕННОЕ УЧРЕЖДЕНИЕ "ТЕРРИТОРИАЛЬНЫЙ ФОНД ОБЯЗАТЕЛЬНОГО МЕДИЦИНСКОГО СТРАХОВАНИЯ ВОЛГОГРАДСКОЙ ОБЛАСТИ"' as sNameF,
		'ТФОМС Волгоградской области' as sNameS
GO
GRANT SELECT ON  [dbo].[vw_sprSMO] TO [db_AccountOMS]
GO
