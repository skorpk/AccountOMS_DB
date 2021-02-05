CREATE TABLE [dbo].[t_MES]
(
[MES] [varchar] (20) COLLATE Cyrillic_General_CI_AS NULL,
[rf_idCase] [bigint] NOT NULL,
[TypeMES] [tinyint] NOT NULL,
[Quantity] [decimal] (5, 2) NULL,
[Tariff] [decimal] (15, 2) NULL
) ON [AccountOMSCase]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE TRIGGER [dbo].[InsertCompletedCaseIntoMU]
ON [dbo].[t_MES]
FOR INSERT
AS
--добавляем данные в t_Meduslugi по законченным случаям для стационара и стациоанарозамещающей помощи.
--расчет кол-ва услуг для стационара ведется как [дата окончания слуая]-[дата начала случая]
--расчет кол-ва услуг для стационарозамещающей ведется как [дата окончания слуая]-[дата начала случая]+1


	INSERT t_Meduslugi(rf_idCase,id,GUID_MU,rf_idMO,rf_idSubMO,rf_idDepartmentMO,rf_idV002,IsChildTariff,DateHelpBegin,DateHelpEnd,DiagnosisCode,
						MUGroupCode,MUUnGroupCode,MUCode,Quantity,Price,TotalPrice,rf_idV004,rf_idDoctor)
	SELECT DISTINCT  c.id,c.idRecordCase,NEWID(),c.rf_idMO,c.rf_idSubMO,c.rf_idDepartmentMO,c.rf_idV002,c.IsChildTariff,c.DateBegin,c.DateEnd,d.DiagnosisCode,
		   vw_c.MUGroupCodeP,vw_c.MUUnGroupCodeP,vw_c.MUCodeP		   
		   , case when c.rf_idV006=2 then CAST(DATEDIFF(D,DateBegin,DateEnd) AS DECIMAL(6,2))+1 
			else (case when(CAST(DATEDIFF(D,DateBegin,DateEnd) AS DECIMAL(6,2)))=0 then 1 else CAST(DATEDIFF(D,DateBegin,DateEnd) AS DECIMAL(6,2))end) end
		   ,0.00,0.00,c.rf_idV004,c.rf_idDoctor
	FROM t_Case c INNER JOIN (SELECT DISTINCT * FROM inserted) i ON
			c.id=i.rf_idCase
				  INNER JOIN (SELECT rf_idCase,DiagnosisCode FROM t_Diagnosis WHERE TypeDiagnosis=1 GROUP BY rf_idCase,DiagnosisCode) d ON
			c.id=d.rf_idCase
				  INNER JOIN (
								SELECT MU,MUGroupCodeP,MUUnGroupCodeP,MUCodeP,AgeGroupShortName 
								FROM vw_sprMUCompletedCase m LEFT JOIN (SELECT MU AS MUCode FROM vw_sprMUCompletedCase WHERE MUGroupCode=2 AND MUUnGroupCode=78
																		UNION ALL
																		SELECT MU FROM vw_sprMUCompletedCase WHERE MUGroupCode=70
																		UNION ALL
																		SELECT MU FROM vw_sprMUCompletedCase WHERE MUGroupCode=72
																		) m1 ON
											m.MU=m1.MUCode
								WHERE m1.MUCode IS NULL
								GROUP BY MU,MUGroupCodeP,MUUnGroupCodeP,MUCodeP,AgeGroupShortName
							  ) vw_c ON
			i.MES=vw_c.MU	
	WHERE c.DateEnd<'20130401' AND vw_c.AgeGroupShortName=(CASE WHEN c.Age>17 THEN 'в' ELSE 'д' END)
	UNION ALL ----- Новый порядок учета Дневного стационара в качестве ЗС. Количество услуг не считается с 01.04.2013
	SELECT DISTINCT  c.id,c.idRecordCase,NEWID(),c.rf_idMO,c.rf_idSubMO,c.rf_idDepartmentMO,c.rf_idV002,c.IsChildTariff,c.DateBegin,c.DateEnd,d.DiagnosisCode,
		   vw_c.MUGroupCodeP,vw_c.MUUnGroupCodeP,vw_c.MUCodeP		   
		   , case when(CAST(DATEDIFF(D,DateBegin,DateEnd) AS DECIMAL(9,2)))=0 then 1 else CAST(DATEDIFF(D,DateBegin,DateEnd) AS DECIMAL(9,2))end
		   ,0.00,0.00,c.rf_idV004,c.rf_idDoctor
	FROM t_Case c INNER JOIN (SELECT DISTINCT * FROM inserted) i ON
			c.id=i.rf_idCase
				  INNER JOIN (SELECT rf_idCase,DiagnosisCode FROM t_Diagnosis WHERE TypeDiagnosis=1 GROUP BY rf_idCase,DiagnosisCode) d ON
			c.id=d.rf_idCase
				  INNER JOIN (
								SELECT MU,MUGroupCodeP,MUUnGroupCodeP,MUCodeP,AgeGroupShortName 
								FROM vw_sprMUCompletedCase m LEFT JOIN (SELECT MU AS MUCode FROM vw_sprMUCompletedCase WHERE MUGroupCode=2 AND MUUnGroupCode=78
																		UNION ALL
																		SELECT MU FROM vw_sprMUCompletedCase WHERE MUGroupCode=70
																		UNION ALL
																		SELECT MU FROM vw_sprMUCompletedCase WHERE MUGroupCode=72																													) m1 ON
											m.MU=m1.MUCode
								WHERE m1.MUCode IS NULL
								GROUP BY MU,MUGroupCodeP,MUUnGroupCodeP,MUCodeP,AgeGroupShortName
							  ) vw_c ON
			i.MES=vw_c.MU	
	WHERE c.DateEnd>='20130401'  AND c.rf_idV006<>2 AND vw_c.AgeGroupShortName=(CASE WHEN c.Age>17 THEN 'в' ELSE 'д' END)
GO
CREATE NONCLUSTERED INDEX [vkTest20180905] ON [dbo].[t_MES] ([MES]) INCLUDE ([rf_idCase]) ON [AccountOMSCase]
GO
CREATE UNIQUE NONCLUSTERED INDEX [QU_MES_Case] ON [dbo].[t_MES] ([rf_idCase]) WITH (IGNORE_DUP_KEY=ON) ON [AccountOMSCase]
GO
CREATE NONCLUSTERED INDEX [IX_MES_CASE] ON [dbo].[t_MES] ([rf_idCase]) INCLUDE ([MES], [Quantity], [Tariff], [TypeMES]) ON [AccountOMSCase]
GO
ALTER TABLE [dbo].[t_MES] ADD CONSTRAINT [FK_MES_Cases] FOREIGN KEY ([rf_idCase]) REFERENCES [dbo].[t_Case] ([id]) ON DELETE CASCADE
GO
GRANT INSERT ON  [dbo].[t_MES] TO [db_AccountOMS]
GO
GRANT SELECT ON  [dbo].[t_MES] TO [db_AccountOMS]
GO
GRANT SELECT ON  [dbo].[t_MES] TO [PDAOR_Executive]
GO
