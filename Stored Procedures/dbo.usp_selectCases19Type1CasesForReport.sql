SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[usp_selectCases19Type1CasesForReport]

@rf_idCompletedCase varchar(max)--='19258589'
as

set @rf_idCompletedCase = replace(@rf_idCompletedCase,',','')

--declare @query varchar(max)=
--'SELECT c.id AS C_rf_idCase,c.idRecordCase C_idRecordCase,c.DateBegin C_DateBegin,c.DateEnd C_DateEnd,v25.IDPC+v25.N_PC C_P_CEL, c.TypeTranslation C_P_PER ,cast(c.KD as varchar(4))+'' дн.'' C_KD,
--c.rf_idSubMO C_LPU_1,c.rf_idDepartmentMO C_PODR,CASE WHEN c.IsChildTariff = 0 THEN ''Взрослый'' WHEN c.IsChildTariff = 1 THEN ''Детский'' ELSE ''Не указан'' END AS C_DET,
--cast(v2.Id as varchar(4))+'' — ''+ v2.Name C_PROFIL,cast(pob.rf_idV020 as varchar(4))+'' — ''+ v20.Name C_PROFIL_K,c.AmountPayment C_AmPAy,mes.Tariff C_TARIF,cast(c.rf_idV004 as varchar(4))+'' — ''+ v21.SPECNAME C_PRVS,
--c.rf_idDoctor C_IDDOCT,v18.[Name] C_VID_HMP, v19.Name C_METOD_HMP,''№''+sop.NumberTicket+'' от ''+ cast(sop.GetDatePaper as varchar(10)) C_TAL_D_NUM,mkb.DiagnosisCode+'' — ''+mkb.Diagnosis C_DS1,
--case when onk.DS_ONK=0 then ''Нет'' when onk.DS_ONK=1 then ''Да'' end C_DS_ONK,case when pov.DN=1 then ''состоит'' when pov.DN=2 then ''взят'' when pov.DN=4 then ''снят по причине выздоровления'' when pov.DN=6 then ''снят по другим причинам'' end C_DN,
--nv.[DateVizit] C_NEXT_VISIT,cast(c.C_ZAB as varchar)+ '' — ''+ v27.[N_CZ] C_ZAB

--FROM	   dbo.t_CompletedCase cc
--inner join dbo.[t_RecordCasePatient] rcp on rcp.id=cc.rf_idRecordCasePatient
--INNER JOIN dbo.t_Case c on c.rf_idRecordCasePatient=rcp.id
--INNER JOIN [dbo].[t_Diagnosis] d on d.rf_idCase=c.id and d.TypeDiagnosis=1
--INNER JOIN [dbo].[t_DS_ONK_REAB] onk on onk.[rf_idCase]=c.id

--INNER JOIN OMS_NSI.dbo.sprV002 AS v2 ON c.rf_idV002 = v2.Id and c.DateEnd between v2.DateBeg and v2.DateEnd
--INNER JOIN OMS_NSI.dbo.sprMKB AS mkb ON mkb.DiagnosisCode = d.DiagnosisCode

--LEFT JOIN [dbo].[t_PurposeOfVisit] pov on pov.rf_idCase=c.id
--LEFT JOIN [dbo].[t_ProfileOfBed] pob on pob.rf_idCase=c.id
--left join dbo.t_MES mes on mes.rf_idCase=c.id
--left join [dbo].[t_SlipOfPaper] sop on sop.rf_idCase=c.id
--left join [dbo].[t_NextVisitDate] nv on nv.rf_idCase=c.id

--LEFT JOIN [oms_nsi].[dbo].[sprV025] v25 on v25.IDPC=pov.rf_idV025 and c.DateEnd between v25.DATEBEG and v25.DATEEND
--LEFT JOIN OMS_NSI.dbo.sprV020 AS v20 ON pob.rf_idV020 = v20.code and c.DateEnd between v20.DateBeg and v20.DateEnd
--LEFT JOIN OMS_NSI.dbo.sprV021 AS v21 ON c.rf_idV004 = v21.[SprV021Id] and c.DateEnd between v21.DateBeg and v21.DateEnd
--left JOIN OMS_NSI.dbo.sprV018 v18 ON c.rf_idV018 = v18.Code and c.DateEnd between v18.DateBeg and v18.DateEnd
--left join OMS_NSI.dbo.sprV019 v19 on c.rf_idV019 = v19.Code and c.DateEnd between v19.DateBeg and v19.DateEnd
--left join [oms_nsi].[dbo].[sprV027] v27 on v27.IDCZ=c.C_ZAB and c.DateBegin between v27.DateBeg and v27.DateEnd

--where cc.id in ('+@rf_idCompletedCase+')'

--print(@query)
--exec(@query)

SELECT * INTO #rf_idCompletedCases FROM fn_iter_intlist_to_table(@rf_idCompletedCase) 

