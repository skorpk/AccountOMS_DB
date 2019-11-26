SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE view [dbo].[vw_sprFilial]
as
select FilialId,filialName,filialCode
from OMS_NSI.dbo.tFilial

GO
GRANT SELECT ON  [dbo].[vw_sprFilial] TO [db_AccountOMS]
GO
