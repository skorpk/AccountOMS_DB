SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
create procedure [dbo].[usp_GetsprT001]
				@CodeM varchar(6)
as 
select COUNT(*)
from oms_nsi.dbo.vw_sprT001
where CodeM=@CodeM
GO
GRANT EXECUTE ON  [dbo].[usp_GetsprT001] TO [db_AccountOMS]
GO
