SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE VIEW [dbo].[vw_DeleteMU]
as
SELECT 1 AS Col1
/*
delete from tmp_Raschet_9_mes where MES like '70.3.%'
delete from tmp_Raschet_9_mes where MES like '70.5.%'
delete from tmp_Raschet_9_mes where MES like '70.6.%'
delete from tmp_Raschet_9_mes where MES like '72.%'

delete from tmp_Raschet_9_mu where MUGroupCode=2 and MUUnGroupCode in (83,84,85,86,87)
delete from tmp_Raschet_9_mu where MUGroupCode=57
delete from tmp_Raschet_9_mu where MUGroupCode=60 and MUUnGroupCode =2 and MUCode=5

delete from tmp_Raschet_9_mu where MUGroupCode=2 and MUUnGroupCode =78 and MUCode=5
delete from tmp_Raschet_9_mu where MUGroupCode=2 and MUUnGroupCode =79 and MUCode=6
delete from tmp_Raschet_9_mu where MUGroupCode=2 and MUUnGroupCode =81 and MUCode=5
*/

GO
GRANT SELECT ON  [dbo].[vw_DeleteMU] TO [db_AccountOMS]
GO
