SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


CREATE VIEW [dbo].[vw_USL260_VMP]
AS
--SELECT  o.rf_idCase ,m.id  AS IDSERV,l.mcod AS LPU,m.rf_idV002 AS PROFIL,MUSurgery AS VID_VME,m.IsChildTariff AS DET,DateHelpBegin AS DATE_IN,DateHelpEnd AS DATE_OUT,DiagnosisCode AS DS,
--        MUSurgery AS CODE_USL,m.Quantity AS KOL_USL,Price AS TARIF,TotalPrice AS SUMV_USL,m.rf_idV004 AS PRVS,m.rf_idDoctor AS CODE_MD
--FROM dbo.t_260order_VMP o INNER JOIN dbo.t_Meduslugi m ON
--		o.rf_idCase=m.rf_idCase
--							INNER JOIN dbo.vw_sprT001 l ON
--		m.rf_idMO=l.CodeM 
--WHERE m.MUSurgery IS NOT NULL		                         
SELECT  DISTINCT o.rf_idCase ,m.id  AS IDSERV,l.mcod AS LPU,m.rf_idV002 AS PROFIL,c.rf_idV019 AS VID_VME,m.IsChildTariff AS DET,DateHelpBegin AS DATE_IN,DateHelpEnd AS DATE_OUT,DiagnosisCode AS DS,
        MUSurgery AS CODE_USL,m.Quantity AS KOL_USL,Price AS TARIF,TotalPrice AS SUMV_USL,m.rf_idV004 AS PRVS,m.rf_idDoctor AS CODE_MD
FROM dbo.t_260order_VMP o INNER JOIN dbo.t_Case c ON
		o.rf_idCase=c.id
							INNER JOIN dbo.t_Meduslugi m ON
		c.id=m.rf_idCase
							INNER JOIN dbo.vw_sprT001 l ON
		m.rf_idMO=l.CodeM 
WHERE m.MUSurgery IS NOT NULL
GO
