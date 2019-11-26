SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[usp_selectCases19Type2]
@p_AccountCode INT = NULL ,
@p_StartDate VARCHAR(10) = NULL ,
@p_EndDate VARCHAR(20) = NULL ,
@p_StartRepPeriod varchar(6)=null,
@p_EndRepPeriod varchar(6)=null,
@p_FilialCode INT = -1 ,
@p_LPUCode INT = -1 ,
--@p_LPUManualEnteredCode INT = -1 ,--имеет более высокий приоритет чем данные в переменной @p_LPUCode
@p_TypeCheckup char='0', -- 0 - без учета КОСКУ, 4 - все случаи с учетом КОСКУ (есть или нет - неважно), 1,2,3 - только случаи с определенным типом
@p_isDispObsFilterOn bit = 0, --есть ли фильтр по Д-наблюдению, в зависимости от этого используются разные запросы
@p_AdditionalFilter NVARCHAR(max) = '',
@Query NVARCHAR(max)=null
    
AS 
IF ( @p_AccountCode IS NOT NULL ) 
	BEGIN
	CREATE TABLE #t_tmpAccs ( id INT, rf_idFiles INT, rf_idSMO char(5) )

	INSERT  INTO #t_tmpAccs
		SELECT  ra.id,ra.rf_idFiles, ra.rf_idSMO
		FROM    dbo.t_RegistersAccounts ra
		WHERE   ra.[rf_idFiles] = @p_AccountCode

	SELECT  c.id AS CaseId,c.idRecordCase AS Случай,dmo.NAM_MOK AS Направление,v2.name AS Профиль,CASE WHEN c.IsChildTariff = 0 THEN 'Взрослый' WHEN c.IsChildTariff = 1 THEN 'Детский' ELSE 'Не указан' END AS Тариф ,
			c.NumberHistoryCase AS НомерКарты,c.DateBegin AS Начат,c.DateEnd AS Окончен,c.AmountPayment AS Выставлено,v9.Name AS Результат,v4.Name AS СпециальностьМедРаботника,UPPER(rp.Fam + ' ' + rp.Im + ' ' + ISNULL(rp.Ot, '')) AS Пациент,
			v5.Name AS Пол,rp.BirthDay AS ДатаРождения,c.age AS Возраст,rpd.SNILS AS СНИЛС/*пациента*/,/*rcp.SeriaPolis AS СерияПолиса,*/ltrim(isnull(rcp.SeriaPolis,'')+' '+ rcp.NumberPolis) AS НомерПолиса,f.DateRegistration AS ДатаРегистрации,f.CodeM AS CodeMO,
			mo2.NameS AS МО,rtrim(d.DS1) +' — '+ mkb.Diagnosis AS Диагноз,rcp.[AttachLPU] AS МОПрикрепления,case when RTRIM(rcp.[NewBorn])=0 then 'Нет' when RTRIM(rcp.[NewBorn])=1 then 'Да' end  as NewBornWord,
			c.rf_idDoctor СНИЛСВрача,rp.TEL PacTel,dis.[DateDefine] ДатаИнвалидности,

			case when rcp.IsNew=0 then 'Первичная' when rcp.IsNew=1 then 'Повторная' end PR_NOV, --Признак исправленной записи
			psmo.ENP ENP,
			v16.Code TypeDisp, --Тип диспансеризации
			v16.Name TypeDispName,
			case when c.IsFirstDS=1 then 'Да' when c.IsFirstDS=0 then 'Нет' else 'Не указано' end DS1_PR, --Выявлен впервые
			case when c.IsNeedDisp=1 then 'Состоит на ДН' when c.IsNeedDisp=2 then 'Взят на ДН' when c.IsNeedDisp=2 then 'Не подлежит ДН' end PR_D_N, --Диспансерное наблюдение
			rtrim(mes.MES)+' — '+ mu.[MUName] CODE_MES1, --Код ЗС
			case when di.IsMobileTeam=0 then 'Нет' when di.IsMobileTeam=1 then 'Да' end VBR,--Признак ММБ
			case when di.TypeFailure=0 then 'Нет' when di.TypeFailure=1 then 'Да' end P_OTK, --Признак отказа
			case when di.IsOnko=0 then 'Нет' when di.IsOnko=1 then 'Да' end DS_ONK, --Подозрение на ЗНО
			c.Comments COMENTSL, --Комментарий к случаю
			cc.id CompletedCaseID,
			[SMOKOD] + ' - ' + [NAM_SMOK] SMO
	FROM    dbo.t_Case AS c	
	inner join t_DispInfo di on di.rf_idCase=c.id
	INNER JOIN dbo.t_RecordCasePatient AS rcp ON c.rf_idRecordCasePatient = rcp.id
	inner join dbo.t_PatientSMO psmo on psmo.rf_idRecordCasePatient=rcp.id
	INNER JOIN dbo.#t_tmpAccs AS ra ON rcp.rf_idRegistersAccounts = ra.id
	INNER JOIN dbo.t_File AS f ON ra.rf_idFiles = f.id
	INNER JOIN OMS_NSI.dbo.tMO AS mo1 ON f.CodeM = LEFT(mo1.tfomsCode,6)
	INNER JOIN dbo.t_RegisterPatient AS rp ON rp.rf_idRecordCase = rcp.id
	INNER JOIN OMS_NSI.dbo.sprV002 AS v2 ON c.rf_idV002 = v2.Id and c.DateEnd between v2.DateBeg and v2.DateEnd
	INNER JOIN OMS_NSI.dbo.sprV005 AS v5 ON rp.rf_idV005 = v5.Id
	INNER JOIN dbo.vw_Diagnosis AS d ON c.id = d.rf_idCase
	INNER JOIN OMS_NSI.dbo.sprMKB AS mkb ON mkb.DiagnosisCode = d.DS1
	INNER JOIN dbo.vw_sprT001_Report AS mo2 ON mo2.CodeM = f.CodeM
	inner join [oms_nsi].[dbo].[sprV016TFOMS] v16 on v16.Code=di.TypeDisp
	inner join [dbo].[t_CompletedCase] cc on cc.rf_idRecordCasePatient=rcp.id
	INNER JOIN [OMS_NSI].[dbo].[sprSMO] AS SMO ON ra.[rf_idSMO] = SMO.[SMOKOD]

	left JOIN [dbo].[t_Disability] dis ON dis.[rf_idRecordCasePatient]=rcp.id
	LEFT JOIN OMS_NSI.dbo.sprMO AS dmo ON dmo.mcod = c.rf_idDirectMO
	LEFT JOIN OMS_NSI.dbo.sprV009 AS v9 ON c.rf_idV009 = v9.Id and c.DateEnd between v9.DateBeg and v9.DateEnd
	LEFT JOIN dbo.t_RegisterPatientDocument AS rpd ON rpd.rf_idRegisterPatient = rp.id
	LEFT JOIN [dbo].[vw_sprMedicalSpeciality] v4 on c.rf_idV004=v4.id AND c.DateEnd>=v4.DateBeg AND c.DateEnd<v4.DateEnd
	left join dbo.t_MES mes on mes.rf_idCase=c.id
	LEFT JOIN dbo.vw_sprMUAll mu on mu.[MU]=mes.[MES]
	where f.TypeFile='F' --второй тип счетов
	ORDER BY c.idRecordCase
	END

