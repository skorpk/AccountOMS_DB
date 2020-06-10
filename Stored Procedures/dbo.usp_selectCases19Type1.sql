SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[usp_selectCases19Type1]
@p_AccountCode INT = NULL ,
@p_StartDate VARCHAR(10) = NULL ,
@p_EndDate VARCHAR(20) = NULL ,
@p_StartRepPeriod varchar(6)=null,
@p_EndRepPeriod varchar(6)=null,
@p_FilialCode INT = -1 ,
@p_LPUCode INT = -1 ,
@p_TypeCheckup char='0', -- 0 - без учета КОСКУ, 4 - все случаи с учетом КОСКУ (есть или нет - неважно), 1,2,3 - только случаи с определенным типом
--@p_isDispObsFilterOn bit = 0, --есть ли фильтр по Д-наблюдению, в зависимости от этого используются разные запросы
@p_Premature bit = 0, --VNOV_M, наличие новорожденных
@p_Diag nvarchar(20) = '', --фильтр на диагнозы
@p_PainSyndrome bit = 0, --болевой синдром, DS3 like 'R52%'
@p_ZNODiag bit = 0, --диагностика ЗНО, B_DIAG
@p_ZNOContraindications bit = 0, --противопоказания ЗНО, B_PROT
@p_USL_TIP tinyint = 0, --тип онкологической услуги, N013
@p_AdditionalFilter NVARCHAR(max) = '',
@Query NVARCHAR(max)=null ,
@FilterJoin NVARCHAR(max) = ''
AS 

