SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



CREATE VIEW [dbo].[vw_USL260_ONK]
AS
SELECT  o.rf_idCase ,m.id  AS IDSERV,o.CODE_MO/*l.mcod*/ AS LPU,m.rf_idSubMO AS LPU_1,m.rf_idDepartmentMO AS PODR
		,m.rf_idV002 AS PROFIL,s.CodeMU AS VID_VME,m.IsChildTariff AS DET,DateHelpBegin AS DATE_IN,DateHelpEnd AS DATE_OUT,DiagnosisCode AS DS,
        MUSurgery AS CODE_USL,m.Quantity AS KOL_USL,Price AS TARIF,TotalPrice AS SUMV_USL,m.rf_idV004 AS PRVS,ISNULL(m.rf_idDoctor,o.LPU+'1') AS CODE_MD
FROM dbo.t_260order_ONK o INNER JOIN dbo.t_Meduslugi m ON
		o.rf_idCase=m.rf_idCase
							LEFT JOIN dbo.vw_sprT001 l ON
		m.rf_idMO=l.CodeM	
							LEFT JOIN (SELECT IDRB AS CodeMU FROM  oms_nsi.dbo.V001 WHERE isTelemedicine<>1) s ON
       m.MUSurgery=s.CodeMU
WHERE m.MUSurgery IS NOT NULL                          
GO