---------------------------------------------------------------------------------
ELSE IF ( @p_AccountCode IS NULL) 
BEGIN
    create TABLE #lpu(CodeM CHAR(6),MOName VARCHAR(250), FilialId TINYINT,filialName VARCHAR(50))
                    
SELECT @p_FilialCode =CASE WHEN @p_FilialCode = -1 THEN NULL ELSE (SELECT filialCode FROM dbo.vw_sprFilial WHERE FilialId=@p_FilialCode) end
	  ,@p_LPUCode =CASE WHEN @p_LPUCode=-1 THEN NULL ELSE @p_LPUCode END
      ,@p_EndDate=@p_EndDate+' 23:59:59'		
		  
   
	INSERT #LPU
	SELECT CodeM, [NAMES], filialCode,filialName FROM dbo.vw_sprT001 
	WHERE CodeM=ISNULL(@p_LPUCode,codeM) AND filialCode=ISNULL(@p_FilialCode,filialCode)

	CREATE TABLE #t (
	[CaseId] [bigint] NOT NULL,
	[Случай] [bigint] NOT NULL,
	[Выставлено] [decimal](15, 2) NOT NULL,
	[IsChildTariff] [bit] null,
	[НомерКарты] [nvarchar](50) NOT NULL,
	[Начат] [date] NOT NULL,
	[Окончен] [date] NOT NULL,
	[ДатаРождения] [date] NULL,
	[Возраст] [smallint] NULL,
	[SeriaPolis] [varchar](10) NULL,
	[NumberPolis] [varchar](20) NULL,
	[ДатаРегистрации] [datetime] NOT NULL,
	[CodeMO] [varchar](6) NULL,
	[КодДиагноза] [char](10) NULL,
	[accountnumber] [varchar](15) NULL,
	[accountdate] [date] NOT NULL,
	[attachMO] [char](6) NULL,
	[СНИЛСВрача] [varchar](25) NULL,
	[NewBorn] [varchar](9) NULL,
	[PacTel] [varchar](10) NULL,
	[rf_idV005] [tinyint] NOT NULL, --Пол
	[rf_idSMO] [char](5) NULL,
	[rf_idV009] [smallint] NOT NULL, --результат
	[rpid] [int] NOT NULL,
	[rf_idV004] [int] NOT NULL, --специальность
	[IsNew] [bit] NULL, --Признак исправленной записи
	[COMENTSL] [nvarchar](250) null,
	[RCPID] [int] not null,
	[ReportYear] [smallint] null,
	[fam] [nvarchar](40) NULL,
	[im] [nvarchar](40) NULL,
	[ot] [nvarchar](40) NULL
) 
 
