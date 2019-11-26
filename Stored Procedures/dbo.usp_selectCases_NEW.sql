
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[usp_selectCases_NEW]
--declare
    @p_AccountCode INT = NULL,
    @p_StartDate VARCHAR(10) = null,
    @p_EndDate VARCHAR(20) = null,
    @p_FilialCode INT = -1 ,
    @p_LPUCode INT = -1 ,
    @p_LPUManualEnteredCode INT = -1 ,--имеет более высокий приоритет чем данные в переменной @p_LPUCode
    @p_SimpleSelect INT = 0, -- более не используется с 10.12.2018
    @p_AdditionalFilter NVARCHAR(2000)=null,
    @Query NVARCHAR(max)=null
    
AS 
IF ( @p_AccountCode IS NOT NULL ) 
	BEGIN
		CREATE TABLE #t_tmpAccs ( id INT, rf_idFiles INT )
		INSERT  INTO #t_tmpAccs
			SELECT ra.id,ra.rf_idFiles
            FROM dbo.t_RegistersAccounts ra
            WHERE ra.[rf_idFiles] = @p_AccountCode

        SELECT  c.id AS CaseId,c.idRecordCase AS Случай,v6.Name AS УсловияОказания,v8.Name AS ВидПомощи,dmo.NAM_MOK AS Направление,CASE WHEN c.HopitalisationType = 1 THEN 'Плановая' ELSE 'Экстренная' END AS ТипГоспитализации,
                v2.name AS Профиль,CASE WHEN c.IsChildTariff = 0 THEN 'Взрослый' WHEN c.IsChildTariff = 1 THEN 'Детский' ELSE 'Не указан' END AS Тариф,c.NumberHistoryCase AS НомерКарты,c.DateBegin AS Начат,
                c.DateEnd AS Окончен,c.AmountPayment AS Выставлено,v9.Name AS Результат,v12.Name AS Исход,v4.Name AS СпециальностьМедРаботника,v10.Name AS СпособОплаты,UPPER(rp.Fam + ' ' + rp.Im + ' ' + ISNULL(rp.Ot, '')) AS Пациент,
                v5.Name AS Пол,rp.BirthDay AS ДатаРождения,c.age AS Возраст,rp.BirthPlace AS МестоРождения,rpa.Fam + ' ' + rpa.Im + ' ' + ISNULL(rpa.Ot, '') AS Представитель,dt.Name AS ТипДокумента,rpd.SeriaDocument AS Серия,
                RTRIM(rpd.NumberDocument) AS Номер,rpd.SNILS AS СНИЛС,rcp.SeriaPolis AS СерияПолиса,rcp.NumberPolis AS НомерПолиса,f.DateRegistration AS ДатаРегистрации,fil.FilialId AS CodeFilial,f.CodeM AS CodeMO,
                fil.filialName AS Филиал,mo2.NameS AS МО,d.DS1 AS КодДиагноза,mkb.Diagnosis AS Диагноз,/*okato1.namel AS АдресРегистрации,okato2.namel  AS АдресМестаЖительства,*/rcp.[AttachLPU] AS МОПрикрепления,RTRIM(rcp.[NewBorn]) as NewBorn
        FROM dbo.t_Case AS c
		INNER JOIN dbo.t_RecordCasePatient AS rcp ON c.rf_idRecordCasePatient = rcp.id
		INNER JOIN #t_tmpAccs AS ra ON rcp.rf_idRegistersAccounts = ra.id
		INNER JOIN dbo.t_File AS f ON ra.rf_idFiles = f.id
        INNER JOIN OMS_NSI.dbo.tMO AS mo1 ON f.CodeM = LEFT(mo1.tfomsCode,6)
        INNER JOIN OMS_NSI.dbo.tFilial AS fil ON mo1.rf_FilialId = fil.FilialId
        INNER JOIN dbo.t_RegisterPatient AS rp ON rp.rf_idRecordCase = rcp.id
        INNER JOIN OMS_NSI.dbo.sprV002 AS v2 ON c.rf_idV002 = v2.Id
        INNER JOIN OMS_NSI.dbo.sprV006 AS v6 ON c.rf_idV006 = v6.Id
        INNER JOIN OMS_NSI.dbo.sprV008 AS v8 ON c.rf_idV008 = v8.Id
        INNER JOIN OMS_NSI.dbo.sprV010 AS v10 ON c.rf_idV010 = v10.Id
        INNER JOIN OMS_NSI.dbo.sprV005 AS v5 ON rp.rf_idV005 = v5.Id
        INNER JOIN dbo.vw_Diagnosis AS d ON c.id = d.rf_idCase
        INNER JOIN OMS_NSI.dbo.sprMKB AS mkb ON mkb.DiagnosisCode = d.DS1
        INNER JOIN dbo.vw_sprT001_Report AS mo2 ON mo2.CodeM = f.CodeM
        LEFT JOIN OMS_NSI.dbo.sprMO AS dmo ON dmo.mcod = c.rf_idDirectMO
        LEFT JOIN OMS_NSI.dbo.sprV009 AS v9 ON c.rf_idV009 = v9.Id
        LEFT JOIN OMS_NSI.dbo.sprV012 AS v12 ON c.rf_idV012 = v12.Id
        LEFT JOIN dbo.t_RegisterPatientAttendant AS rpa ON rpa.rf_idRegisterPatient = rp.id
        LEFT JOIN dbo.t_RegisterPatientDocument AS rpd ON rpd.rf_idRegisterPatient = rp.id
		/*LEFT JOIN OMS_NSI.dbo.vw_Accounts_OKATO okato1 on rpd.OKATO=okato1.okato
		LEFT JOIN OMS_NSI.dbo.vw_Accounts_OKATO okato2 on rpd.OKATO_place=okato2.okato*/
        LEFT JOIN OMS_NSI.dbo.sprDocumentType AS dt ON rpd.rf_idDocumentType = dt.ID
        LEFT JOIN [dbo].[vw_sprMedicalSpeciality] v4 on c.rf_idV004=v4.id AND c.DateEnd>=v4.DateBeg AND c.DateEnd<v4.DateEnd
		ORDER BY c.idRecordCase
        END