IF ( @p_AccountCode IS NOT NULL ) 
	BEGIN
	CREATE TABLE #t_tmpAccs ( id INT, rf_idFiles INT, rf_idSMO char(5) )

	INSERT  INTO #t_tmpAccs
		SELECT  ra.id,ra.rf_idFiles, ra.rf_idSMO
		FROM    dbo.t_RegistersAccounts ra
		WHERE   ra.[rf_idFiles] = @p_AccountCode

	SELECT  c.id AS CaseId,c.DateEnd AS Окончен,osl.id osl_id,c.idRecordCase AS Случай,c.rf_idDirectMO+' — '+dmo.NAM_MOK AS Направление,dd.DirectionDate, v2.name AS Профиль,CASE WHEN c.IsChildTariff = 0 THEN 'Взрослый' WHEN c.IsChildTariff = 1 THEN 'Детский' ELSE 'Не указан' END AS Тариф ,
			c.NumberHistoryCase AS НомерКарты,c.DateBegin AS Начат,c.AmountPayment AS Выставлено,cc.AmountPayment AS AmPayZSL,cast(v9.Id as varchar(4))+' — '+v9.Name AS Результат,v4.Name AS СпециальностьМедРаботника,UPPER(rp.Fam + ' ' + rp.Im + ' ' + ISNULL(rp.Ot, '')) AS Пациент,
			v5.Name AS Пол,rp.BirthDay AS ДатаРождения,c.age AS Возраст,rpd.SNILS AS СНИЛС/*пациента*/,ltrim(isnull(rcp.SeriaPolis,'')+' '+ rcp.NumberPolis) AS НомерПолиса,f.DateRegistration AS ДатаРегистрации,f.CodeM AS CodeMO,
			mo2.NameS AS МО,rtrim(d.DS1) +' — '+ mkb.Diagnosis AS Диагноз,rcp.[AttachLPU] AS МОПрикрепления,case when RTRIM(rcp.[NewBorn])>0 then 'Да' else 'Нет' end as NewBornWord,
			c.rf_idDoctor СНИЛСВрача,rp.TEL PacTel,dis.[DateDefine] ДатаИнвалидности,v12.Name [Исход],

			case when rcp.IsNew=0 then 'Первичная' when rcp.IsNew=1 then 'Повторная' end PR_NOV,/*Признак исправленной записи*/psmo.ENP ENP,rtrim(mes.MES)+' — '+ isnull(mu.[Name],'') CODE_MES1,/*Код ЗС*/c.Comments COMENTSL,/*Комментарий к случаю*/
			cc.id CompletedCaseID,[SMOKOD] + ' - ' + [NAM_SMOK] SMO,rcp.BirthWeight VNOV_D,/*вес ребенка, пациент - ребенок*/dis.[TypeOfGroup] INV /*группа инв*/,dis.rf_idReasonDisability REASON_INV/*Код причины инвалидности*/,dis.Diagnosis DS_INV/*код осн. диагноза*/,
			cc.HospitalizationPeriod KD_Z /*продолжительность госпитализации*/, c.MSE /*Направление на МСЭ*/,c.KD /*Продолжительность госпитализации*/,cast(c.C_ZAB as varchar)+ ' — '+ v27.[N_CZ] C_ZAB/*Характер основного заболевания*/,
			case when c.TypeTranslation=1 then 'Поступил самостоятельно' when c.TypeTranslation=2 then 'Доставлен СМП' when c.TypeTranslation=3 then 'Перевод из другой МО' when c.TypeTranslation=4 then 'Перевод внутри МО' end P_PER/*Признак поступления/перевода*/,
			case when onk.DS_ONK=0 then 'Нет' when onk.DS_ONK=1 then 'Да' end DS_ONK,case when c.[IsFirstDS]=1 then 'Да' else 'Нет' end DS1_PR,v6.Name AS УсловияОказания, v8.Name VIDPOM,
			v14.[NAME] FOR_POM,v10.Name AS СпособОплаты, v18.[Name] VID_HMP, v19.Name METOD_HMP,v20.name PROFIL_K, md.name_short PODR, mp.name_short LPU_1/*МОМП*/,v25.IDPC+' — '+v25.N_PC P_CEL,
			sop.GetDatePaper TAL_D,sop.DateHospitalization TAL_P, sop.NumberTicket TAL_NUM,UPPER(rpa.Fam + ' ' + rpa.Im + ' ' + ISNULL(rpa.Ot, '')) AS Сопровождающий,nv.[DateVizit] NEXT_VISIT,
			case when slk.[SL_K]=0 then 'Не применялся' when slk.[SL_K]=1 then 'Применялся' end SL_K/*признак КСЛП*/, c.IT_SL /*значение КСЛП*/,kiro.[ValueKiro], n18.REAS_NAME DS1_T, n2.[DS_St]+' ('+n2.[KOD_St]+')' STAD,
			n3.[KOD_T] ONK_T,n4.[KOD_N] ONK_N,n5.[KOD_M] ONK_M, case when osl.[IsMetastasis]=1 then 'Выявлены' else 'Не выявлены' end MTSTZ,osl.[TotalDose] SOD, osl.K_FR,osl.WEI,osl.HEI,osl.BSA
			,case when pov.DN=1 then 'Состоит' when pov.DN=2 then 'Взят' when pov.DN=4 then 'Снят по причине выздоровления' when pov.DN=6 then 'Снят по другим причинам' end PR_D_N --Диспансерное наблюдение
	FROM    dbo.t_Case AS c	 
	INNER JOIN dbo.t_RecordCasePatient AS rcp ON c.rf_idRecordCasePatient = rcp.id
	inner join dbo.t_PatientSMO psmo on psmo.rf_idRecordCasePatient=rcp.id
	INNER JOIN dbo.#t_tmpAccs AS ra ON rcp.rf_idRegistersAccounts = ra.id
	INNER JOIN dbo.t_File AS f ON ra.rf_idFiles = f.id
	INNER JOIN OMS_NSI.dbo.tMO AS mo1 ON f.CodeM = LEFT(mo1.tfomsCode,6)
	INNER JOIN dbo.t_RegisterPatient AS rp ON rp.rf_idRecordCase = rcp.id
	INNER JOIN OMS_NSI.dbo.sprV002 AS v2 ON c.rf_idV002 = v2.Id and c.DateEnd between v2.DateBeg and v2.DateEnd
	INNER JOIN OMS_NSI.dbo.sprV005 AS v5 ON rp.rf_idV005 = v5.Id
	INNER JOIN OMS_NSI.dbo.sprV006 AS v6 ON c.rf_idV006 = v6.Id and c.DateEnd between v6.DateBeg and v6.DateEnd
	INNER JOIN OMS_NSI.dbo.sprV008 AS v8 ON c.rf_idV008 = v8.Id and c.DateEnd between v8.DateBeg and v8.DateEnd
	INNER JOIN OMS_NSI.dbo.sprV014 AS v14 ON c.rf_idV014 = v14.[sprV014Id] and c.DateEnd between v14.DateBeg and v14.DateEnd
	INNER JOIN OMS_NSI.dbo.sprV010 AS v10 ON c.rf_idV010 = v10.Id and c.DateEnd between v10.DateBeg and v10.DateEnd
	INNER JOIN dbo.vw_Diagnosis AS d ON c.id = d.rf_idCase
	INNER JOIN OMS_NSI.dbo.sprMKB AS mkb ON mkb.DiagnosisCode = d.DS1
	INNER JOIN dbo.vw_sprT001_Report AS mo2 ON mo2.CodeM = f.CodeM
	inner join [dbo].[t_CompletedCase] cc on cc.rf_idRecordCasePatient=rcp.id
	INNER JOIN [OMS_NSI].[dbo].[sprSMO] AS SMO ON ra.[rf_idSMO] = SMO.[SMOKOD]
	INNER JOIN [dbo].[t_DS_ONK_REAB] onk on onk.[rf_idCase]=c.id

	left JOIN OMS_NSI.dbo.sprV018 v18 ON c.rf_idV018 = v18.Code and c.DateEnd between v18.DateBeg and v18.DateEnd
	left join OMS_NSI.dbo.sprV019 v19 on c.rf_idV019 = v19.Code and c.DateEnd between v19.DateBeg and v19.DateEnd
	left JOIN [dbo].[t_Disability] dis ON dis.[rf_idRecordCasePatient]=rcp.id
	LEFT JOIN OMS_NSI.dbo.sprMO AS dmo ON dmo.mcod = c.rf_idDirectMO
	LEFT JOIN OMS_NSI.dbo.sprV009 AS v9 ON c.rf_idV009 = v9.Id and c.DateEnd between v9.DateBeg and v9.DateEnd
	LEFT JOIN OMS_NSI.dbo.sprV012 AS v12 ON c.rf_idV012 = v12.Id and c.DateEnd between v12.DateBeg and v12.DateEnd
	LEFT JOIN dbo.t_RegisterPatientDocument AS rpd ON rpd.rf_idRegisterPatient = rp.id
	LEFT JOIN [dbo].[vw_sprMedicalSpeciality] v4 on c.rf_idV004=v4.id AND c.DateEnd>=v4.DateBeg AND c.DateEnd<v4.DateEnd
	left join dbo.t_MES mes on mes.rf_idCase=c.id
	LEFT JOIN oms_nsi.dbo.vw_sprMUAandCSG mu on mu.[code]=mes.[MES] and c.DateEnd between mu.[dateBeg] and mu.[dateEnd]
	/*LEFT JOIN dbo.vw_sprMUAll mu on mu.[MU]=mes.[MES]*/ 	
	left join [dbo].[t_DirectionDate] dd on dd.rf_idCase=c.id
	left join [dbo].[t_ProfileOfBed] pb on pb.[rf_idCase]=c.id
	left join OMS_NSI.dbo.sprV020 v20 on pb.rf_idV020 = v20.Code and c.DateEnd between v20.DateBeg and v20.DateEnd
	left join oms_nsi.dbo.tMODept md on md.code=c.[rf_idDepartmentMO] and md.[rf_MOId]=mo2.[MOId]
	left join oms_nsi.dbo.[tMOPlace] mp on mp.code=c.[rf_idSubMO] and mp.[rf_MOId]=mo2.[MOId]
	left join [dbo].[t_PurposeOfVisit] pov on pov.rf_idCase=c.id
	left join OMS_NSI.dbo.sprV025 v25 on pov.rf_idV025 = v25.IDPC and c.DateEnd between v25.DateBeg and v25.DateEnd
	left join [dbo].[t_SlipOfPaper] sop on sop.rf_idCase=c.id
	left join [dbo].[t_RegisterPatientAttendant] rpa on rpa.rf_idRegisterPatient=rp.id
	left join [dbo].[t_NextVisitDate] nv on nv.rf_idCase=c.id
	left JOIN [dbo].[t_SLK] slk on slk.[rf_idCase]=c.id
	left JOIN [dbo].[t_Kiro] kiro on kiro.rf_idCase=c.id
	left JOIN [dbo].[t_ONK_SL] osl on osl.[rf_idCase]=c.id
	left JOIN [oms_nsi].[dbo].[sprN018] n18 on n18.[ID_REAS]=osl.DS1_T and c.DateEnd between n18.DateBeg and n18.DateEnd
	left JOIN [oms_nsi].[dbo].[sprN002] n2 on n2.[ID_St]=osl.[rf_idN002] and c.DateEnd between n2.DateBeg and n2.DateEnd
	left JOIN [oms_nsi].[dbo].[sprN003] n3 on n3.[ID_T]=osl.[rf_idN003] and c.DateEnd between n3.DateBeg and n3.DateEnd
	left JOIN [oms_nsi].[dbo].[sprN004] n4 on n4.[ID_N]=osl.[rf_idN004] and c.DateEnd between n4.DateBeg and n4.DateEnd
	left JOIN [oms_nsi].[dbo].[sprN005] n5 on n5.[ID_M]=osl.[rf_idN005] and c.DateEnd between n5.DateBeg and n5.DateEnd
	left join [oms_nsi].[dbo].[sprV027] v27 on v27.IDCZ=c.C_ZAB and c.DateBegin between v27.DateBeg and v27.DateEnd

	where f.TypeFile='H' --первый тип счетов
	ORDER BY c.idRecordCase
	END

