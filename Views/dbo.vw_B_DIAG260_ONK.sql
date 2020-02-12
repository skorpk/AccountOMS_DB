SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO





CREATE VIEW [dbo].[vw_B_DIAG260_ONK]
AS
SELECT  rf_idONK_SL ,TypeDiagnostic AS DIAG_TIP,CodeDiagnostic AS DIAG_CODE,ResultDiagnostic AS DIAG_RSLT ,DateDiagnostic AS DIAG_DATE ,REC_RSLT 
FROM dbo.t_260order_ONK o INNER JOIN dbo.t_ONK_SL s	ON
			o.rf_idCase=s.rf_idCase
						INNER JOIN dbo.t_DiagnosticBlock d ON
			s.id=d.rf_idONK_SL 
WHERE DateDiagnostic>='20180901' AND NOT EXISTS(SELECT 1 FROM dbo.tmp_ErrorDiagRSLT WHERE o.GUID_Case=SL_ID )
UNION ALL
SELECT  rf_idONK_SL ,TypeDiagnostic AS DIAG_TIP,CodeDiagnostic AS DIAG_CODE,ResultDiagnostic AS DIAG_RSLT ,DateDiagnostic AS DIAG_DATE ,REC_RSLT 
FROM dbo.t_260order_ONK o INNER JOIN dbo.t_ONK_SL s	ON
			o.rf_idCase=s.rf_idCase
						INNER JOIN dbo.t_DiagnosticBlock d ON
			s.id=d.rf_idONK_SL 
						INNER JOIN tmp_ErrorDiagRSLT e ON
            o.GUID_Case=e.SL_ID
WHERE DateDiagnostic>='20180901' AND d.TypeDiagnostic=2 AND d.CodeDiagnostic<>1
UNION ALL
SELECT  rf_idONK_SL ,TypeDiagnostic AS DIAG_TIP,CodeDiagnostic AS DIAG_CODE,ResultDiagnostic AS DIAG_RSLT ,DateDiagnostic AS DIAG_DATE ,REC_RSLT 
FROM dbo.t_260order_ONK o INNER JOIN dbo.t_ONK_SL s	ON
			o.rf_idCase=s.rf_idCase
						INNER JOIN dbo.t_DiagnosticBlock d ON
			s.id=d.rf_idONK_SL 
						INNER JOIN tmp_ErrorDiagRSLT e ON
            o.GUID_Case=e.SL_ID
WHERE DateDiagnostic>='20180901' AND d.TypeDiagnostic=1



GO
