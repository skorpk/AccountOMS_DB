SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[usp_selectCases19Type1ForReport]
--declare
@rf_idCompletedCase varchar(max)--='19967987'
as

set @rf_idCompletedCase = Replace(@rf_idCompletedCase,',','')

--declare @query varchar(max)=
--'SELECT cc.id AS CC_rf_idCompletedCase,cc.idRecordCase CC_idRecordCase,cc.DateBegin CC_DateBegin,cc.DateEnd CC_DateEnd,cast(cc.HospitalizationPeriod as varchar(4))+'' дн.'' CC_KD_Z,cast(c.rf_idV009 as varchar(4))+'' — ''+ v9.Name CC_Result,c.rf_idMO+'' — ''+mo2.NameS CC_LPU,
--v10.Name CC_IDSP,v6.Name CC_USL_OK,c.rf_idDirectMO+'' — '' + mo3.NameS AS CC_NPR_MO,dmu.DirectionDate CC_NPR_DATE,cast(c.rf_idV012 as varchar(4))+'' — ''+v12.Name CC_ISHOD,cast(c.rf_idV014 as varchar(4))+'' — ''+v14.Name CC_FOR_POM,cast(c.rf_idV008 as varchar(4))+'' — ''+v8.Name CC_VIDPOM,
--cc.AmountPayment CC_AmountPayment,case when c.MSE=1 then ''Да'' else ''Нет'' end CC_MSE,case when cc.VB_P=1 then ''Да'' else ''Нет'' end CC_VB_P,
--ra.Account RA_Account, ra.[DateRegister] RA_DSCHET,datename(mm,cc.DateEnd)+'' ''+cast(ra.ReportYear as nvarchar) RA_ReportPeriod, f.DateRegistration RA_DateRegister,ra.AmountPayment RA_AmountPayment,
--f.CodeM +'' — '' + mo.NameS AS RA_МО, ra.rf_idSMO +'' — '' + SMO.[NAM_SMOK] RA_SMO,
--UPPER(rp.Fam + '' '' + rp.Im + '' '' + ISNULL(rp.Ot, '''')) RP_FIO, v5.Name as RP_Sex, c.age RP_AGE,
--rp.BirthDay RP_BirthDay, c.NumberHistoryCase RP_NumHistCase, rpd.SNILS RP_SNILS,ltrim(isnull(rcp.SeriaPolis,'''')+'' ''+ rcp.NumberPolis) RP_POLIS, psmo.ENP RP_ENP,dctp.Name+'' ''+ rpd.SeriaDocument+'' ''+ rpd.NumberDocument RP_DOCSERNUM,
--rcp.[AttachLPU] +'' — ''+mo1.NameS RP_AttachMO,case when RTRIM(rcp.[NewBorn])>0 then ''Да'' else ''Нет'' end+'', '' + cast(rcp.BirthWeight as nvarchar(4)) RP_NewBorn,UPPER(rpa.Fam + '' '' + rpa.Im + '' '' + ISNULL(rpa.Ot, '''')) RP_FIOAttendant,
--disgrname.[DisabilityGroupName] RP_DisGroup, dis.DateDefine RP_DisDate,disreasname.[DisabilityReasonName] RP_DisReason, dis.Diagnosis+'' — ''+ mkb.Diagnosis RP_DisDiag

--FROM	   dbo.t_CompletedCase cc
--inner join dbo.[t_RecordCasePatient] rcp on rcp.id=cc.rf_idRecordCasePatient
--inner join dbo.[t_RegistersAccounts] ra on rcp.rf_idRegistersAccounts=ra.id
--INNER JOIN dbo.t_File AS f ON ra.rf_idFiles = f.id
--INNER JOIN OMS_NSI.[dbo].[sprSMO] AS SMO ON ra.[rf_idSMO] = SMO.[SMOKOD]
--INNER JOIN dbo.t_RegisterPatient AS rp ON rp.rf_idRecordCase = rcp.id
--INNER JOIN OMS_NSI.dbo.sprV005 AS v5 ON rp.rf_idV005 = v5.Id
--INNER JOIN dbo.t_Case c on c.rf_idRecordCasePatient=rcp.id
--inner join dbo.t_PatientSMO psmo on psmo.rf_idRecordCasePatient=rcp.id

--INNER JOIN dbo.vw_sprT001_Report AS mo ON mo.CodeM = f.CodeM /*Выставившая счет МО*/
--INNER JOIN dbo.vw_sprT001_Report AS mo2 ON mo2.CodeM = c.rf_idMO /*МО лечения*/
--INNER JOIN OMS_NSI.dbo.sprV010 AS v10 ON c.rf_idV010 = v10.Id and cc.DateEnd between v10.DateBeg and v10.DateEnd
--INNER JOIN OMS_NSI.dbo.sprV006 AS v6 ON c.rf_idV006 = v6.Id and cc.DateEnd between v6.DateBeg and v6.DateEnd
--INNER JOIN OMS_NSI.dbo.sprV008 AS v8 ON c.rf_idV008 = v8.Id and cc.DateEnd between v8.DateBeg and v8.DateEnd
--INNER JOIN OMS_NSI.dbo.sprV014 AS v14 ON c.rf_idV014 = v14.[sprV014Id] and cc.DateEnd between v14.DateBeg and v14.DateEnd

--LEFT JOIN dbo.t_RegisterPatientDocument AS rpd ON rpd.rf_idRegisterPatient = rp.id
--LEFT join [oms_nsi].[dbo].[sprDocumentType] dctp on dctp.ID=rpd.[rf_idDocumentType]
--left join [dbo].[t_RegisterPatientAttendant] rpa on rpa.rf_idRegisterPatient=rp.id
--left JOIN [dbo].[t_Disability] dis ON dis.[rf_idRecordCasePatient]=rcp.id
--left JOIN [dbo].[t_DirectionMU] dmu on dmu.rf_idCase=c.id

--LEFT JOIN dbo.vw_sprT001_Report AS mo1 ON mo1.CodeM = rcp.[AttachLPU] /*МО прикрепления*/
--LEFT JOIN dbo.vw_sprT001_Report AS mo3 ON mo3.CodeM = c.rf_idDirectMO /*Направившая на лечение МО*/
--left join OMS_NSI.dbo.sprMKB AS mkb ON mkb.DiagnosisCode = dis.Diagnosis
--LEFT JOIN OMS_NSI.dbo.sprV009 AS v9 ON c.rf_idV009 = v9.Id and cc.DateEnd between v9.DateBeg and v9.DateEnd
--LEFT JOIN OMS_NSI.dbo.sprV012 AS v12 ON c.rf_idV012 = v12.Id and cc.DateEnd between v12.DateBeg and v12.DateEnd
--left JOIN [dbo].[t_DisabilityGroupName] disgrname on disgrname.[rf_idTypeOfGroup]=dis.TypeOfGroup
--left JOIN [dbo].[t_DisabilityReasonName] disreasname on disreasname.rf_idReasonDisability = dis.rf_idReasonDisability

--where cc.id in ('+@rf_idCompletedCase+')

--group by cc.id,cc.idRecordCase,cc.DateBegin,cc.DateEnd,cast(cc.HospitalizationPeriod as varchar(4))+'' дн.'',cast(c.rf_idV009 as varchar(4))+'' — ''+ v9.Name,c.rf_idMO+'' — ''+mo2.NameS,v10.Name,v6.Name,
--c.rf_idDirectMO+'' — '' + mo3.NameS,dmu.DirectionDate,cast(c.rf_idV012 as varchar(4))+'' — ''+v12.Name,cast(c.rf_idV014 as varchar(4))+'' — ''+v14.Name,cast(c.rf_idV008 as varchar(4))+'' — ''+v8.Name,cc.AmountPayment,case when c.MSE=1 then ''Да'' else ''Нет'' end,
--case when cc.VB_P=1 then ''Да'' else ''Нет'' end,ra.Account, ra.[DateRegister],datename(mm,cc.DateEnd)+'' ''+cast(ra.ReportYear as nvarchar), f.DateRegistration,ra.AmountPayment,f.CodeM +'' — '' + mo.NameS,
--ra.rf_idSMO +'' — '' + SMO.[NAM_SMOK],UPPER(rp.Fam + '' '' + rp.Im + '' '' + ISNULL(rp.Ot, '''')), v5.Name, c.age,rp.BirthDay, c.NumberHistoryCase, rpd.SNILS,ltrim(isnull(rcp.SeriaPolis,'''')+'' ''+ rcp.NumberPolis),
--psmo.ENP,dctp.Name+'' ''+ rpd.SeriaDocument+'' ''+ rpd.NumberDocument,rcp.[AttachLPU] +'' — ''+mo1.NameS,case when RTRIM(rcp.[NewBorn])>0 then ''Да'' else ''Нет'' end+'', '' + cast(rcp.BirthWeight as nvarchar(4)),
--UPPER(rpa.Fam + '' '' + rpa.Im + '' '' + ISNULL(rpa.Ot, '''')),disgrname.[DisabilityGroupName], dis.DateDefine,disreasname.[DisabilityReasonName], dis.Diagnosis+'' — ''+ mkb.Diagnosis
--order by cc.id'

--print(@query)
--exec(@query)

SELECT * INTO #rf_idCompletedCases FROM fn_iter_intlist_to_table(@rf_idCompletedCase) 

SELECT cc.id AS CC_rf_idCompletedCase,cc.idRecordCase CC_idRecordCase,cc.DateBegin CC_DateBegin,cc.DateEnd CC_DateEnd,cast(cc.HospitalizationPeriod as varchar(4))+' дн.' CC_KD_Z,cast(c.rf_idV009 as varchar(4))+' — '+ v9.Name CC_Result,c.rf_idMO+' — '+mo2.NameS CC_LPU,
v10.Name CC_IDSP/*способ оплаты*/,v6.Name CC_USL_OK,c.rf_idDirectMO+' — ' + mo3.NameS AS CC_NPR_MO,dmu.DirectionDate CC_NPR_DATE,cast(c.rf_idV012 as varchar(4))+' — '+v12.Name CC_ISHOD,cast(c.rf_idV014 as varchar(4))+' — '+v14.Name CC_FOR_POM,cast(c.rf_idV008 as varchar(4))+' — '+v8.Name CC_VIDPOM,
cc.AmountPayment CC_AmountPayment,case when c.MSE=1 then 'Да' else 'Нет' end CC_MSE,case when cc.VB_P=1 then 'Да' else 'Нет' end CC_VB_P,
ra.Account RA_Account, ra.[DateRegister] RA_DSCHET,datename(mm,cc.DateEnd)+' '+cast(ra.ReportYear as nvarchar) RA_ReportPeriod, f.DateRegistration RA_DateRegister,ra.AmountPayment RA_AmountPayment,
f.CodeM +' — ' + mo.NameS AS RA_МО, ra.rf_idSMO +' — ' + SMO.[NAM_SMOK] RA_SMO,
UPPER(rp.Fam + ' ' + rp.Im + ' ' + ISNULL(rp.Ot, '')) RP_FIO, v5.Name as RP_Sex, c.age RP_AGE,
rp.BirthDay RP_BirthDay, c.NumberHistoryCase RP_NumHistCase, rpd.SNILS RP_SNILS,ltrim(isnull(rcp.SeriaPolis,'')+' '+ rcp.NumberPolis) RP_POLIS, psmo.ENP RP_ENP,dctp.Name+' '+ rpd.SeriaDocument+' '+ rpd.NumberDocument RP_DOCSERNUM,
rcp.[AttachLPU] +' — '+mo1.NameS RP_AttachMO,case when RTRIM(rcp.[NewBorn])>0 then 'Да' else 'Нет' end+', ' + cast(rcp.BirthWeight as nvarchar(4)) RP_NewBorn,UPPER(rpa.Fam + ' ' + rpa.Im + ' ' + ISNULL(rpa.Ot, '')) RP_FIOAttendant,
disgrname.[DisabilityGroupName] RP_DisGroup, dis.DateDefine RP_DisDate,disreasname.[DisabilityReasonName] RP_DisReason, dis.Diagnosis+' — '+ mkb.Diagnosis RP_DisDiag

FROM	   dbo.t_CompletedCase cc
inner join dbo.[t_RecordCasePatient] rcp on rcp.id=cc.rf_idRecordCasePatient
inner join dbo.[t_RegistersAccounts] ra on rcp.rf_idRegistersAccounts=ra.id
INNER JOIN dbo.t_File AS f ON ra.rf_idFiles = f.id
INNER JOIN OMS_NSI.[dbo].[sprSMO] AS SMO ON ra.[rf_idSMO] = SMO.[SMOKOD]
INNER JOIN dbo.t_RegisterPatient AS rp ON rp.rf_idRecordCase = rcp.id
INNER JOIN OMS_NSI.dbo.sprV005 AS v5 ON rp.rf_idV005 = v5.Id
INNER JOIN dbo.t_Case c on c.rf_idRecordCasePatient=rcp.id
inner join dbo.t_PatientSMO psmo on psmo.rf_idRecordCasePatient=rcp.id
inner join #rf_idCompletedCases c1 on c1.number=cc.id

INNER JOIN dbo.vw_sprT001_Report AS mo ON mo.CodeM = f.CodeM /*Выставившая счет МО*/
INNER JOIN dbo.vw_sprT001_Report AS mo2 ON mo2.CodeM = c.rf_idMO /*МО лечения*/
INNER JOIN OMS_NSI.dbo.sprV010 AS v10 ON c.rf_idV010 = v10.Id and cc.DateEnd between v10.DateBeg and v10.DateEnd
INNER JOIN OMS_NSI.dbo.sprV006 AS v6 ON c.rf_idV006 = v6.Id and cc.DateEnd between v6.DateBeg and v6.DateEnd
INNER JOIN OMS_NSI.dbo.sprV008 AS v8 ON c.rf_idV008 = v8.Id and cc.DateEnd between v8.DateBeg and v8.DateEnd
INNER JOIN OMS_NSI.dbo.sprV014 AS v14 ON c.rf_idV014 = v14.[sprV014Id] and cc.DateEnd between v14.DateBeg and v14.DateEnd

LEFT JOIN dbo.t_RegisterPatientDocument AS rpd ON rpd.rf_idRegisterPatient = rp.id
LEFT join [oms_nsi].[dbo].[sprDocumentType] dctp on dctp.ID=rpd.[rf_idDocumentType]
left join [dbo].[t_RegisterPatientAttendant] rpa on rpa.rf_idRegisterPatient=rp.id
left JOIN [dbo].[t_Disability] dis ON dis.[rf_idRecordCasePatient]=rcp.id
left JOIN [dbo].[t_DirectionMU] dmu on dmu.rf_idCase=c.id

LEFT JOIN dbo.vw_sprT001_Report AS mo1 ON mo1.CodeM = rcp.[AttachLPU] /*МО прикрепления*/
LEFT JOIN dbo.vw_sprT001_Report AS mo3 ON mo3.CodeM = c.rf_idDirectMO /*Направившая на лечение МО*/
left join OMS_NSI.dbo.sprMKB AS mkb ON mkb.DiagnosisCode = dis.Diagnosis
LEFT JOIN OMS_NSI.dbo.sprV009 AS v9 ON c.rf_idV009 = v9.Id and cc.DateEnd between v9.DateBeg and v9.DateEnd
LEFT JOIN OMS_NSI.dbo.sprV012 AS v12 ON c.rf_idV012 = v12.Id and cc.DateEnd between v12.DateBeg and v12.DateEnd
left JOIN [dbo].[t_DisabilityGroupName] disgrname on disgrname.[rf_idTypeOfGroup]=dis.TypeOfGroup
left JOIN [dbo].[t_DisabilityReasonName] disreasname on disreasname.rf_idReasonDisability = dis.rf_idReasonDisability

--where cc.id=@rf_idCompletedCase


group by cc.id,cc.idRecordCase,cc.DateBegin,cc.DateEnd,cast(cc.HospitalizationPeriod as varchar(4))+' дн.',cast(c.rf_idV009 as varchar(4))+' — '+ v9.Name,c.rf_idMO+' — '+mo2.NameS,v10.Name,v6.Name,
c.rf_idDirectMO+' — ' + mo3.NameS,dmu.DirectionDate,cast(c.rf_idV012 as varchar(4))+' — '+v12.Name,cast(c.rf_idV014 as varchar(4))+' — '+v14.Name,cast(c.rf_idV008 as varchar(4))+' — '+v8.Name,cc.AmountPayment,case when c.MSE=1 then 'Да' else 'Нет' end,
case when cc.VB_P=1 then 'Да' else 'Нет' end,ra.Account, ra.[DateRegister],datename(mm,cc.DateEnd)+' '+cast(ra.ReportYear as nvarchar), f.DateRegistration,ra.AmountPayment,f.CodeM +' — ' + mo.NameS,
ra.rf_idSMO +' — ' + SMO.[NAM_SMOK],UPPER(rp.Fam + ' ' + rp.Im + ' ' + ISNULL(rp.Ot, '')), v5.Name, c.age,rp.BirthDay, c.NumberHistoryCase, rpd.SNILS,ltrim(isnull(rcp.SeriaPolis,'')+' '+ rcp.NumberPolis),
psmo.ENP,dctp.Name+' '+ rpd.SeriaDocument+' '+ rpd.NumberDocument,rcp.[AttachLPU] +' — '+mo1.NameS,case when RTRIM(rcp.[NewBorn])>0 then 'Да' else 'Нет' end+', ' + cast(rcp.BirthWeight as nvarchar(4)),
UPPER(rpa.Fam + ' ' + rpa.Im + ' ' + ISNULL(rpa.Ot, '')),disgrname.[DisabilityGroupName], dis.DateDefine,disreasname.[DisabilityReasonName], dis.Diagnosis+' — '+ mkb.Diagnosis
order by cc.id


--drop table #rf_idCompletedCases



GO
GRANT EXECUTE ON  [dbo].[usp_selectCases19Type1ForReport] TO [AccountsOMS]
GO
GRANT EXECUTE ON  [dbo].[usp_selectCases19Type1ForReport] TO [db_AccountOMS]
GO
