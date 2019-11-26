SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[usp_GetXMLSendingDataToFFOMS2017]
					@nameFile varchar(20),
					@reportMonth TINYINT,
					@reportYear SMALLINT,
					@code tinyint
as

DECLARE @code1 INT,
		@fileName VARCHAR(25)

SELECT @code1=MAX(id) FROM dbo.t_SendingFileToFFOMS WHERE ReportMonth=@reportMonth AND ReportYear=@reportYear AND NumberOfEndFile=@code
SELECT @fileName=NameFile FROM dbo.t_SendingFileToFFOMS WHERE ReportYear=@reportYear AND ReportMonth=@reportMonth

SELECT t.colXML from(
SELECT (
SELECT '2.0' AS 'VERSION', CAST(GETDATE() AS DATE) AS 'DATA',@nameFile+RIGHT('000'+CAST(@code AS varchar(3)),4) AS 'FILENAME', @fileName AS 'FIRSTNAME' FOR XML PATH('ZGLV'),TYPE),
(SELECT @code1 AS 'CODE', @reportYear AS 'YEAR',@reportMonth AS 'MONTH' FOR XML PATH('SVD'),TYPE),
(SELECT id AS 'N_ZAP', rf_idF008 AS 'PACIENT/VPOLIS',SeriaPolis AS 'PACIENT/SPOLIS', RTRIM(NumberPolis) AS 'PACIENT/NPOLIS',rf_idV005 AS 'PACIENT/W', BirthDay AS 'PACIENT/DR',
		VZST AS 'PACIENT/VZST',id AS 'SLUCH/IDCASE',rf_idV014 AS 'SLUCH/FOR_POM',rf_idMO AS 'SLUCH/LPU',UnitOfHospital AS 'SLUCH/PODR',DateBegin AS 'SLUCH/DATE_1',
		DateEnd AS 'SLUCH/DATE_2',DS1 AS 'SLUCH/DS1',DS2 AS 'SLUCH/DS2',DS3 AS 'SLUCH/DS3', rf_idV009 AS 'SLUCH/RSLT',K_KSG AS 'SLUCH/K_KSG', KSG_PG AS 'SLUCH/KSG_PG',SL_K AS 'SLUCH/SL_K',
		IT_SL AS 'SLUCH/IT_SL'
		,(SELECT CASE WHEN Code_SL=2 THEN 3 ELSE Code_SL END AS 'IDSL',Coefficient AS 'Z_SL' FROM dbo.t_Coefficient WHERE rf_idCase=s.rf_idCase FOR XML PATH('SL_KOEF'),TYPE) 'SLUCH'
		,AmountPayment AS 'SLUCH/SUM',PVT AS 'SLUCH/PVT',
		idMU AS 'SLUCH/USL/IDSERV',MUSurgery AS 'SLUCH/USL/CODE_USL'
FROM dbo.t_SendingDataIntoFFOMS2017 s
WHERE ReportMonth=@reportMonth AND ReportYear=@reportYear AND IsFullDoubleDate=0 AND IsUnload=0
FOR XML PATh('ZAP'),TYPE,ROOT('PODR')
) 
FOR XML PATH(''),TYPE,ROOT('ISP_OB')
) t(colXML)
GO