if (@p_TypeCheckup in ('0','4'))
begin
	if (@p_isDispObsFilterOn = 0)
	begin
		SET @Query ='insert into #t 
							([CaseId],[Случай],[Выставлено],[IsChildTariff],[НомерКарты],[Начат],[Окончен],[ДатаРождения],[Возраст],[SeriaPolis],[NumberPolis],[ДатаРегистрации],[CodeMO]
							,[accountnumber],[accountdate],[attachMO],[СНИЛСВрача],[NewBorn],[PacTel],[rf_idV005],[rf_idSMO],[rf_idV009],[rpid],[rf_idV004],
					
							[IsNew],[COMENTSL],[RCPID],[ReportYear],[fam],[im],[ot])
					(
					SELECT  c.id,c.idRecordCase,c.AmountPayment
							,c.IsChildTariff,c.NumberHistoryCase,c.DateBegin,c.DateEnd
							,rp.BirthDay,c.age,rcp.SeriaPolis,rcp.NumberPolis,f.DateRegistration,f.CodeM,ra.Account,ra.[DateRegister]
							,rcp.[AttachLPU],c.rf_idDoctor,rcp.[NewBorn],rp.TEL
							,rp.rf_idV005,ra.[rf_idSMO],c.rf_idV009,rp.id rpid,c.rf_idV004

							,rcp.IsNew,c.Comments, rcp.id rcpid, ra.ReportYear,rp.Fam,rp.Im,rp.Ot
							FROM dbo.t_File f 
							INNER JOIN #LPU AS mo ON f.CodeM = mo.CodeM	
							INNER JOIN dbo.t_RegistersAccounts ra ON f.id=ra.rf_idFiles AND ra.PrefixNumberRegister<>''34''
							INNER JOIN dbo.t_RecordCasePatient AS rcp ON ra.id=rcp.rf_idRegistersAccounts
							INNER JOIN dbo.t_Case c ON rcp.id=c.rf_idRecordCasePatient AND c.DateEnd<'''+@p_EndDate+ '''
							INNER JOIN dbo.t_RegisterPatient AS rp ON rp.rf_idRecordCase=rcp.id
							left join dbo.t_CasesFilters_MU_Type2 fmu on fmu.rf_idCase=c.id
																
							WHERE  ra.ReportYearMonth between '+@p_StartRepPeriod+' and '+@p_EndRepPeriod+' 
							and f.TypeFile=''F'' 
							and f.DateRegistration >= '''+@p_StartDate+ ''' AND f.DateRegistration <='''+ @p_EndDate+ ''' ' + @p_AdditionalFilter +' )'
	end
	else
	begin
		SET @Query ='insert into #t 
							([CaseId],[Случай],[Выставлено],[IsChildTariff],[НомерКарты],[Начат],[Окончен],[ДатаРождения],[Возраст],[SeriaPolis],[NumberPolis],[ДатаРегистрации],[CodeMO]
							,[accountnumber],[accountdate],[attachMO],[СНИЛСВрача],[NewBorn],[PacTel],[rf_idV005],[rf_idSMO],[rf_idV009],[rpid],[rf_idV004],
					
							[IsNew],[COMENTSL],[RCPID],[ReportYear],[fam],[im],[ot])
					(
					SELECT  c.id,c.idRecordCase,c.AmountPayment
							,c.IsChildTariff,c.NumberHistoryCase,c.DateBegin,c.DateEnd
							,rp.BirthDay,c.age,rcp.SeriaPolis,rcp.NumberPolis,f.DateRegistration,f.CodeM,ra.Account,ra.[DateRegister]
							,rcp.[AttachLPU],c.rf_idDoctor,rcp.[NewBorn],rp.TEL
							,rp.rf_idV005,ra.[rf_idSMO],c.rf_idV009,rp.id rpid,c.rf_idV004

							,rcp.IsNew,c.Comments, rcp.id rcpid, ra.ReportYear,rp.Fam,rp.Im,rp.Ot
							FROM dbo.t_File f 
							INNER JOIN #LPU AS mo ON f.CodeM = mo.CodeM	
							INNER JOIN dbo.t_RegistersAccounts ra ON f.id=ra.rf_idFiles AND ra.PrefixNumberRegister<>''34''
							INNER JOIN dbo.t_RecordCasePatient AS rcp ON ra.id=rcp.rf_idRegistersAccounts
							INNER JOIN dbo.t_Case c ON rcp.id=c.rf_idRecordCasePatient AND c.DateEnd<'''+@p_EndDate+ '''
							INNER JOIN dbo.t_RegisterPatient AS rp ON rp.rf_idRecordCase=rcp.id
							left join dbo.t_CasesFilters_MU_Type2 fmu on fmu.rf_idCase=c.id
							left join /*dbo.t_CasesFilters_DS_Type2*/[dbo].[vw_DS1DS2] fds on fds.rf_idCase=c.id
																
							WHERE  ra.ReportYearMonth between '+@p_StartRepPeriod+' and '+@p_EndRepPeriod+' 
							and f.TypeFile=''F'' 
							and f.DateRegistration >= '''+@p_StartDate+ ''' AND f.DateRegistration <='''+ @p_EndDate+ ''' ' + @p_AdditionalFilter +' )'
	end