---------------------------------------------------------------------------------
ELSE IF ( @p_AccountCode IS NULL) 
BEGIN
    create TABLE #lpu(CodeM CHAR(6),MOName VARCHAR(250), FilialId TINYINT,filialName VARCHAR(50))
                    
	SELECT @p_FilialCode =CASE WHEN @p_FilialCode = -1 THEN NULL ELSE (SELECT filialCode FROM dbo.vw_sprFilial WHERE FilialId=@p_FilialCode) end
		  ,@p_LPUCode =CASE WHEN @p_LPUCode=-1 AND @p_LPUManualEnteredCode=-1 THEN NULL 
							WHEN @p_LPUCode=-1 AND @p_LPUManualEnteredCode>-1 THEN @p_LPUManualEnteredCode 
							WHEN @p_LPUCode>-1 AND @p_LPUManualEnteredCode>-1 THEN @p_LPUManualEnteredCode ELSE @p_LPUCode END
		  ,@p_EndDate=@p_EndDate+' 23:59:59'		
		  
   
	INSERT #LPU
	SELECT CodeM, [NAMES], filialCode,filialName FROM dbo.vw_sprT001 
	WHERE CodeM=ISNULL(@p_LPUCode,codeM) AND filialCode=ISNULL(@p_FilialCode,filialCode)

	CREATE TABLE #t (
	[CaseId] [bigint] NOT NULL,
	[Случай] [bigint] NOT NULL,
	[Выставлено] [decimal](15, 2) NOT NULL,
	[ТипГоспитализации] [varchar](20) NULL,
	[Тариф] [varchar](20) NULL,
	[НомерКарты] [nvarchar](50) NOT NULL,
	[Начат] [date] NOT NULL,
	[Окончен] [date] NOT NULL,
	[Пациент] [nvarchar](122) NULL,
	[ДатаРождения] [date] NULL,
	[Возраст] [smallint] NULL,
	[МестоРождения] [nvarchar](100) NULL,
	[СерияПолиса] [varchar](10) NULL,
	[НомерПолиса] [varchar](20) NULL,
	[ДатаРегистрации] [datetime] NOT NULL,
	[CodeMO] [varchar](6) NULL,
	[КодДиагноза] [char](10) NULL,
	[accountnumber] [varchar](15) NULL,
	[accountdate] [date] NOT NULL,
	[attachMO] [char](6) NULL,
	[СНИЛСВрача] [varchar](25) NULL,
	[NewBorn] [varchar](9) NULL,
	[PacTel] [varchar](10) NULL,
	[ДатаИнвалидности] [date] NULL,
	[rf_idV002] [smallint] NOT NULL,
	[rf_idV006] [tinyint] NOT NULL,
	[rf_idV008] [smallint] NOT NULL,
	[rf_idV010] [tinyint] NOT NULL,
	[rf_idV005] [tinyint] NOT NULL,
	[DS1] [char](10) NULL,
	[rf_idSMO] [char](5) NULL,
	[rf_idDirectMO] [char](6) NULL,
	[rf_idV009] [smallint] NOT NULL,
	[rf_idV012] [smallint] NOT NULL,
	[rpid] [int] NOT NULL,
	[rf_idV004] [int] NOT NULL
) 
 
