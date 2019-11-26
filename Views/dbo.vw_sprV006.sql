SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE VIEW dbo.vw_sprV006
AS
select id, name,DateBeg,isnull(DateEnd,'22220101') as DateEnd from oms_NSI.dbo.sprV006
GO
GRANT SELECT ON  [dbo].[vw_sprV006] TO [db_AccountOMS]
GO