end
else if (@p_TypeCheckup in ('1','2','3'))
begin
	if (@p_isDispObsFilterOn = 0)
	begin
		SET @Query ='insert into #t 
							([CaseId],[Случай],[Выставлено],[IsChildTariff],[НомерКарты],[Начат],[Окончен],[ДатаРождения],[Возраст],[SeriaPolis],[NumberPolis],[ДатаРегистрации],[CodeMO]
							,[accountnumber],[accountdate],[attachMO],[СНИЛСВрача],[NewBorn],[PacTel],[rf_idV005],[rf_idSMO],[rf_idV009],[rpid],[rf_idV004],
					
							[IsNew],[COMENTSL],[RCPID],[ReportYear],[fam],[im],[ot])
					(
					SELECT  c.id,c.idRecordCase,c.AmountPayment
							,c.IsChildTariff,c.NumberHistoryCase,c.DateBegin,c.DateEnd
							,rp.BirthDay,c.age,rcp.SeriaPolis,rcp.NumberPolis,f.DateRegistration,f.CodeM,ra.Account,ra.[DateRegister]
							,rcp.[AttachLPU],c.rf_idDoctor,rcp.[NewBorn],rp.TEL
							,rp.rf_idV005,ra.[rf_idSMO],c.rf_idV009,rp.id rpid,c.rf_idV004

							,rcp.IsNew,c.Comments, rcp.id rcpid, ra.ReportYear,rp.Fam,rp.Im,rp.Ot
							FROM dbo.t_File f 
							INNER JOIN #LPU AS mo ON f.CodeM = mo.CodeM	
							INNER JOIN dbo.t_RegistersAccounts ra ON f.id=ra.rf_idFiles AND ra.PrefixNumberRegister<>''34''
							INNER JOIN dbo.t_RecordCasePatient AS rcp ON ra.id=rcp.rf_idRegistersAccounts
							INNER JOIN dbo.t_Case c ON rcp.id=c.rf_idRecordCasePatient AND c.DateEnd<'''+@p_EndDate+ '''
							INNER JOIN dbo.t_RegisterPatient AS rp ON rp.rf_idRecordCase=rcp.id
							inner join [dbo].[t_PaymentAcceptedCase2] pac2 on pac2.rf_idCase=c.id and pac2.TypeCheckup='''+@p_TypeCheckup+'''
							left join dbo.t_CasesFilters_MU_Type2 fmu on fmu.rf_idCase=c.id
																
							WHERE  ra.ReportYearMonth between '+@p_StartRepPeriod+' and '+@p_EndRepPeriod+' 
							and f.TypeFile=''F'' 
							and f.DateRegistration >= '''+@p_StartDate+ ''' AND f.DateRegistration <='''+ @p_EndDate+ ''' ' + @p_AdditionalFilter +'  
							group by c.id,c.idRecordCase,c.AmountPayment
							,c.IsChildTariff,c.NumberHistoryCase,c.DateBegin,c.DateEnd
							,rp.BirthDay,c.age,rcp.SeriaPolis,rcp.NumberPolis,f.DateRegistration,f.CodeM,ra.Account,ra.[DateRegister]
							,rcp.[AttachLPU],c.rf_idDoctor,rcp.[NewBorn],rp.TEL
							,rp.rf_idV005,ra.[rf_idSMO],c.rf_idV009,rp.id,c.rf_idV004,rcp.IsNew,c.Comments, rcp.id, ra.ReportYear,rp.Fam,rp.Im,rp.Ot)'
	end
	else
		begin
		SET @Query ='insert into #t 
							([CaseId],[Случай],[Выставлено],[IsChildTariff],[НомерКарты],[Начат],[Окончен],[ДатаРождения],[Возраст],[SeriaPolis],[NumberPolis],[ДатаРегистрации],[CodeMO]
							,[accountnumber],[accountdate],[attachMO],[СНИЛСВрача],[NewBorn],[PacTel],[rf_idV005],[rf_idSMO],[rf_idV009],[rpid],[rf_idV004],
					
							[IsNew],[COMENTSL],[RCPID],[ReportYear],[fam],[im],[ot])
					(
					SELECT  c.id,c.idRecordCase,c.AmountPayment
							,c.IsChildTariff,c.NumberHistoryCase,c.DateBegin,c.DateEnd
							,rp.BirthDay,c.age,rcp.SeriaPolis,rcp.NumberPolis,f.DateRegistration,f.CodeM,ra.Account,ra.[DateRegister]
							,rcp.[AttachLPU],c.rf_idDoctor,rcp.[NewBorn],rp.TEL
							,rp.rf_idV005,ra.[rf_idSMO],c.rf_idV009,rp.id rpid,c.rf_idV004

							,rcp.IsNew,c.Comments, rcp.id rcpid, ra.ReportYear,rp.Fam,rp.Im,rp.Ot
							FROM dbo.t_File f 
							INNER JOIN #LPU AS mo ON f.CodeM = mo.CodeM	
							INNER JOIN dbo.t_RegistersAccounts ra ON f.id=ra.rf_idFiles AND ra.PrefixNumberRegister<>''34''
							INNER JOIN dbo.t_RecordCasePatient AS rcp ON ra.id=rcp.rf_idRegistersAccounts
							INNER JOIN dbo.t_Case c ON rcp.id=c.rf_idRecordCasePatient AND c.DateEnd<'''+@p_EndDate+ '''
							INNER JOIN dbo.t_RegisterPatient AS rp ON rp.rf_idRecordCase=rcp.id
							inner join [dbo].[t_PaymentAcceptedCase2] pac2 on pac2.rf_idCase=c.id and pac2.TypeCheckup='''+@p_TypeCheckup+'''
							left join dbo.t_CasesFilters_MU_Type2 fmu on fmu.rf_idCase=c.id
							left join /*dbo.t_CasesFilters_DS_Type2*/[dbo].[vw_DS1DS2] fds on fds.rf_idCase=c.id
																
							WHERE  ra.ReportYearMonth between '+@p_StartRepPeriod+' and '+@p_EndRepPeriod+' 
							and f.TypeFile=''F'' 
							and f.DateRegistration >= '''+@p_StartDate+ ''' AND f.DateRegistration <='''+ @p_EndDate+ ''' ' + @p_AdditionalFilter +'  
							group by c.id,c.idRecordCase,c.AmountPayment
							,c.IsChildTariff,c.NumberHistoryCase,c.DateBegin,c.DateEnd
							,rp.BirthDay,c.age,rcp.SeriaPolis,rcp.NumberPolis,f.DateRegistration,f.CodeM,ra.Account,ra.[DateRegister]
							,rcp.[AttachLPU],c.rf_idDoctor,rcp.[NewBorn],rp.TEL
							,rp.rf_idV005,ra.[rf_idSMO],c.rf_idV009,rp.id,c.rf_idV004,rcp.IsNew,c.Comments, rcp.id, ra.ReportYear,rp.Fam,rp.Im,rp.Ot)'
	end
