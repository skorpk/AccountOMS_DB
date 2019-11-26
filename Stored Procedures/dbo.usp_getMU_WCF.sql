SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[usp_getMU_WCF]
AS
DECLARE @dateStart DATE='20151101'		
--CREATE TABLE #tPeople(
--					  rf_idCase BIGINT,					 
--					  AmountPayment DECIMAL(11,2) NOT NULL DEFAULT(0), 
--					  CodeM CHAR(6),
--					  rf_idV006 TINYINT,
--					  rf_idV002 SMALLINT,
--					  DateBegin DATE,
--					  DateEnd DATE,
--					  IDPeople int ,
--					  AmountPaymentAccepted decimal(11,2) NOT NULL DEFAULT 0.0,
--					  CodeMes VARCHAR(20) ,
--					  Tariff DECIMAL(15,2)
--					  )


INSERT #tPeople( rf_idCase ,CodeM ,rf_idV006 ,rf_idV002,DateBegin,DateEnd, IDPeople,AmountPayment)
SELECT c.id,c.rf_idMO ,c.rf_idV006 ,c.rf_idV002, c.DateBegin,c.DateEnd,p.IDPeople,c.AmountPayment
FROM dbo.t_Case c WITH(INDEX (IX_DateEnd_WCF_Case)) INNER JOIN dbo.t_People_Case p /*WITH(INDEX(IX_Case_PeopleID))*/ ON
			c.id=p.rf_idCase               
WHERE c.DateEnd>=@dateStart AND c.DateEnd<=GETDATE()

CREATE NONCLUSTERED INDEX IX_Amount
ON [dbo].[#tPeople] ([AmountPaymentAccepted])
INCLUDE ([AmountPayment],[CodeM],[rf_idV006],[rf_idV002],[DateBegin],[DateEnd],[IDPeople],[CodeMes],[Tariff])


UPDATE p SET p.CodeMES=m.MES, p.Tariff=m.Tariff
from #tPeople p INNER JOIN t_MES m ON
		p.rf_idCase=m.rf_idCase

--Для случаев не СМП или проф.осмотр
UPDATE p SET p.AmountPaymentAccepted=p.AmountPayment-r.AmountDeduction
FROM #tPeople p INNER JOIN (
							SELECT sc.rf_idCase,SUM(sc.AmountEKMP+ sc.AmountMEE+sc.AmountMEK) AS AmountDeduction
							FROM ExchangeFinancing.dbo.t_AFileIn f INNER JOIN ExchangeFinancing.dbo.t_DocumentOfCheckup p ON 
														f.id = p.rf_idAFile 
																	INNER JOIN ExchangeFinancing.dbo.t_CheckedAccount a ON 
														p.id = a.rf_idDocumentOfCheckup 
																	INNER JOIN ExchangeFinancing.dbo.t_CheckedCase sc ON 
														a.id = sc.rf_idCheckedAccount
							WHERE f.DateRegistration >@dateStart AND f.DateRegistration<=GETDATE()  
							GROUP BY sc.rf_idCase
							) r ON
			p.rf_idCase=r.rf_idCase
WHERE p.rf_idV006<>4 AND CodeMes NOT LIKE '72.1.%'



--Для случаев СМП
UPDATE p SET p.AmountPaymentAccepted=p.AmountPayment-r.AmountDeduction
FROM #tPeople p INNER JOIN (
							SELECT sc.rf_idCase,SUM(sc.AmountEKMP+ sc.AmountMEE+sc.AmountMEK) AS AmountDeduction
							FROM ExchangeFinancing.dbo.t_AFileIn f INNER JOIN ExchangeFinancing.dbo.t_DocumentOfCheckup p ON 
														f.id = p.rf_idAFile 
																	INNER JOIN ExchangeFinancing.dbo.t_CheckedAccount a ON 
														p.id = a.rf_idDocumentOfCheckup 
																	INNER JOIN ExchangeFinancing.dbo.t_CheckedCase sc ON 
														a.id = sc.rf_idCheckedAccount																	
							WHERE f.DateRegistration >@dateStart AND f.DateRegistration<=GETDATE()  
									AND not	EXISTS (SELECT sc1.rf_idCase
											 FROM ExchangeFinancing.dbo.t_AFileIn f INNER JOIN ExchangeFinancing.dbo.t_DocumentOfCheckup p ON 
																		f.id = p.rf_idAFile 
																					INNER JOIN ExchangeFinancing.dbo.t_CheckedAccount a ON 
																		p.id = a.rf_idDocumentOfCheckup 
																					INNER JOIN ExchangeFinancing.dbo.t_CheckedCase sc1 ON 
																		a.id = sc1.rf_idCheckedAccount
																					INNER JOIN ExchangeFinancing.dbo.t_ReasonDenialPayment r ON 
																		sc1.id=r.rf_idCheckedCase
																					INNER JOIN (VALUES (27),(43),(50),(51),(52),(53),(54),(55),(56),(57),
																										(58),(59),(66),(67),(95),(103),(105),(106),(108),
																										(109),(112),(113),(114),(115),(116),(117),(118),
																										(119),(120),(121),(122),(123),(124),(125),(126)) v(CodeReason) ON
																		r.CodeReason=v.CodeReason                                                                                                          
											WHERE sc1.rf_idCase=sc.rf_idCase)
							GROUP BY sc.rf_idCase
							) r ON
			p.rf_idCase=r.rf_idCase