SELECT c.id AS C_rf_idCase,c.idRecordCase C_idRecordCase,c.DateBegin C_DateBegin,c.DateEnd C_DateEnd,v25.IDPC+' — '+v25.N_PC C_P_CEL, c.TypeTranslation C_P_PER ,cast(c.KD as varchar(4))+' дн.' C_KD,
c.rf_idSubMO C_LPU_1,c.rf_idDepartmentMO C_PODR,CASE WHEN c.IsChildTariff = 0 THEN 'Взрослый' WHEN c.IsChildTariff = 1 THEN 'Детский' ELSE 'Не указан' END AS C_DET,
cast(v2.Id as varchar(4))+' — '+ v2.Name C_PROFIL,cast(pob.rf_idV020 as varchar(4))+' — '+ v20.Name C_PROFIL_K,c.AmountPayment C_AmPAy,mes.Tariff C_TARIF,cast(c.rf_idV004 as varchar(4))+' — '+ v21.SPECNAME C_PRVS,
c.rf_idDoctor C_IDDOCT,v18.[Name] C_VID_HMP, v19.Name C_METOD_HMP,'№'+sop.NumberTicket+' от '+ cast(sop.GetDatePaper as varchar(10)) C_TAL_D_NUM,mkb.DiagnosisCode+' — '+mkb.Diagnosis C_DS1,
case when onk.DS_ONK=0 then 'Нет' when onk.DS_ONK=1 then 'Да' end C_DS_ONK,case when pov.DN=1 then 'состоит' when pov.DN=2 then 'взят' when pov.DN=4 then 'снят по причине выздоровления' when pov.DN=6 then 'снят по другим причинам' end C_DN,
nv.[DateVizit] C_NEXT_VISIT,cast(c.C_ZAB as varchar)+ ' — '+ v27.[N_CZ] C_ZAB,rtrim(mes.MES) + ' — '+ ISNULL(s.[MUName],csg.[name]) C_MES_KSG,c.Comments C_COMMENT,ltrim(rtrim(kiro.ValueKiro)) C_S_KIRO,c.IT_SL C_IT_SL,
cc.id rf_idCompletedCase

FROM	   dbo.t_CompletedCase cc
inner join dbo.[t_RecordCasePatient] rcp on rcp.id=cc.rf_idRecordCasePatient
INNER JOIN dbo.t_Case c on c.rf_idRecordCasePatient=rcp.id
INNER JOIN [dbo].[t_Diagnosis] d on d.rf_idCase=c.id and d.TypeDiagnosis=1
INNER JOIN [dbo].[t_DS_ONK_REAB] onk on onk.[rf_idCase]=c.id
inner join #rf_idCompletedCases c1 on c1.number=cc.id

INNER JOIN OMS_NSI.dbo.sprV002 AS v2 ON c.rf_idV002 = v2.Id and c.DateEnd between v2.DateBeg and v2.DateEnd
INNER JOIN OMS_NSI.dbo.sprMKB AS mkb ON mkb.DiagnosisCode = d.DiagnosisCode

LEFT JOIN [dbo].[t_PurposeOfVisit] pov on pov.rf_idCase=c.id
LEFT JOIN [dbo].[t_ProfileOfBed] pob on pob.rf_idCase=c.id
left join dbo.t_MES mes on mes.rf_idCase=c.id
left join [dbo].[t_SlipOfPaper] sop on sop.rf_idCase=c.id
left join [dbo].[t_NextVisitDate] nv on nv.rf_idCase=c.id
left join [dbo].t_Kiro kiro on kiro.rf_idCase=c.id

LEFT JOIN [oms_nsi].[dbo].[sprV025] v25 on v25.IDPC=pov.rf_idV025 and c.DateEnd between v25.DATEBEG and v25.DATEEND
LEFT JOIN OMS_NSI.dbo.sprV020 AS v20 ON pob.rf_idV020 = v20.code and c.DateEnd between v20.DateBeg and v20.DateEnd
LEFT JOIN OMS_NSI.dbo.sprV021 AS v21 ON c.rf_idV004 = v21.IDSPEC and c.DateEnd between v21.DateBeg and v21.DateEnd
left JOIN OMS_NSI.dbo.sprV018 v18 ON c.rf_idV018 = v18.Code and c.DateEnd between v18.DateBeg and v18.DateEnd
left join OMS_NSI.dbo.sprV019 v19 on c.rf_idV019 = v19.Code and c.DateEnd between v19.DateBeg and v19.DateEnd
left join [oms_nsi].[dbo].[sprV027] v27 on v27.IDCZ=c.C_ZAB and c.DateBegin between v27.DateBeg and v27.DateEnd
left join [OMS_nsi].[dbo].[tCSGroup] csg on csg.code=mes.mes and c.DateEnd between csg.dateBeg and csg.dateEnd
LEFT JOIN (SELECT DISTINCT MU,MUName from dbo.vw_sprMUAll) s on s.[MU]=mes.[MES]





GO
GRANT EXECUTE ON  [dbo].[usp_selectCases19Type1CasesForReport] TO [AccountsOMS]
GO
GRANT EXECUTE ON  [dbo].[usp_selectCases19Type1CasesForReport] TO [db_AccountOMS]
GO
