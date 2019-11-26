SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
create view [dbo].[vw_V001]
as
select * from oms_NSI.dbo.V001
GO
GRANT SELECT ON  [dbo].[vw_V001] TO [db_AccountOMS]
GO
