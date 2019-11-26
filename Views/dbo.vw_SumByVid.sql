SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE VIEW [dbo].[vw_SumByVid]
AS
SELECT 'Диспансеризация' AS NameVid,rf_idSMO,SUM(Tariff) AS Summa
FROM(
	select rf_idSMO,SUM(Tariff) AS Tariff from tmp_Raschet_9_mes where MES like '70.3.%' GROUP BY rf_idSMO
	UNION all
	select rf_idSMO,SUM(Tariff)  from tmp_Raschet_9_mes where MES like '70.5.%' GROUP BY rf_idSMO
	UNION all
	select rf_idSMO,SUM(Tariff)  from tmp_Raschet_9_mes where MES like '70.6.%' GROUP BY rf_idSMO
	UNION all
	select rf_idSMO,SUM(Tariff)  from tmp_Raschet_9_mes where MES like '72.%' GROUP BY rf_idSMO
	UNION all
	select rf_idSMO,SUM(Price*Quantity) from tmp_Raschet_9_mu where MUGroupCode=2 and MUUnGroupCode in (83,84,85,86,87) GROUP BY rf_idSMO
	 ) t
GROUP BY rf_idSMO
UNION all
SELECT 'Стоматология',rf_idSMO,SUM(Tariff)
FROM(
	select rf_idSMO,SUM(Price*Quantity) as Tariff from tmp_Raschet_9_mu where MUGroupCode=57 GROUP BY rf_idSMO
	) t 
GROUP BY rf_idSMO
UNION ALL
SELECT 'Гемодиализ',rf_idSMO,SUM(Tariff)
FROM(	 
	select rf_idSMO,SUM(Price*Quantity) as Tariff  from tmp_Raschet_9_mu where MUGroupCode=60 and MUUnGroupCode =2 and MUCode=5 GROUP BY rf_idSMO
	) t 
GROUP BY rf_idSMO
UNION ALL
SELECT 'Дерматологическая помощь',rf_idSMO,SUM(Tariff)
FROM(	
select rf_idSMO,SUM(Tariff) AS tariff  from tmp_Raschet_9_mes where MES='2.78.5' GROUP BY rf_idSMO
UNION all
select rf_idSMO,SUM(Price*Quantity) from tmp_Raschet_9_mu where MUGroupCode=2 and MUUnGroupCode =79 and MUCode=6 GROUP BY rf_idSMO
UNION ALL
select rf_idSMO,SUM(Price*Quantity) from tmp_Raschet_9_mu where MUGroupCode=2 and MUUnGroupCode =81 and MUCode=5 GROUP BY rf_idSMO
	) t
GROUP BY rf_idSMO
GO
GRANT SELECT ON  [dbo].[vw_SumByVid] TO [db_AccountOMS]
GO