end
print (@Query)
EXEC (@Query)  
 
create table #kosku (CaseId bigint null, InfoMEK bit null, InfoMEE nvarchar(200) null, InfoEKMP nvarchar(200) null, deducMEK decimal (15,2) null, deducMEE decimal (15,2) null, deducEKMP decimal (15,2) null)

if(@p_TypeCheckup in ('1','2','3','4'))
begin
	insert into #kosku
	select	 c.CaseId
			,max(case when pac2.TypeCheckup=1 then 1 else 0 end) InfoMEK
			,(SELECT cast(pac2_.[DocumentNumber] as varchar) + ', ' + cast([DocumentDate] as varchar) + ', ' + cast([AmountDeduction] as varchar) +', '+ isnull(rtrim(r.Reason),'') +'; ' FROM [dbo].[t_PaymentAcceptedCase2] pac2_ left join [dbo].[vw_PaymnetMekMeeEkmp_ReasonOneRow] r on pac2_.rf_idCase=r.[rf_idCase] and pac2_.TypeCheckup=r.TypeCheckup and pac2_.idAkt=r.idAkt WHERE pac2_.rf_idCase = c.CaseId and pac2_.TypeCheckup=2 FOR XML PATH('')) InfoMEE 
			,(SELECT cast(pac2_.[DocumentNumber] as varchar) + ', ' + cast([DocumentDate] as varchar) + ', ' + cast([AmountDeduction] as varchar) +', '+ isnull(rtrim(r.Reason),'') +'; ' FROM [dbo].[t_PaymentAcceptedCase2] pac2_ left join [dbo].[vw_PaymnetMekMeeEkmp_ReasonOneRow] r on pac2_.rf_idCase=r.[rf_idCase] and pac2_.TypeCheckup=r.TypeCheckup and pac2_.idAkt=r.idAkt WHERE pac2_.rf_idCase = c.CaseId and pac2_.TypeCheckup=3 FOR XML PATH('')) InfoEKMP
			,sum(case when pac2.TypeCheckup=1 then pac2.[AmountDeduction] end) deducMEK
			,sum(case when pac2.TypeCheckup=2 then pac2.[AmountDeduction] end) deducMEE
			,sum(case when pac2.TypeCheckup=3 then pac2.[AmountDeduction] end) deducEKMP
	from #t c
	inner join [dbo].[t_PaymentAcceptedCase2] pac2 on pac2.rf_idCase=c.CaseId
	group by c.CaseId