---------------------------------------------------------------------------------
ELSE IF ( @p_AccountCode IS NULL) 
BEGIN
    create TABLE #lpu(CodeM CHAR(6),MOName VARCHAR(250), FilialId TINYINT,filialName VARCHAR(50), MOId bigint) 
                    
SELECT @p_FilialCode =CASE WHEN @p_FilialCode = -1 THEN NULL ELSE (SELECT filialCode FROM dbo.vw_sprFilial WHERE FilialId=@p_FilialCode) end
	  ,@p_LPUCode =CASE WHEN @p_LPUCode=-1 THEN NULL ELSE @p_LPUCode END
      ,@p_EndDate=@p_EndDate+' 23:59:59'		
		  
   
	INSERT #LPU
	SELECT CodeM, [NAMES], filialCode,filialName, [MOId] FROM dbo.vw_sprT001 
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
	[rf_idV002] [smallint] NOT NULL, --профиль помощи
	[rpid] [int] NOT NULL,
	[rf_idV004] [int] NOT NULL, --специальность
	[IsNew] [bit] NULL, --Признак исправленной записи
	[COMENTSL] [nvarchar](250) null,
	[RCPID] [int] not null,
	[ReportYear] [smallint] null,
	[fam] [nvarchar](40) NULL,
	[im] [nvarchar](40) NULL,
	[ot] [nvarchar](40) NULL,
	[TypeTranslation] [tinyint] NULL,
	[BirthWeight] [smallint] null,
	[MSE] [tinyint] null,
	[C_ZABid] [tinyint] null,
	[KD] [smallint] null,
	[IsFirstDS] [tinyint] null,
	[rf_idV012] [smallint] null, --исход
	[rf_idV006] [tinyint] null, --условия оказания
	[rf_idV008] [smallint] null, --вид помощи
	[rf_idDirectMO] [char](6) null,
	[HopitalisationType] [tinyint] null,
	[rf_idV014] [tinyint] not null, --форма оказания МП
	[rf_idV010] [tinyint] not null, --способ оплаты
	[rf_idV018] [varchar](19) null, --вид ВМП
	[rf_idV019] [int] null, --метод ВМП
	[rf_idDepartmentMO] [int] null, --подразделение
	[rf_idSubMO] [varchar](8) null, --МОМП
	[IT_SL] [decimal](3, 2) null, --значение КСЛП
	[rf_idONK_SL] [int] null
) 
 
create table #trf_idCaseTOTALFilter ([rf_idCase] [bigint] NOT NULL)
create table #trf_idCaseTEMPFilter ([rf_idCase] [bigint] NOT NULL)


if (@p_Premature = 1)
begin
	delete from #trf_idCaseTOTALFilter
	
	insert into #trf_idCaseTOTALFilter
	select distinct c.id rf_idcase
	from dbo.t_File f 
	INNER JOIN #LPU AS mo ON f.CodeM = mo.CodeM	
	INNER JOIN dbo.t_RegistersAccounts ra ON f.id=ra.rf_idFiles AND ra.PrefixNumberRegister<>'34'
	INNER JOIN dbo.t_RecordCasePatient AS rcp ON ra.id=rcp.rf_idRegistersAccounts
	INNER JOIN dbo.t_Case c ON rcp.id=c.rf_idRecordCasePatient AND c.DateEnd<@p_EndDate
	INNER JOIN dbo.t_RegisterPatient AS rp ON rp.rf_idRecordCase=rcp.id
	inner join [AccountOMS].[dbo].[t_BirthWeight] bw on c.id=bw.rf_idCase
	WHERE  ra.ReportYearMonth between @p_StartRepPeriod and @p_EndRepPeriod
	and f.TypeFile='H'
	and f.DateRegistration >= @p_StartDate AND f.DateRegistration <=@p_EndDate

	set @FilterJoin = ' inner join #trf_idCaseTOTALFilter tf on tf.rf_idCase = c.id '
end

