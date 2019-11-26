SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE VIEW [dbo].[vw_PriceFalse_71_2]
AS
SELECT D.MUGroupCode,1 AS MUUnGroupCode,B.MUCode,
       CAST(case when A.rf_AgeGroupId=1 then 0 else 1 END  AS TINYINT) as AGE,
       CAST(A.Price AS DECIMAL(15,2)) as PRICE,
       A.dateBeg as DATE_B,
       A.dateEnd as DATE_E
FROM oms_nsi.dbo.sprMUPriceLevel A INNER JOIN oms_nsi.dbo.sprMU B ON A.rf_MUId = B.MUId
								INNER JOIN oms_nsi.dbo.sprMUUnGroup C on C.MUUnGroupId = B.rf_MUUnGroupId
								INNER JOIN oms_nsi.dbo.sprMUGroup D on D.MUGroupId = C.rf_MUGroupId  
WHERE B.ST = 0 and A.flag = 'A' AND MUGroupCode=71 AND MUUnGroupCode=2
GO