end
else if (@p_TypeCheckup='0')
begin insert into #kosku select 0 CaseId, 0 InfoMEK, '' InfoMEE, '' InfoEMP, 0 deducMEK, 0 deducMEE, 0 deducEKMP end

select c.*,v9.Name Результат,v4.Name СпециальностьМедРаботника,v5.Name Пол
       ,rpd.SNILS СНИЛС,mo.CodeM+' — '+mo.MOName МО
	   ,[SMOKOD] + ' - ' + [NAM_SMOK] SMO--,dmo.NAM_MOK Направление
	   ,case when rtrim(c.NewBorn)=1 then 'Да' else 'Нет' end NewBornWord
	   ,v16.Code TypeDisp, v16.Name TypeDispName, rtrim(mes.MES)+' — '+ mu.[MUName] CODE_MES1
	   ,case when di.IsMobileTeam=0 then 'Нет' when di.IsMobileTeam=1 then 'Да' end VBR/*Признак ММБ*/
	   ,case when di.TypeFailure=0 then 'Нет' when di.TypeFailure=1 then 'Да' end P_OTK --Признак отказа
	   ,case when di.IsOnko=0 then 'Нет' when di.IsOnko=1 then 'Да' end DS_ONK --Подозрение на ЗНО
	   ,cc.id CompletedCaseID,psmo.ENP,dis.[DateDefine] [ДатаИнвалидности], UPPER(c.Fam + ' ' + c.Im + ' ' + ISNULL(c.Ot,'')) [Пациент]
	   ,CAST(CASE WHEN c.IsChildTariff = 0 THEN 'Взрослый' WHEN c.IsChildTariff = 1 THEN 'Детский' ELSE 'Не указан' END AS VARCHAR(20)) [Тариф]
	   ,ltrim(isnull(c.SeriaPolis,'') + ' '+c.NumberPolis) [НомерПолиса],case when c.IsNew=0 then 'Первичная' when c.IsNew=1 then 'Повторная' end PR_NOV
	   ,datename(mm,c.[Окончен]) [ReportMonth],InfoMEK,InfoMEE,InfoEKMP,deducMEK,deducMEE,deducEKMP