if (@p_Diag <> '')
begin
	create table #tD ([DiagnosisCode] [char](10) NOT NULL)
	if (CHARINDEX('%',@p_Diag)>0)
		begin
			insert into #tD SELECT DiagnosisCode FROM dbo.vw_sprMKB10 WHERE DiagnosisCode LIKE @p_Diag
		end
	else
		begin
			insert into #tD SELECT DiagnosisCode FROM dbo.vw_sprMKB10 WHERE DiagnosisCode=@p_Diag
		end

		delete from #trf_idCaseTEMPFilter
	
		insert into #trf_idCaseTEMPFilter
		select distinct c.id rf_idcase
		from dbo.t_File f 
		INNER JOIN #LPU AS mo ON f.CodeM = mo.CodeM	
		INNER JOIN dbo.t_RegistersAccounts ra ON f.id=ra.rf_idFiles AND ra.PrefixNumberRegister<>'34'
		INNER JOIN dbo.t_RecordCasePatient AS rcp ON ra.id=rcp.rf_idRegistersAccounts
		INNER JOIN dbo.t_Case c ON rcp.id=c.rf_idRecordCasePatient AND c.DateEnd<@p_EndDate
		INNER JOIN dbo.t_RegisterPatient AS rp ON rp.rf_idRecordCase=rcp.id
		inner join [AccountOMS].[dbo].[t_Diagnosis] d on c.id=d.rf_idCase
		INNER JOIN #tD dd ON d.DiagnosisCode=dd.DiagnosisCode
		WHERE  ra.ReportYearMonth between @p_StartRepPeriod and @p_EndRepPeriod
		and f.TypeFile='H'
		and f.DateRegistration >= @p_StartDate AND f.DateRegistration <=@p_EndDate

		if (@p_Premature = 1)
			begin
				delete t1 from #trf_idCaseTOTALFilter t1
				where not exists (select t2.rf_idcase from #trf_idCaseTEMPFilter t2 where t1.rf_idCase=t2.rf_idCase)
			end
		else
			begin
				delete from #trf_idCaseTOTALFilter

				insert into #trf_idCaseTOTALFilter
				select rf_idCase from #trf_idCaseTEMPFilter
			end
				
	set @FilterJoin = ' inner join #trf_idCaseTOTALFilter tf on tf.rf_idCase = c.id '
end

if (@p_PainSyndrome = 1)
begin
	delete from #trf_idCaseTEMPFilter	

	insert into #trf_idCaseTEMPFilter
	select distinct c.id rf_idcase
	from dbo.t_File f 
	INNER JOIN #LPU AS mo ON f.CodeM = mo.CodeM	
	INNER JOIN dbo.t_RegistersAccounts ra ON f.id=ra.rf_idFiles AND ra.PrefixNumberRegister<>'34'
	INNER JOIN dbo.t_RecordCasePatient AS rcp ON ra.id=rcp.rf_idRegistersAccounts
	INNER JOIN dbo.t_Case c ON rcp.id=c.rf_idRecordCasePatient AND c.DateEnd<@p_EndDate
	INNER JOIN dbo.t_RegisterPatient AS rp ON rp.rf_idRecordCase=rcp.id
	inner join [AccountOMS].[dbo].[t_Diagnosis] d on c.id=d.rf_idCase
	WHERE  ra.ReportYearMonth between @p_StartRepPeriod and @p_EndRepPeriod
	and f.TypeFile='H'
	and f.DateRegistration >= @p_StartDate AND f.DateRegistration <=@p_EndDate
	and d.[DiagnosisCode] like 'R52%' and TypeDiagnosis = 4/*DS3*/

			if (@p_Premature = 1 or @p_Diag <> '')
			begin
				delete t1 from #trf_idCaseTOTALFilter t1
				where not exists (select t2.rf_idcase from #trf_idCaseTEMPFilter t2 where t1.rf_idCase=t2.rf_idCase)
			end
		else
			begin
				delete from #trf_idCaseTOTALFilter

				insert into #trf_idCaseTOTALFilter
				select rf_idCase from #trf_idCaseTEMPFilter
			end

	set @FilterJoin = ' inner join #trf_idCaseTOTALFilter tf on tf.rf_idCase = c.id '
end

if (@p_ZNODiag = 1)
begin

	delete from #trf_idCaseTEMPFilter	

	insert into #trf_idCaseTEMPFilter
	select distinct c.id rf_idcase
	from dbo.t_File f 
	INNER JOIN #LPU AS mo ON f.CodeM = mo.CodeM	
	INNER JOIN dbo.t_RegistersAccounts ra ON f.id=ra.rf_idFiles AND ra.PrefixNumberRegister<>'34'
	INNER JOIN dbo.t_RecordCasePatient AS rcp ON ra.id=rcp.rf_idRegistersAccounts
	INNER JOIN dbo.t_Case c ON rcp.id=c.rf_idRecordCasePatient AND c.DateEnd<@p_EndDate
	INNER JOIN dbo.t_RegisterPatient AS rp ON rp.rf_idRecordCase=rcp.id
	INNER JOIN [dbo].[t_ONK_SL] osl on osl.[rf_idCase]=c.id
	inner join [AccountOMS].[dbo].[t_DiagnosticBlock] db on osl.id=db.[rf_idONK_SL]
	WHERE  ra.ReportYearMonth between @p_StartRepPeriod and @p_EndRepPeriod
	and f.TypeFile='H'
	and f.DateRegistration >= @p_StartDate AND f.DateRegistration <=@p_EndDate

			if (@p_Premature = 1 or @p_Diag <> '' or @p_PainSyndrome = 1)
			begin
				delete t1 from #trf_idCaseTOTALFilter t1
				where not exists (select t2.rf_idcase from #trf_idCaseTEMPFilter t2 where t1.rf_idCase=t2.rf_idCase)
			end
		else
			begin
				delete from #trf_idCaseTOTALFilter

				insert into #trf_idCaseTOTALFilter
				select rf_idCase from #trf_idCaseTEMPFilter
			end

	set @FilterJoin = ' inner join #trf_idCaseTOTALFilter tf on tf.rf_idCase = c.id '
end

if (@p_ZNOContraindications = 1)
begin

	delete from #trf_idCaseTEMPFilter	

	insert into #trf_idCaseTEMPFilter
	select distinct c.id rf_idcase
	from dbo.t_File f 
	INNER JOIN #LPU AS mo ON f.CodeM = mo.CodeM	
	INNER JOIN dbo.t_RegistersAccounts ra ON f.id=ra.rf_idFiles AND ra.PrefixNumberRegister<>'34'
	INNER JOIN dbo.t_RecordCasePatient AS rcp ON ra.id=rcp.rf_idRegistersAccounts
	INNER JOIN dbo.t_Case c ON rcp.id=c.rf_idRecordCasePatient AND c.DateEnd<@p_EndDate
	INNER JOIN dbo.t_RegisterPatient AS rp ON rp.rf_idRecordCase=rcp.id
	INNER JOIN [dbo].[t_ONK_SL] osl on osl.[rf_idCase]=c.id
	inner join [AccountOMS].[dbo].[t_Contraindications] cd on osl.id=cd.[rf_idONK_SL]
	WHERE  ra.ReportYearMonth between @p_StartRepPeriod and @p_EndRepPeriod
	and f.TypeFile='H'
	and f.DateRegistration >= @p_StartDate AND f.DateRegistration <=@p_EndDate

			if (@p_Premature = 1 or @p_Diag <> '' or @p_PainSyndrome = 1 or @p_ZNODiag = 1)
			begin
				delete t1 from #trf_idCaseTOTALFilter t1
				where not exists (select t2.rf_idcase from #trf_idCaseTEMPFilter t2 where t1.rf_idCase=t2.rf_idCase)
			end
		else
			begin
				delete from #trf_idCaseTOTALFilter

				insert into #trf_idCaseTOTALFilter
				select rf_idCase from #trf_idCaseTEMPFilter
			end

	set @FilterJoin = ' inner join #trf_idCaseTOTALFilter tf on tf.rf_idCase = c.id '
end

if (@p_USL_TIP > 0)
begin
	delete from #trf_idCaseTEMPFilter	

	insert into #trf_idCaseTEMPFilter
	select distinct c.id rf_idcase
	from dbo.t_File f 
	INNER JOIN #LPU AS mo ON f.CodeM = mo.CodeM	
	INNER JOIN dbo.t_RegistersAccounts ra ON f.id=ra.rf_idFiles AND ra.PrefixNumberRegister<>'34'
	INNER JOIN dbo.t_RecordCasePatient AS rcp ON ra.id=rcp.rf_idRegistersAccounts
	INNER JOIN dbo.t_Case c ON rcp.id=c.rf_idRecordCasePatient AND c.DateEnd<@p_EndDate
	INNER JOIN dbo.t_RegisterPatient AS rp ON rp.rf_idRecordCase=rcp.id
	inner join [AccountOMS].[dbo].[t_ONK_USL] ou on c.id=ou.rf_idCase
	WHERE  ra.ReportYearMonth between @p_StartRepPeriod and @p_EndRepPeriod
	and f.TypeFile='H'
	and f.DateRegistration >= @p_StartDate AND f.DateRegistration <=@p_EndDate
	and ou.rf_idN013=@p_USL_TIP

			if (@p_Premature = 1 or @p_Diag <> '' or @p_PainSyndrome = 1 or @p_ZNODiag = 1 or @p_ZNOContraindications = 1)
			begin
				delete t1 from #trf_idCaseTOTALFilter t1
				where not exists (select t2.rf_idcase from #trf_idCaseTEMPFilter t2 where t1.rf_idCase=t2.rf_idCase)
			end
		else
			begin
				delete from #trf_idCaseTOTALFilter

				insert into #trf_idCaseTOTALFilter
				select rf_idCase from #trf_idCaseTEMPFilter
			end

	set @FilterJoin = ' inner join #trf_idCaseTOTALFilter tf on tf.rf_idCase = c.id '
end



if (@p_TypeCheckup in ('0','4'))
begin
	SET @Query ='insert into #t 
						([CaseId],[Случай],[Выставлено],[IsChildTariff],[НомерКарты],[Начат],[Окончен],[ДатаРождения],[Возраст],[SeriaPolis],[NumberPolis],[ДатаРегистрации],[CodeMO]
						,[accountnumber],[accountdate],[attachMO],[СНИЛСВрача],[NewBorn],[PacTel],[rf_idV005],[rf_idSMO],[rf_idV009],[rpid],[rf_idV004],
					
						[IsNew],[COMENTSL],[RCPID],[ReportYear],[fam],[im],[ot], [TypeTranslation],BirthWeight, MSE, C_ZABid, KD,IsFirstDS,rf_idV012,rf_idV006,rf_idV008,rf_idDirectMO,
						rf_idV002,rf_idV014,rf_idV010,rf_idV018,rf_idV019, rf_idDepartmentMO, rf_idSubMO,IT_SL,rf_idONK_SL)
				(
				SELECT  c.id,c.idRecordCase,c.AmountPayment
						,c.IsChildTariff,c.NumberHistoryCase,c.DateBegin,c.DateEnd
						,rp.BirthDay,c.age,rcp.SeriaPolis,rcp.NumberPolis,f.DateRegistration,f.CodeM,ra.Account,ra.[DateRegister]
						,rcp.[AttachLPU],c.rf_idDoctor,rcp.[NewBorn],rp.TEL
						,rp.rf_idV005,ra.[rf_idSMO],c.rf_idV009,rp.id rpid,c.rf_idV004

						,rcp.IsNew,c.Comments, rcp.id rcpid, ra.ReportYear,rp.Fam,rp.Im,rp.Ot, c.[TypeTranslation],rcp.BirthWeight
						,c.MSE, c.C_ZAB,c.KD, c.[IsFirstDS], c.rf_idV012,c.rf_idV006,c.rf_idV008,c.rf_idDirectMO,c.rf_idV002,c.rf_idV014,c.rf_idV010,c.rf_idV018,c.rf_idV019
						,c.rf_idDepartmentMO, c.rf_idSubMO, c.IT_SL, osl.[id]
						FROM dbo.t_File f 
						INNER JOIN #LPU AS mo ON f.CodeM = mo.CodeM	
						INNER JOIN dbo.t_RegistersAccounts ra ON f.id=ra.rf_idFiles AND ra.PrefixNumberRegister<>''34''
						INNER JOIN dbo.t_RecordCasePatient AS rcp ON ra.id=rcp.rf_idRegistersAccounts
						INNER JOIN dbo.t_Case c ON rcp.id=c.rf_idRecordCasePatient AND c.DateEnd<'''+@p_EndDate+ '''
						INNER JOIN dbo.t_RegisterPatient AS rp ON rp.rf_idRecordCase=rcp.id
						 ' + @FilterJoin + ' 
						left JOIN [dbo].[t_ONK_SL] osl on osl.[rf_idCase]=c.id
																
						WHERE  ra.ReportYearMonth between '+@p_StartRepPeriod+' and '+@p_EndRepPeriod+' 
						and f.TypeFile=''H'' 
						and f.DateRegistration >= '''+@p_StartDate+ ''' AND f.DateRegistration <='''+ @p_EndDate+ ''' ' + @p_AdditionalFilter +' )'
end
else if (@p_TypeCheckup in ('1','2','3'))
	begin
	SET @Query ='insert into #t 
						([CaseId],[Случай],[Выставлено],[IsChildTariff],[НомерКарты],[Начат],[Окончен],[ДатаРождения],[Возраст],[SeriaPolis],[NumberPolis],[ДатаРегистрации],[CodeMO]
						,[accountnumber],[accountdate],[attachMO],[СНИЛСВрача],[NewBorn],[PacTel],[rf_idV005],[rf_idSMO],[rf_idV009],[rpid],[rf_idV004],
					
						[IsNew],[COMENTSL],[RCPID],[ReportYear],[fam],[im],[ot], [TypeTranslation],BirthWeight, MSE, C_ZABid, KD,IsFirstDS,rf_idV012,rf_idV006,rf_idV008,rf_idDirectMO,
						HopitalisationType,rf_idV002,rf_idV014,rf_idV010,rf_idV018,rf_idV019, rf_idDepartmentMO, rf_idSubMO,IT_SL,rf_idONK_SL)
				(
				SELECT  c.id,c.idRecordCase,c.AmountPayment
						,c.IsChildTariff,c.NumberHistoryCase,c.DateBegin,c.DateEnd
						,rp.BirthDay,c.age,rcp.SeriaPolis,rcp.NumberPolis,f.DateRegistration,f.CodeM,ra.Account,ra.[DateRegister]
						,rcp.[AttachLPU],c.rf_idDoctor,rcp.[NewBorn],rp.TEL
						,rp.rf_idV005,ra.[rf_idSMO],c.rf_idV009,rp.id rpid,c.rf_idV004

						,rcp.IsNew,c.Comments, rcp.id rcpid, ra.ReportYear,rp.Fam,rp.Im,rp.Ot,c.[TypeTranslation],rcp.BirthWeight
						,c.MSE, c.C_ZAB,c.KD, c.[IsFirstDS],c.rf_idV012, c.rf_idV006,c.rf_idV008,c.rf_idDirectMO,c.HopitalisationType,c.rf_idV002,c.rf_idV014,c.rf_idV010
						,c.rf_idV018,c.rf_idV019, c.rf_idDepartmentMO, c.rf_idSubMO, c.IT_SL, osl.[id]
						FROM dbo.t_File f 
						INNER JOIN #LPU AS mo ON f.CodeM = mo.CodeM	
						INNER JOIN dbo.t_RegistersAccounts ra ON f.id=ra.rf_idFiles AND ra.PrefixNumberRegister<>''34''
						INNER JOIN dbo.t_RecordCasePatient AS rcp ON ra.id=rcp.rf_idRegistersAccounts
						INNER JOIN dbo.t_Case c ON rcp.id=c.rf_idRecordCasePatient AND c.DateEnd<'''+@p_EndDate+ '''
						INNER JOIN dbo.t_RegisterPatient AS rp ON rp.rf_idRecordCase=rcp.id
						inner join [dbo].[t_PaymentAcceptedCase2] pac2 on pac2.rf_idCase=c.id and pac2.TypeCheckup='''+@p_TypeCheckup+'''
						 ' + @FilterJoin + ' 
						left JOIN [dbo].[t_ONK_SL] osl on osl.[rf_idCase]=c.id
																
						WHERE  ra.ReportYearMonth between '+@p_StartRepPeriod+' and '+@p_EndRepPeriod+' 
						and f.TypeFile=''H'' 
						and f.DateRegistration >= '''+@p_StartDate+ ''' AND f.DateRegistration <='''+ @p_EndDate+ ''' ' + @p_AdditionalFilter +'  
						group by c.id,c.idRecordCase,c.AmountPayment
						,c.IsChildTariff,c.NumberHistoryCase,c.DateBegin,c.DateEnd
						,rp.BirthDay,c.age,rcp.SeriaPolis,rcp.NumberPolis,f.DateRegistration,f.CodeM,ra.Account,ra.[DateRegister]
						,rcp.[AttachLPU],c.rf_idDoctor,rcp.[NewBorn],rp.TEL
						,rp.rf_idV005,ra.[rf_idSMO],c.rf_idV009,rp.id,c.rf_idV004,rcp.IsNew,c.Comments, rcp.id, ra.ReportYear,rp.Fam,rp.Im,rp.Ot,c.[TypeTranslation],rcp.BirthWeight
						,c.MSE, c.C_ZAB,c.KD, c.[IsFirstDS],c.rf_idV012, c.rf_idV006,c.rf_idV008,c.rf_idDirectMO,c.HopitalisationType,c.rf_idV002,c.rf_idV014,c.rf_idV010
						,c.rf_idV018,c.rf_idV019, c.rf_idDepartmentMO, c.rf_idSubMO, c.IT_SL, osl.[id])'
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

--if (@p_Premature = 1)
--begin
--	delete t1 from #t t1
--	where not exists (select caseid from #t t2
--	inner join [AccountOMS].[dbo].[t_BirthWeight] bw on t2.CaseId=bw.rf_idCase
--	where t1.CaseId=t2.CaseId)
--end

--if (@p_Diag <> '')
--begin
--	if (CHARINDEX('%',@p_Diag)>0)
--		delete t1 from #t t1
--		where not exists (select caseid from #t t2
--		inner join [AccountOMS].[dbo].[t_Diagnosis] d on t2.CaseId=d.rf_idCase
--		where t1.CaseId=t2.CaseId and d.[DiagnosisCode] like @p_Diag)
--	else
--		delete t1 from #t t1
--		where not exists (select caseid from #t t2
--		inner join [AccountOMS].[dbo].[t_Diagnosis] d on t2.CaseId=d.rf_idCase
--		where t1.CaseId=t2.CaseId and d.[DiagnosisCode]=@p_Diag)
--end

--if (@p_PainSyndrome = 1)
--begin
--		delete t1 from #t t1
--		where not exists (select caseid from #t t2
--		inner join [AccountOMS].[dbo].[t_Diagnosis] d on t2.CaseId=d.rf_idCase
--		where t1.CaseId=t2.CaseId and d.[DiagnosisCode] like 'R52%' and TypeDiagnosis = 4 /*DS3*/)
--end

--if (@p_ZNODiag = 1)
--begin
--	delete t1 from #t t1
--	where not exists (select caseid from #t t2
--	inner join [AccountOMS].[dbo].[t_DiagnosticBlock] db on t2.rf_idONK_SL=db.[rf_idONK_SL]
--	where t1.CaseId=t2.CaseId)
--end

--if (@p_ZNOContraindications = 1)
--begin
--	delete t1 from #t t1
--	where not exists (select caseid from #t t2
--	inner join [AccountOMS].[dbo].[t_Contraindications] cd on t2.rf_idONK_SL=cd.[rf_idONK_SL]
--	where t1.CaseId=t2.CaseId)
--end

--if (@p_USL_TIP > 0)
--begin
--	delete t1 from #t t1
--	where not exists (select caseid from #t t2
--	inner join [AccountOMS].[dbo].[t_ONK_USL] ou on t2.CaseId=ou.rf_idCase
--	where t1.CaseId=t2.CaseId and ou.rf_idN013=@p_USL_TIP)
--end



select c.CaseId,c.[Окончен],osl.id osl_id,c.*,cast(v9.Id as varchar(4))+' — '+v9.Name Результат,v4.Name СпециальностьМедРаботника,v5.Name Пол
	,rpd.SNILS СНИЛС,mo.CodeM+' — '+mo.MOName МО
	,[SMOKOD] + ' - ' + [NAM_SMOK] SMO--,dmo.NAM_MOK Направление
	,case when RTRIM(c.[NewBorn])>0 then 'Да' else 'Нет' end NewBornWord
	, rtrim(mes.MES)+' — '+ isnull(mu.[MUName],'') CODE_MES1
	,cc.id CompletedCaseID,psmo.ENP,dis.[DateDefine] [ДатаИнвалидности], UPPER(c.Fam + ' ' + c.Im + ' ' + ISNULL(c.Ot,'')) [Пациент]
	,CAST(CASE WHEN c.IsChildTariff = 0 THEN 'Взрослый' WHEN c.IsChildTariff = 1 THEN 'Детский' ELSE 'Не указан' END AS VARCHAR(20)) [Тариф]
	,ltrim(isnull(c.SeriaPolis,'') + ' '+c.NumberPolis) [НомерПолиса],case when c.IsNew=0 then 'Первичная' when c.IsNew=1 then 'Повторная' end PR_NOV
	,datename(mm,c.[Окончен]) [ReportMonth],InfoMEK,InfoMEE,InfoEKMP,deducMEK,deducMEE,deducEKMP, cc.AmountPayment AmPayZSL2,cc.[VB_P]
	,rtrim(d.[DiagnosisCode])+' — '+mkb.[Diagnosis] as Диагноз,case when c.[IsFirstDS]=1 then 'Да' else 'Нет' end DS1_PR, v12.Name [Исход],

 
	c.BirthWeight VNOV_D,/*вес ребенка, пациент - ребенок*/dis.[TypeOfGroup] INV /*группа инв*/,dis.rf_idReasonDisability REASON_INV/*Код причины инвалидности*/,dis.Diagnosis DS_INV/*код осн. диагноза*/,
	cc.HospitalizationPeriod KD_Z /*продолжительность госпитализации*/,c.KD /*Продолжительность госпитализации*/,cast(c.C_ZABid as varchar) +' — '+ v27.N_CZ C_ZAB/*Характер основного заболевания*/,
	case when c.TypeTranslation=1 then 'Поступил самостоятельно' when c.TypeTranslation=2 then 'Доставлен СМП' when c.TypeTranslation=3 then 'Перевод из другой МО' when c.TypeTranslation=4 then 'Перевод внутри МО' end P_PER/*Признак поступления/перевода*/,
	case when onk.DS_ONK=0 then 'Нет' when onk.DS_ONK=1 then 'Да' end DS_ONK,v6.Name AS УсловияОказания, v8.Name VIDPOM,c.rf_idDirectMO+' — '+dmo.NAM_MOK AS Направление, dd.DirectionDate,
	v14.[NAME] FOR_POM,v2.name AS Профиль,v10.Name AS СпособОплаты, v18.[Name] VID_HMP, v19.Name METOD_HMP, v20.name PROFIL_K, md.name_short PODR, mp.name_short LPU_1/*МОМП*/,v25.IDPC+' — '+v25.N_PC P_CEL,
	sop.GetDatePaper TAL_D,sop.DateHospitalization TAL_P, sop.NumberTicket TAL_NUM,UPPER(rpa.Fam + ' ' + rpa.Im + ' ' + ISNULL(rpa.Ot, '')) AS Сопровождающий,nv.[DateVizit] NEXT_VISIT,
	case when slk.[SL_K]=0 then 'Не применялся' when slk.[SL_K]=1 then 'Применялся' end SL_K/*КСЛП*/,kiro.[ValueKiro], n18.REAS_NAME DS1_T, n2.[DS_St]+' ('+n2.[KOD_St]+')' STAD,
	n3.[KOD_T] ONK_T,n4.[KOD_N] ONK_N,n5.[KOD_M] ONK_M, case when osl.[IsMetastasis]=1 then 'Выявлены' else 'Не выявлены' end MTSTZ,osl.[TotalDose] SOD, osl.K_FR, osl.WEI,osl.HEI,osl.BSA,
	case when pov.DN=1 then 'Состоит' when pov.DN=2 then 'Взят' when pov.DN=4 then 'Снят по причине выздоровления' when pov.DN=6 then 'Снят по другим причинам' end PR_D_N --Диспансерное наблюдение
from #t c
INNER JOIN OMS_NSI.dbo.sprV005 AS v5 ON c.rf_idV005 = v5.Id
INNER JOIN [OMS_NSI].[dbo].[sprSMO] AS SMO ON c.[rf_idSMO] = SMO.[SMOKOD]
INNER JOIN #LPU AS mo on c.[CodeMO]=mo.CodeM
inner join [dbo].[t_CompletedCase] cc on cc.rf_idRecordCasePatient=c.RCPID
inner join dbo.t_PatientSMO psmo on psmo.rf_idRecordCasePatient=c.RCPID
INNER JOIN [dbo].[t_DS_ONK_REAB] onk on onk.[rf_idCase]=c.CaseId
inner join [AccountOMS].[dbo].[t_Diagnosis] d on c.CaseId=d.rf_idCase and d.TypeDiagnosis=1 /*DS1*/
inner join [OMS_nsi].[dbo].[sprMKB] mkb on mkb.[DiagnosisCode]=d.[DiagnosisCode]
INNER JOIN OMS_NSI.dbo.sprV002 AS v2 ON c.rf_idV002 = v2.Id and c.[Окончен] between v2.DateBeg and v2.DateEnd
INNER JOIN OMS_NSI.dbo.sprV006 AS v6 ON c.rf_idV006 = v6.Id and c.[Окончен] between v6.DateBeg and v6.DateEnd
INNER JOIN OMS_NSI.dbo.sprV008 AS v8 ON c.rf_idV008 = v8.Id and c.[Окончен] between v8.DateBeg and v8.DateEnd
INNER JOIN OMS_NSI.dbo.sprV014 AS v14 ON c.rf_idV014 = v14.[sprV014Id] and c.[Окончен] between v14.DateBeg and v14.DateEnd
INNER JOIN OMS_NSI.dbo.sprV010 AS v10 ON c.rf_idV010 = v10.Id and c.[Окончен] between v10.DateBeg and v10.DateEnd

left JOIN OMS_NSI.dbo.sprV018 AS v18 ON c.rf_idV018 = v18.[Code] and c.[Окончен] between v18.DateBeg and v18.DateEnd
left join OMS_NSI.dbo.sprV019 v19 on c.rf_idV019 = v19.Code and c.[Окончен] between v19.DateBeg and v19.DateEnd
left JOIN [dbo].[t_Disability] dis ON dis.[rf_idRecordCasePatient]=c.RCPID	        
LEFT JOIN OMS_NSI.dbo.sprV009 AS v9 ON c.rf_idV009 = v9.Id
LEFT JOIN OMS_NSI.dbo.sprV012 AS v12 ON c.rf_idV012 = v12.Id
LEFT JOIN dbo.t_RegisterPatientDocument AS rpd ON rpd.rf_idRegisterPatient = c.rpid
LEFT JOIN [dbo].[vw_sprMedicalSpeciality] v4 on c.rf_idV004=v4.id AND c.[Окончен]>=v4.DateBeg AND c.[Окончен]<v4.DateEnd
LEFT JOIN OMS_NSI.dbo.sprMO AS dmo ON dmo.mcod = c.rf_idDirectMO
left join dbo.t_MES mes on mes.rf_idCase=c.CaseId
LEFT JOIN /*oms_nsi.dbo.vw_sprMUandCSG*/dbo.vw_sprMESandCSG mu on mu.[code]=mes.[MES] and c.[Окончен] between isnull(mu.[dateBeg],'19000101') and isnull(mu.[dateEnd],'22221231')
/*LEFT JOIN dbo.vw_sprMUAll mu on mu.[MU]=mes.[MES]*/
left join [dbo].[t_DirectionDate] dd on dd.rf_idCase=c.CaseId
left join #kosku k on k.CaseId=c.CaseId
left join [dbo].[t_ProfileOfBed] pb on pb.[rf_idCase]=c.CaseId
left join OMS_NSI.dbo.sprV020 v20 on pb.rf_idV020 = v20.Code and c.[Окончен] between v20.DateBeg and v20.DateEnd
left join oms_nsi.dbo.tMODept md on md.code=c.[rf_idDepartmentMO] and md.[rf_MOId]=mo.[MOId]
left join oms_nsi.dbo.[tMOPlace] mp on mp.code=c.[rf_idSubMO] and mp.[rf_MOId]=mo.[MOId]
left join [dbo].[t_PurposeOfVisit] pov on pov.rf_idCase=c.CaseId
left join OMS_NSI.dbo.sprV025 v25 on pov.rf_idV025 = v25.IDPC and c.[Окончен] between v25.DateBeg and v25.DateEnd
left join [dbo].[t_SlipOfPaper] sop on sop.rf_idCase=c.CaseId
left join [dbo].[t_RegisterPatientAttendant] rpa on rpa.rf_idRegisterPatient=c.rpid
left join [dbo].[t_NextVisitDate] nv on nv.rf_idCase=c.CaseId
left JOIN [dbo].[t_SLK] slk on slk.[rf_idCase]=c.CaseId
left JOIN [dbo].[t_Kiro] kiro on kiro.rf_idCase=c.CaseId
left JOIN [dbo].[t_ONK_SL] osl on osl.[rf_idCase]=c.CaseId
left JOIN [oms_nsi].[dbo].[sprN018] n18 on n18.[ID_REAS]=osl.DS1_T and c.[Окончен] between n18.DateBeg and n18.DateEnd
left JOIN [oms_nsi].[dbo].[sprN002] n2 on n2.[ID_St]=osl.[rf_idN002] and c.[Окончен] between n2.DateBeg and n2.DateEnd
left JOIN [oms_nsi].[dbo].[sprN003] n3 on n3.[ID_T]=osl.[rf_idN003] and c.[Окончен] between n3.DateBeg and n3.DateEnd
left JOIN [oms_nsi].[dbo].[sprN004] n4 on n4.[ID_N]=osl.[rf_idN004] and c.[Окончен] between n4.DateBeg and n4.DateEnd
left JOIN [oms_nsi].[dbo].[sprN005] n5 on n5.[ID_M]=osl.[rf_idN005] and c.[Окончен] between n5.DateBeg and n5.DateEnd
left join [oms_nsi].[dbo].[sprV027] v27 on v27.IDCZ=c.C_ZABid and c.[Окончен] between v27.DateBeg and v27.DateEnd
order by c.CaseId


--drop table #lpu
--drop table #t
--drop table #trf_idCaseTOTALFilter
--drop table #trf_idCaseTEMPFilter
--drop table #tD


END 


GO



GRANT EXECUTE ON  [dbo].[usp_selectCases19Type1] TO [AccountsOMS]
GRANT EXECUTE ON  [dbo].[usp_selectCases19Type1] TO [db_AccountOMS]
GO
