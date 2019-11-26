SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [dbo].[usp_GetDataFFOMS_Disp]
		@mm TINYINT,
		@codeM CHAR(6),
		@snils VARCHAR(11),
		@id INT,
		@reportYear smallint
AS        
--SELECT @id=N_ZAP2 FROM dbo.t_Report1FFOMS WHERE reportMonth=@mm AND AttachLPU=@codeM AND SNILS_Doc=@snils AND ReportYear=@reportYear 
--DECLARE @reportYear SMALLINT=2016
SELECT  (SELECT  @id AS 'N_ZAP', l.mcod AS 'MO_SV_V',t.SNILS_Doc AS 'SNILS_V'
	------------------------------Female------------------------------------------------------
	,(select t.C_POKL AS 'C_POKL'
			,count(t.rf_idCase) AS 'P_VS'
			,count(CASE WHEN t.Sex=2 AND Age>17 AND Age<55 THEN t.rf_idCase ELSE NULL END) AS 'P_Z1'
			,count(CASE WHEN t.Sex=2 AND Age>54 THEN t.rf_idCase ELSE NULL END) AS 'P_Z2'
			-----------------------------Male--------------------------------------------------------
			,count(CASE WHEN t.Sex=1 AND Age>17 AND Age<60 THEN t.rf_idCase ELSE NULL END) AS 'P_M1'
			,count(CASE WHEN t.Sex=1 AND Age>59 THEN t.rf_idCase ELSE NULL END) AS 'P_M2'	
		FROM dbo.t_Report1FFOMS t 
		WHERE reportMonth=@mm AND AttachLPU=@codeM AND SNILS_Doc=@snils AND ReportYear=@reportYear
		GROUP BY t.C_POKL
		FOR XML PATH('SVEL_PO_P'),TYPE)
FROM dbo.t_Report1FFOMS t INNER JOIN dbo.vw_sprT001 l ON
					t.AttachLPU=l.CodeM  
WHERE reportMonth=@mm AND AttachLPU=@codeM AND SNILS_Doc=@snils AND ReportYear=@reportYear
GROUP BY l.mcod ,t.SNILS_Doc
FOR XML PATH(''),TYPE,ROOT('OBSV')),
(
	SELECT  t.id AS 'ZAP/N_ZAP'
			,Sex AS 'ZAP/PACIENT/W'
			,Age AS 'ZAP/PACIENT/VZST'
			,l.mcod AS 'ZAP/PACIENT/MO_SV_V'
			,SNILS_Doc AS 'ZAP/PACIENT/SNILS_V'
			,NumberCase AS 'ZAP/SLUCH/IDCASE'
			,DISPName AS 'ZAP/SLUCH/DISP'
			,P_OTK AS 'ZAP/SLUCH/P_OTK'
	FROM dbo.t_Report1FFOMS t INNER JOIN dbo.vw_sprT001 l ON
					t.AttachLPU=l.CodeM  
	WHERE reportMonth=@mm AND AttachLPU=@codeM AND SNILS_Doc=@snils AND ReportYear=@reportYear
	ORDER BY rf_idCase
	FOR XML PATH(''),TYPE,ROOT('PDRSV')
	
)
GO
GRANT EXECUTE ON  [dbo].[usp_GetDataFFOMS_Disp] TO [db_AccountOMS]
GO