from #t c
INNER JOIN OMS_NSI.dbo.sprV005 AS v5 ON c.rf_idV005 = v5.Id
INNER JOIN [OMS_NSI].[dbo].[sprSMO] AS SMO ON c.[rf_idSMO] = SMO.[SMOKOD]
INNER JOIN #LPU AS mo on c.[CodeMO]=mo.CodeM
inner join t_DispInfo di on di.rf_idCase=c.CaseId
inner join [oms_nsi].[dbo].[sprV016TFOMS] v16 on v16.Code=di.TypeDisp
inner join [dbo].[t_CompletedCase] cc on cc.rf_idRecordCasePatient=c.RCPID
inner join dbo.t_PatientSMO psmo on psmo.rf_idRecordCasePatient=c.RCPID

left JOIN [dbo].[t_Disability] dis ON dis.[rf_idRecordCasePatient]=c.RCPID	        
LEFT JOIN OMS_NSI.dbo.sprV009 AS v9 ON c.rf_idV009 = v9.Id
LEFT JOIN dbo.t_RegisterPatientDocument AS rpd ON rpd.rf_idRegisterPatient = c.rpid
LEFT JOIN [dbo].[vw_sprMedicalSpeciality] v4 on c.rf_idV004=v4.id AND c.[Окончен]>=v4.DateBeg AND c.[Окончен]<v4.DateEnd
left join dbo.t_MES mes on mes.rf_idCase=c.CaseId
LEFT JOIN dbo.vw_sprMUAll mu on mu.[MU]=mes.[MES]
left join #kosku k on k.CaseId=c.CaseId
order by c.[Окончен]


END 
GO

GRANT EXECUTE ON  [dbo].[usp_selectCases19Type2] TO [AccountsOMS]
GRANT EXECUTE ON  [dbo].[usp_selectCases19Type2] TO [db_AccountOMS]
GO