WHERE p.rf_idV006=4

--Для случаев проф.осмотр
UPDATE p SET p.AmountPaymentAccepted=p.AmountPayment-r.AmountDeduction
FROM #tPeople p INNER JOIN (
							SELECT sc.rf_idCase,SUM(sc.AmountEKMP+ sc.AmountMEE+sc.AmountMEK) AS AmountDeduction
							FROM ExchangeFinancing.dbo.t_AFileIn f INNER JOIN ExchangeFinancing.dbo.t_DocumentOfCheckup p ON 
														f.id = p.rf_idAFile 
																	INNER JOIN ExchangeFinancing.dbo.t_CheckedAccount a ON 
														p.id = a.rf_idDocumentOfCheckup 
																	INNER JOIN ExchangeFinancing.dbo.t_CheckedCase sc ON 
														a.id = sc.rf_idCheckedAccount																	
							WHERE f.DateRegistration >@dateStart AND f.DateRegistration<=GETDATE()  
									AND not	EXISTS	(SELECT sc1.rf_idCase
											 FROM ExchangeFinancing.dbo.t_AFileIn f INNER JOIN ExchangeFinancing.dbo.t_DocumentOfCheckup p ON 
																		f.id = p.rf_idAFile 
																					INNER JOIN ExchangeFinancing.dbo.t_CheckedAccount a ON 
																		p.id = a.rf_idDocumentOfCheckup 
																					INNER JOIN ExchangeFinancing.dbo.t_CheckedCase sc1 ON 
																		a.id = sc1.rf_idCheckedAccount
																					INNER JOIN ExchangeFinancing.dbo.t_ReasonDenialPayment r ON 
																		sc1.id=r.rf_idCheckedCase
																					INNER JOIN (VALUES (27),(43),(50),(51),(52),(53),(54),(55),(56),(57),
																										(58),(59),(66),(67),(95),(103),(105),(106),(108),
																										(109),(112),(113),(114),(115),(116),(117),(118),
																										(119),(120),(121),(122),(123),(124),(125),(126)) v(CodeReason) ON
																		r.CodeReason=v.CodeReason                                                                                                          
											WHERE sc1.rf_idCase=sc.rf_idCase)
							GROUP BY sc.rf_idCase
							) r ON
			p.rf_idCase=r.rf_idCase
WHERE p.CodeMes LIKE '72.1.%'

SELECT p.rf_idCase,p.CodeM,p.rf_idV006,AmountPayment, p.DateBegin,DateEnd,p.IDPeople AS PID,p.CodeMES,Tariff,p.rf_idV002	
FROM #tPeople p WHERE AmountPaymentAccepted>0

SELECT p.rf_idCase,m.MUUnGroupCode,m.MUGroupCode,m.MUCode,m.rf_idV002,m.DateHelpBegin,m.DateHelpEnd,m.Quantity,m.Price, m.MUSurgery
FROM #tPeople p INNER JOIN dbo.t_Meduslugi m ON
			p.rf_idCase=m.rf_idCase
				INNER JOIN dbo.vw_sprMUIOMP sm ON
			m.MUUnGroupCode=sm.MUUnGroupCode
			AND m.MUGroupCode=sm.MUGroupCode
			AND m.MUCode=sm.MUCode              
WHERE AmountPaymentAccepted>0 AND m.Comments<>'ОТКАЗ' AND sm.IOMP=1 AND m.DateHelpBegin>=p.DateBegin AND m.DateHelpEnd<=p.DateEnd

DROP TABLE #tPeople
GO
GRANT EXECUTE ON  [dbo].[usp_getMU_WCF] TO [db_AccountOMS]
GO
