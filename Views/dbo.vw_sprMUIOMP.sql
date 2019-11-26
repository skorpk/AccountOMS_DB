SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE VIEW [dbo].[vw_sprMUIOMP]
AS
SELECT DISTINCT CAST(MUGroupCode AS varchar(2)) + '.' + CAST(MUUnGroupCode AS varchar(2)) + '.' + CAST(MUCode AS varchar(3)) AS MU, 
			MUGroupCode,MUUnGroupCode,MUCode,t.IOMP
FROM         (
				select m3.MUId,m1.MUGroupCode,m2.MUUnGroupCode,m3.MUCode,m3.MUName,m3.IOMP
				from OMS_NSI.dbo.sprMUGroup m1 inner join OMS_NSI.dbo.sprMUUnGroup m2 on
							m1.MUGroupId=m2.rf_MUGroupId 
										inner join OMS_NSI.dbo.sprMU m3 on
							m2.MUUnGroupId=m3.rf_MUUnGroupId	
			)  t

GO
GRANT SELECT ON  [dbo].[vw_sprMUIOMP] TO [db_AccountOMS]
GO
