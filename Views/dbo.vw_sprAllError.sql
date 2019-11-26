SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
create view [dbo].[vw_sprAllError]
as
select Code,DescriptionError from oms_NSI.dbo.sprAllErrors
union all
select id,Description from oms_NSI.dbo.sprF012


GO
GRANT SELECT ON  [dbo].[vw_sprAllError] TO [db_AccountOMS]
GO
