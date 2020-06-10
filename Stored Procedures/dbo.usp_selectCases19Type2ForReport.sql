SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[usp_selectCases19Type2ForReport]
@rf_idCase nvarchar(max)
    
AS 

--SELECT c.id rf_idCase,ra.Account,ra.DateRegister,datename(mm,c.DateEnd)+' '+cast(ra.ReportYear as nvarchar) [ReportPeriod],ra.AmountPayment AmPayAccount,c.idRecordCase AS Случай,dmo.NAM_MOK AS Направление,v2.name AS Профиль,CASE WHEN c.IsChildTariff = 0 THEN 'Взрослый' WHEN c.IsChildTariff = 1 THEN 'Детский' ELSE 'Не указан' END AS Тариф ,
--			c.NumberHistoryCase AS НомерКарты,c.DateBegin AS Начат,c.DateEnd AS Окончен,c.AmountPayment AS Выставлено,v9.Name AS Результат,v4.Name AS СпециальностьМедРаботника,rp.Fam + ' ' + rp.Im + ' ' + ISNULL(rp.Ot, '') AS Пациент,
--			v5.Name AS Пол,rp.BirthDay AS ДатаРождения,c.age AS Возраст,rpd.SNILS AS СНИЛС/*пациента*/,ltrim(isnull(rcp.SeriaPolis,'')+' '+ rcp.NumberPolis) AS НомерПолиса,f.DateRegistration AS ДатаРегистрации,
--			f.CodeM +' — '+mo2.NameS AS МО,rcp.[AttachLPU] AS МОПрикрепления,case when RTRIM(rcp.[NewBorn])=0 then 'Нет' when RTRIM(rcp.[NewBorn])=1 then 'Да' end  as NewBornWord,
--			c.rf_idDoctor СНИЛСВрача,rp.TEL PacTel,dis.[DateDefine] ДатаИнвалидности,

--			case when rcp.IsNew=0 then 'Первичная' when rcp.IsNew=1 then 'Повторная' end PR_NOV, --Признак исправленной записи
--			psmo.ENP ENP,
--			v16.Code TypeDisp, --Тип диспансеризации
--			v16.Name TypeDispName,
--			case when c.IsFirstDS=1 then 'Да' when c.IsFirstDS=0 then 'Нет' else 'Не указано' end DS1_PR, --Выявлен впервые
--			case when c.IsNeedDisp=1 then 'Состоит на ДН' when c.IsNeedDisp=2 then 'Взят на ДН' when c.IsNeedDisp=2 then 'Не подлежит ДН' end PR_D_N, --Диспансерное наблюдение
--			rtrim(mes.MES)+' — '+ mu.[MUName] CODE_MES1, --Код ЗС
--			case when di.IsMobileTeam=0 then 'Нет' when di.IsMobileTeam=1 then 'Да' end VBR,--Признак ММБ
--			case when di.TypeFailure=0 then 'Нет' when di.TypeFailure=1 then 'Да' end P_OTK, --Признак отказа
--			case when di.IsOnko=0 then 'Нет' when di.IsOnko=1 then 'Да' end DS_ONK, --Подозрение на ЗНО
--			c.Comments COMENTSL, --Комментарий к случаю
--		[SMOKOD] + ' — ' + [NAM_SMOK] SMO
		 
--	FROM    dbo.t_Case AS c	
--	inner join t_DispInfo di on di.rf_idCase=c.id
--	INNER JOIN dbo.t_RecordCasePatient AS rcp ON c.rf_idRecordCasePatient = rcp.id
--	inner join dbo.t_PatientSMO psmo on psmo.rf_idRecordCasePatient=rcp.id
--	INNER JOIN dbo.t_RegistersAccounts AS ra ON rcp.rf_idRegistersAccounts = ra.id
--	INNER JOIN dbo.t_File AS f ON ra.rf_idFiles = f.id
--	INNER JOIN dbo.t_RegisterPatient AS rp ON rp.rf_idRecordCase = rcp.id
--	INNER JOIN OMS_NSI.dbo.sprV002 AS v2 ON c.rf_idV002 = v2.Id
--	INNER JOIN OMS_NSI.dbo.sprV005 AS v5 ON rp.rf_idV005 = v5.Id
--	INNER JOIN dbo.vw_sprT001_Report AS mo2 ON mo2.CodeM = f.CodeM
--	inner join [oms_nsi].[dbo].[sprV016TFOMS] v16 on v16.Code=di.TypeDisp
--	inner join [dbo].[t_CompletedCase] cc on cc.rf_idRecordCasePatient=rcp.id
--	INNER JOIN [OMS_NSI].[dbo].[sprSMO] AS SMO ON ra.[rf_idSMO] = SMO.[SMOKOD]
--	left JOIN [dbo].[t_Disability] dis ON dis.[rf_idRecordCasePatient]=rcp.id
--	LEFT JOIN OMS_NSI.dbo.sprMO AS dmo ON dmo.mcod = c.rf_idDirectMO
--	LEFT JOIN OMS_NSI.dbo.sprV009 AS v9 ON c.rf_idV009 = v9.Id
--	LEFT JOIN dbo.t_RegisterPatientDocument AS rpd ON rpd.rf_idRegisterPatient = rp.id
--	LEFT JOIN [dbo].[vw_sprMedicalSpeciality] v4 on c.rf_idV004=v4.id AND c.DateEnd>=v4.DateBeg AND c.DateEnd<v4.DateEnd
--	left join dbo.t_MES mes on mes.rf_idCase=c.id
--	LEFT JOIN dbo.vw_sprMUAll mu on mu.[MU]=mes.[MES]