SET @Query ='insert into #t 
					([CaseId],[Случай],[Выставлено],[ТипГоспитализации],[Тариф],[НомерКарты],[Начат],[Окончен],[Пациент],[ДатаРождения],[Возраст],[МестоРождения],[СерияПолиса],[НомерПолиса],[ДатаРегистрации]
					,[CodeMO],[КодДиагноза],[accountnumber],[accountdate],[attachMO],[СНИЛСВрача],[NewBorn],[PacTel],[ДатаИнвалидности],[rf_idV002],[rf_idV006],[rf_idV008],[rf_idV010],[rf_idV005],[DS1],[rf_idSMO],[rf_idDirectMO],[rf_idV009],[rf_idV012],[rpid],[rf_idV004])
			(
			SELECT  c.id,c.idRecordCase,c.AmountPayment,CAST(CASE WHEN c.HopitalisationType = 1 THEN ''Плановая'' ELSE ''Экстренная'' END AS varchar(20))
					,CAST(CASE WHEN c.IsChildTariff = 0 THEN ''Взрослый'' WHEN c.IsChildTariff = 1 THEN ''Детский'' ELSE ''Не указан'' END AS VARCHAR(20)),c.NumberHistoryCase,c.DateBegin,c.DateEnd
					,UPPER(rp.Fam + '' '' + rp.Im + '' '' + ISNULL(rp.Ot,'''')),rp.BirthDay,c.age,rp.BirthPlace,rcp.SeriaPolis,rcp.NumberPolis,f.DateRegistration,f.CodeM ,d.DS1,ra.Account,ra.[DateRegister]
					,rcp.[AttachLPU],c.rf_idDoctor,RTRIM(rcp.[NewBorn]),rp.TEL,dis.[DateDefine]

					,c.rf_idV002,c.rf_idV006,c.rf_idV008,c.rf_idV010,rp.rf_idV005,d.DS1,ra.[rf_idSMO],c.rf_idDirectMO,c.rf_idV009,c.rf_idV012,rp.id rpid,c.rf_idV004
					FROM dbo.t_File f 
					INNER JOIN #LPU AS mo ON f.CodeM = mo.CodeM	
					INNER JOIN dbo.t_RegistersAccounts ra ON f.id=ra.rf_idFiles AND ra.PrefixNumberRegister<>''34''
					INNER JOIN dbo.t_RecordCasePatient AS rcp ON ra.id=rcp.rf_idRegistersAccounts
					INNER JOIN dbo.t_Case c ON rcp.id=c.rf_idRecordCasePatient AND c.DateEnd<'''+@p_EndDate+ '''
					INNER JOIN dbo.t_RegisterPatient AS rp ON rp.rf_idRecordCase=rcp.id
					INNER JOIN dbo.vw_Diagnosis AS d ON c.id = d.rf_idCase
					left JOIN [dbo].[t_Disability] dis ON dis.[rf_idRecordCasePatient]=rcp.id													
					WHERE  f.DateRegistration >= '''+@p_StartDate+ ''' AND f.DateRegistration <='''+ @p_EndDate+ ''' ' + @p_AdditionalFilter +' )'

print (@Query)
EXEC (@Query)  
 
select c.*,v2.name Профиль,v9.Name Результат,v12.Name Исход,v4.Name СпециальностьМедРаботника,v10.Name СпособОплаты,v5.Name Пол,rpa.Fam + ' ' + rpa.Im + ' ' + rpa.Ot Представитель,dt.Name ТипДокумента 
       ,rpd.SeriaDocument Серия,RTRIM(rpd.NumberDocument) Номер,rpd.SNILS СНИЛС,mo.filialName Филиал,mo.FilialId CodeFilial,mo.MOName МО,mkb.Diagnosis Диагноз
	   ,rpd.OKATO АдресРегистрации,rpd.OKATO_place АдресМестаЖительства,[SMOKOD] + ' - ' + [NAM_SMOK] SMO,dmo.NAM_MOK Направление,v6.Name AS УсловияОказания,v8.Name AS ВидПомощи
from #t c
INNER JOIN OMS_NSI.dbo.sprV002 AS v2 ON c.rf_idV002 = v2.Id
INNER JOIN OMS_NSI.dbo.sprV006 AS v6 ON c.rf_idV006 = v6.Id
INNER JOIN OMS_NSI.dbo.sprV008 AS v8 ON c.rf_idV008 = v8.Id
INNER JOIN OMS_NSI.dbo.sprV010 AS v10 ON c.rf_idV010 = v10.Id
INNER JOIN OMS_NSI.dbo.sprV005 AS v5 ON c.rf_idV005 = v5.Id
INNER JOIN OMS_NSI.dbo.sprMKB AS mkb ON mkb.DiagnosisCode = c.DS1
INNER JOIN [OMS_NSI].[dbo].[sprSMO] AS SMO ON c.[rf_idSMO] = SMO.[SMOKOD]
INNER JOIN #LPU AS mo on c.[CodeMO]=mo.CodeM
        
LEFT JOIN OMS_NSI.dbo.sprMO AS dmo ON dmo.mcod = c.rf_idDirectMO
LEFT JOIN OMS_NSI.dbo.sprV009 AS v9 ON c.rf_idV009 = v9.Id
LEFT JOIN OMS_NSI.dbo.sprV012 AS v12 ON c.rf_idV012 = v12.Id
LEFT JOIN dbo.t_RegisterPatientAttendant AS rpa ON rpa.rf_idRegisterPatient = c.rpid
LEFT JOIN dbo.t_RegisterPatientDocument AS rpd ON rpd.rf_idRegisterPatient = c.rpid
LEFT JOIN OMS_NSI.dbo.sprDocumentType AS dt ON rpd.rf_idDocumentType = dt.ID
LEFT JOIN [dbo].[vw_sprMedicalSpeciality] v4 on c.rf_idV004=v4.id AND c.[Окончен]>=v4.DateBeg AND c.[Окончен]<v4.DateEnd

--select * from #t

END 


GO

GRANT EXECUTE ON  [dbo].[usp_selectCases_NEW] TO [AccountsOMS]
GRANT EXECUTE ON  [dbo].[usp_selectCases_NEW] TO [db_AccountOMS]
GO
