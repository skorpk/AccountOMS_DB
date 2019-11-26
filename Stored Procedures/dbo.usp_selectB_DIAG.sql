SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[usp_selectB_DIAG]
@p_ONK_SLId bigint,
@p_DateEndCase nvarchar(8)
AS

SELECT DateDiagnostic DIAG_DATE,case when d.TypeDiagnostic=1 then 'гистологический признак' when d.TypeDiagnostic=2 then 'маркёр (ИГХ)' end DIAG_TIP,case when REC_RSLT=1 then 'да' else 'нет' end REC_RSLT
,cast(CodeDiagnostic as nvarchar(3))+' — '+ isnull(n7.Mrf_NAME,n10.Igh_NAME) DIAG_CODE,cast(ResultDiagnostic as nvarchar(3))+' — '+ isnull(n8.R_M_NAME,n11.R_I_NAME) DIAG_RSLT
FROM [AccountOMS].[dbo].[t_DiagnosticBlock] d
LEFT JOIN [oms_nsi].[dbo].[sprN007] n7 on n7.[ID_Mrf]=d.CodeDiagnostic and d.TypeDiagnostic=1 and @p_DateEndCase between n7.DATEBEG and n7.DATEEND
LEFT JOIN [oms_nsi].[dbo].[sprN010] n10 on n10.[ID_Igh]=d.CodeDiagnostic and d.TypeDiagnostic=2 and @p_DateEndCase between n10.DATEBEG and n10.DATEEND
LEFT JOIN [oms_nsi].[dbo].[sprN008] n8 on n8.ID_R_M=d.ResultDiagnostic and d.TypeDiagnostic=1 and @p_DateEndCase between n8.DATEBEG and n8.DATEEND
LEFT JOIN [oms_nsi].[dbo].[sprN011] n11 on n11.[ID_R_I]=d.ResultDiagnostic and d.TypeDiagnostic=2 and @p_DateEndCase between n11.DATEBEG and n11.DATEEND
where [rf_idONK_SL]=@p_ONK_SLId
GO
GRANT EXECUTE ON  [dbo].[usp_selectB_DIAG] TO [AccountsOMS]
GO
GRANT EXECUTE ON  [dbo].[usp_selectB_DIAG] TO [db_AccountOMS]
GO
