SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[usp_GetDataForWebService]
AS
DECLARE @dateStart DATE='20151101'		
CREATE TABLE #tPeople(
					  rf_idCase BIGINT,					 
					  AmountPayment DECIMAL(11,2) NOT NULL DEFAULT(0), 
					  CodeM CHAR(6),
					  rf_idV006 TINYINT,
					  rf_idV002 SMALLINT,
					  DateBegin DATE,
					  DateEnd DATE,
					  IDPeople int ,
					  AmountPaymentAccepted decimal(11,2) NOT NULL DEFAULT 0.0,
					  CodeMes VARCHAR(20) ,
					  Tariff DECIMAL(15,2), 
					  MUUnGroupCode tinyint,
					  MUGroupCode tinyint,
					  MUCode smallint,
					  Quantity DECIMAL(6,2),
					  MUSurgery VARCHAR(16)
					  )

INSERT #tPeople( rf_idCase ,CodeM ,rf_idV006 ,rf_idV002,DateBegin,DateEnd, IDPeople,AmountPayment,CodeMES,Tariff)
SELECT c.id,c.rf_idMO ,c.rf_idV006 ,c.rf_idV002, c.DateBegin,c.DateEnd,p.PID,c.AmountPayment,m.MES,m.Tariff
FROM dbo.t_Case c WITH(INDEX (IX_DateEnd_WCF_Case)) INNER JOIN dbo.t_Case_PID_ENP p ON
			c.id=p.rf_idCase               
					INNER JOIN t_mes m ON
			c.id=m.rf_idCase
					INNER JOIN dbo.vw_sprMUIOMP sm ON
			m.MES=sm.MU
WHERE c.DateEnd>=@dateStart AND c.DateEnd<=GETDATE() AND sm.IOMP=1 AND p.PID IS NOT NULL AND 
		NOT EXISTS(SELECT * FROM dbo.t_DataForWCFSynch WHERE rf_idCase=c.id AND PID=p.PID)
PRINT(1)
 --доделать для медуслуг с IOMP=1
INSERT #tPeople( rf_idCase ,CodeM ,rf_idV006 ,rf_idV002 ,DateBegin ,DateEnd ,IDPeople ,AmountPayment,Tariff ,MUUnGroupCode,MUGroupCode,MUCode ,Quantity ,MUSurgery)
SELECT c.id,c.rf_idMO ,c.rf_idV006 ,m.rf_idV002, m.DateHelpBegin,m.DateHelpEnd,p.PID,c.AmountPayment
		,m.Price,m.MUUnGroupCode,m.MUGroupCode,m.MUCode,m.Quantity,m.MUSurgery
FROM dbo.t_Case c WITH(INDEX (IX_DateEnd_WCF_Case)) INNER JOIN dbo.t_Case_PID_ENP p ON
			c.id=p.rf_idCase               
					INNER JOIN dbo.t_Meduslugi m ON
			c.id=m.rf_idCase
					INNER JOIN dbo.vw_sprMUIOMP sm ON
			m.MUUnGroupCode=sm.MUUnGroupCode
			AND m.MUGroupCode=sm.MUGroupCode
			AND m.MUCode=sm.MUCode
WHERE c.DateEnd>=@dateStart AND c.DateEnd<=GETDATE() AND sm.IOMP=1 AND m.DateHelpBegin>=c.DateBegin AND m.DateHelpEnd<=c.DateEnd AND p.PID IS NOT NULL AND
		NOT EXISTS(SELECT * FROM dbo.t_DataForWCFSynch WHERE rf_idCase=c.id AND PID=p.PID)
PRINT(2)
CREATE NONCLUSTERED INDEX IX_Amount
ON [dbo].[#tPeople] ([AmountPaymentAccepted])
INCLUDE ([AmountPayment],[CodeM],[rf_idV006],[rf_idV002],[DateBegin],[DateEnd],[IDPeople],[CodeMes],[Tariff])

--Для случаев не СМП или проф.осмотр
UPDATE p SET p.AmountPaymentAccepted=p.AmountPayment-r.AmountDeduction
FROM #tPeople p INNER JOIN (
							SELECT sc.rf_idCase,SUM(sc.AmountEKMP+ sc.AmountMEE+sc.AmountMEK) AS AmountDeduction
							FROM dbo.t_PaymentAcceptedCase2 sc	INNER JOIN #tPeople p1 ON
														sc.rf_idCase=p1.rf_idCase                                                                  
							WHERE sc.DateRegistration>@dateStart AND sc.DateRegistration<=GETDATE()  
							GROUP BY sc.rf_idCase
							) r ON
			p.rf_idCase=r.rf_idCase
WHERE p.rf_idV006<>4 OR(MUGroupCode<>71 AND MUUnGroupCode<>1)
PRINT(3)
--Для случаев СМП
UPDATE p SET p.AmountPaymentAccepted=p.AmountPayment-r.AmountDeduction
FROM #tPeople p INNER JOIN (
							SELECT sc.rf_idCase,SUM(sc.AmountEKMP+ sc.AmountMEE+sc.AmountMEK) AS AmountDeduction
							FROM dbo.t_PaymentAcceptedCase2 sc															
							WHERE sc.DateRegistration >@dateStart AND sc.DateRegistration<=GETDATE() AND NOT EXISTS (SELECT rf_idCase FROM dbo.t_CodeReasonWCF WHERE rf_idCase=sc.rf_idCase)
							GROUP BY sc.rf_idCase
							) r ON
			p.rf_idCase=r.rf_idCase
WHERE p.rf_idV006=4 OR(MUGroupCode=71 AND MUUnGroupCode=1)
PRINT(4)
--SET STATISTICS TIME OFF

SELECT distinct p.rf_idCase,p.CodeM,p.rf_idV006,AmountPayment, p.DateBegin,DateEnd,p.IDPeople AS PID,p.CodeMES,Tariff,p.rf_idV002	
INTO tmpCases_WCF
FROM #tPeople p 
WHERE AmountPaymentAccepted>0 

ALTER TABLE #tPeople ADD [MU]  AS ((((CONVERT([varchar](2),[MUGroupCode],0)+'.')+CONVERT([varchar](2),[MUUnGroupCode],0))+'.')+CONVERT([varchar](3),[MUCode],0))

SELECT DISTINCT *
INTO tmpMU_WCF
FROM (
		SELECT rf_idCase,MUUnGroupCode,MUGroupCode,MUCode,rf_idV002,DateBegin,DateEnd,Quantity,Tariff, MUSurgery
		FROM #tPeople 
		WHERE AmountPaymentAccepted>0 AND Quantity IS NOT NULL AND MU NOT LIKE '71.1.%'
		UNION ALL 
		SELECT rf_idCase,MUUnGroupCode,MUGroupCode,MUCode,rf_idV002,DateBegin,DateEnd,Quantity,Tariff, MUSurgery
		FROM #tPeople 
		WHERE AmountPaymentAccepted=0 AND Quantity IS NOT NULL AND MU LIKE '71.1.%' 
	  ) t 

SELECT *
INTO tmpPeople
FROM PeopleAttach.dbo.vw_pid_q_mo
GO