--	where c.id in (@rf_idCase)--102567360

	
declare @query varchar(max) = 'SELECT c.id rf_idCase,ra.Account,ra.DateRegister,datename(mm,c.DateEnd)+'' ''+cast(ra.ReportYear as nvarchar) [ReportPeriod],ra.AmountPayment AmPayAccount,c.idRecordCase AS Случай,dmo.NAM_MOK AS Направление,v2.name AS Профиль,CASE WHEN c.IsChildTariff = 0 THEN ''Взрослый'' WHEN c.IsChildTariff = 1 THEN ''Детский'' ELSE ''Не указан'' END AS Тариф ,
			c.NumberHistoryCase AS НомерКарты,c.DateBegin AS Начат,c.DateEnd AS Окончен,c.AmountPayment AS Выставлено,v9.Name AS Результат,v4.Name AS СпециальностьМедРаботника,UPPER(rp.Fam + '' '' + rp.Im + '' '' + ISNULL(rp.Ot, '''')) AS Пациент,
			v5.Name AS Пол,rp.BirthDay AS ДатаРождения,c.age AS Возраст,rpd.SNILS AS СНИЛС/*пациента*/,ltrim(isnull(rcp.SeriaPolis,'''')+'' ''+ rcp.NumberPolis) AS НомерПолиса,f.DateRegistration AS ДатаРегистрации,
			f.CodeM +'' — ''+mo2.NameS AS МО,rcp.[AttachLPU] +'' — ''+mo1.NameS AS МОПрикрепления,case when RTRIM(rcp.[NewBorn])=0 then ''Нет'' when RTRIM(rcp.[NewBorn])=1 then ''Да'' end  as NewBornWord,
			c.rf_idDoctor СНИЛСВрача,rp.TEL PacTel,dis.[DateDefine] ДатаИнвалидности,

			case when rcp.IsNew=0 then ''Первичная'' when rcp.IsNew=1 then ''Повторная'' end PR_NOV, --Признак исправленной записи
			psmo.ENP ENP,
			v16.Code TypeDisp, --Тип диспансеризации
			v16.Name TypeDispName,
			case when c.IsFirstDS=1 then ''Да'' when c.IsFirstDS=0 then ''Нет'' else ''Не указано'' end DS1_PR, --Выявлен впервые
			case when c.IsNeedDisp=1 then ''Состоит на ДН'' when c.IsNeedDisp=2 then ''Взят на ДН'' when c.IsNeedDisp=2 then ''Не подлежит ДН'' end PR_D_N, --Диспансерное наблюдение
			rtrim(mes.MES)+'' — ''+ mu.[MUName] CODE_MES1, --Код ЗС
			case when di.IsMobileTeam=0 then ''Нет'' when di.IsMobileTeam=1 then ''Да'' end VBR,--Признак ММБ
			case when di.TypeFailure=0 then ''Нет'' when di.TypeFailure=1 then ''Да'' end P_OTK, --Признак отказа
			case when di.IsOnko=0 then ''Нет'' when di.IsOnko=1 then ''Да'' end DS_ONK, --Подозрение на ЗНО
			c.Comments COMENTSL, --Комментарий к случаю
		[SMOKOD] + '' — '' + [NAM_SMOK] SMO
/*,m.[MU]
,s.[MUName]
,cast(m.[Quantity] as int) [Quantity]
,[Price]
,DateHelpBegin
,DateHelpEnd  
,m.[rf_idDoctor]
,cast(m.[rf_idV002] as varchar(4)) +'' — ''+ v002.[Name] AS profilMU
,v4.[Name] AS spec
,case when c.rf_idMO<>m.rf_idMO then m.rf_idMO+'' — ''+mo.NAMES end MOMU
,case when m.IsNeedUsl=0 then ''Нет'' when m.IsNeedUsl=1 then ''Да'' when m.IsNeedUsl=2 then ''По показаниям'' end IsNeedUsl
*/
/*
,diag.[typeDiag] DiagType
,rtrim(diag.[DiagnosisCode]) [DiagnosisCode]
,mkb1.[Diagnosis]
,case when diag.IsFirstDS=1 then ''Да'' else ''Нет'' end IsFirstDS
,case when diag.IsNeedDisp=1 then ''Состоит'' when diag.IsNeedDisp=2 then ''Взят'' when diag.IsNeedDisp=3 then ''Не подлежит'' end ЯЯЯIsNeedDisp
*/			 
	FROM    dbo.t_Case AS c	
	inner join t_DispInfo di on di.rf_idCase=c.id
	INNER JOIN dbo.t_RecordCasePatient AS rcp ON c.rf_idRecordCasePatient = rcp.id
	inner join dbo.t_PatientSMO psmo on psmo.rf_idRecordCasePatient=rcp.id
	INNER JOIN dbo.t_RegistersAccounts AS ra ON rcp.rf_idRegistersAccounts = ra.id
	INNER JOIN dbo.t_File AS f ON ra.rf_idFiles = f.id
	INNER JOIN dbo.t_RegisterPatient AS rp ON rp.rf_idRecordCase = rcp.id
	INNER JOIN OMS_NSI.dbo.sprV002 AS v2 ON c.rf_idV002 = v2.Id
	INNER JOIN OMS_NSI.dbo.sprV005 AS v5 ON rp.rf_idV005 = v5.Id
	INNER JOIN dbo.vw_sprT001_Report AS mo1 ON rcp.[AttachLPU] = f.CodeM
	INNER JOIN dbo.vw_sprT001_Report AS mo2 ON mo2.CodeM = f.CodeM
	inner join [oms_nsi].[dbo].[sprV016TFOMS] v16 on v16.Code=di.TypeDisp
	inner join [dbo].[t_CompletedCase] cc on cc.rf_idRecordCasePatient=rcp.id
	INNER JOIN [OMS_NSI].[dbo].[sprSMO] AS SMO ON ra.[rf_idSMO] = SMO.[SMOKOD]
	left JOIN [dbo].[t_Disability] dis ON dis.[rf_idRecordCasePatient]=rcp.id
	LEFT JOIN OMS_NSI.dbo.sprMO AS dmo ON dmo.mcod = c.rf_idDirectMO
	LEFT JOIN OMS_NSI.dbo.sprV009 AS v9 ON c.rf_idV009 = v9.Id
	LEFT JOIN dbo.t_RegisterPatientDocument AS rpd ON rpd.rf_idRegisterPatient = rp.id
	LEFT JOIN [dbo].[vw_sprMedicalSpeciality] v4 on c.rf_idV004=v4.id AND c.DateEnd>=v4.DateBeg AND c.DateEnd<v4.DateEnd
	left join dbo.t_MES mes on mes.rf_idCase=c.id
	LEFT JOIN dbo.vw_sprMUAll mu on mu.[MU]=mes.[MES]

	/*
	inner join [dbo].[t_Meduslugi] m on m.rf_idCase=c.id
	inner join [OMS_NSI].[dbo].[sprV002] v002 on v002.id=m.[rf_idV002]
	inner JOIN [dbo].[vw_sprMedicalSpeciality] v4m on m.rf_idV004=v4m.id AND c.DateEnd>=v4m.DateBeg AND c.DateEnd<v4m.DateEnd
	inner JOIN [dbo].[vw_sprT001] mo on m.rf_idMO=mo.CodeM
	LEFT JOIN [dbo].[vw_sprMU] s on s.[MU]=m.[MU]*/
	/*
	inner JOIN [dbo].[vw_DS1DS2] diag on diag.rf_idCase = c.id
	inner join [OMS_nsi].[dbo].[sprMKB] mkb1 on mkb1.[DiagnosisCode]=diag.[DiagnosisCode]
	*/
	where c.id in ('

	set @query =  @query +  @rf_idCase + ')
	order by c.DateEnd,c.id'

print (@query)
EXEC (@query)  


GO

GRANT EXECUTE ON  [dbo].[usp_selectCases19Type2ForReport] TO [AccountsOMS]
GRANT EXECUTE ON  [dbo].[usp_selectCases19Type2ForReport] TO [db_AccountOMS]
GO
