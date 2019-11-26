SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
create view [dbo].[vw_DoubleCase]
as
select id,c1.GUID_Case
from (
		select GUID_Case
		from t_Case group by GUID_Case	having COUNT(*)>1
		) c0 inner join t_Case c1 on
		c0.GUID_Case=c1.GUID_Case
GO
GRANT SELECT ON  [dbo].[vw_DoubleCase] TO [db_AccountOMS]
GO
