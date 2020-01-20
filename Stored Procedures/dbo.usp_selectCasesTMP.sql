SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[usp_selectCasesTMP]
    @p_AccountCode INT = NULL ,
    @p_StartDate VARCHAR(10) = NULL ,
    @p_EndDate VARCHAR(20) = NULL ,
    @p_FilialCode INT = -1 ,
    @p_LPUCode INT = -1 ,
    @p_LPUManualEnteredCode INT = -1 ,--имеет более высокий приоритет чем данные в переменной @p_LPUCode
    @p_AdditionalFilter NVARCHAR(2000) = '',
    @Query NVARCHAR(4000)=null
   
AS
--CREATE TABLE #cte_cases(
--	CaseId bigint NOT NULL,
--	Случай bigint NOT NULL,
--	Выставлено decimal(15, 2) NOT NULL,
--	rf_idV006 tinyint NOT NULL,
--	rf_idV008 smallint NOT NULL,
--	rf_idDirectMO char(6) NULL,
--	ТипГоспитализации varchar(20) NULL,
--	rf_idV002 smallint NOT NULL,
--	Тариф varchar(20) NULL,
--	NumberHistoryCase nvarchar(50) NOT NULL,
--	DateBegin date NOT NULL,
--	DateEnd date NOT NULL,
--	rf_idV009 smallint NOT NULL,
--	rf_idV012 smallint NOT NULL,
--	rf_idV004 int NOT NULL,
--	rf_idV010 tinyint NOT NULL,
--	Пациент nvarchar(122) NOT NULL,
--	rf_idV005 tinyint NOT NULL,
--	BirthDay date NOT NULL,
--	age smallint NULL,
--	BirthPlace nvarchar(100) NULL,
--	Представитель nvarchar(122) NULL,
--	rf_idDocumentType char(2) NULL,
--	SeriaDocument varchar(10) NULL,
--	NumberDocument varchar(20) NULL,
--	SNILS char(14) NULL,
--	SeriaPolis varchar(10) NULL,
--	NumberPolis varchar(20) NOT NULL,
--	DateRegistration datetime NOT NULL,
--	filialName varchar(50) NULL,
--	CodeM varchar(6) NULL,
--	FilialId tinyint NULL,
--	MOName varchar(100) NULL,
--	DS1 char(10) NULL,
--	OKATO char(11) NULL,
--	OKATO_Place char(11) NULL,
--	Account varchar(15) NULL,
--	DateRegister date NOT NULL,
--	AttachLPU char(6) NULL    
--)
--create TABLE #lpu(CodeM CHAR(6),MOName VARCHAR(100), FilialId TINYINT,filialName VARCHAR(50))

--IF ( @p_AccountCode IS NOT NULL ) 
--BEGIN
--			INSERT #LPU
--			SELECT l.CodeM, [NAMES], filialCode,filialName 
--			FROM dbo.vw_sprT001 l INNER JOIN t_File f ON
--						l.CodeM=f.CodeM
--			WHERE f.id=@p_AccountCode
               
--INSERT INTO #cte_cases( CaseId ,Случай ,Выставлено ,rf_idV006 ,rf_idV008 ,rf_idDirectMO ,ТипГоспитализации ,rf_idV002 ,Тариф ,NumberHistoryCase ,DateBegin 
--			,DateEnd ,rf_idV009 ,rf_idV012 ,rf_idV004 ,rf_idV010 ,Пациент ,rf_idV005 ,BirthDay ,age ,BirthPlace ,Представитель ,rf_idDocumentType 
--			,SeriaDocument ,NumberDocument ,SNILS ,SeriaPolis ,NumberPolis ,DateRegistration ,filialName ,CodeM ,FilialId ,MOName ,DS1 
--			,OKATO ,OKATO_Place ,Account ,DateRegister ,AttachLPU) 
--SELECT  c.id AS CaseId
--		 ,c.idRecordCase AS Случай  
--		 ,c.AmountPayment AS Выставлено 
--		 ,c.rf_idV006
--		 ,c.rf_idV008
--		 ,c.rf_idDirectMO
--		 ,CAST(CASE WHEN c.HopitalisationType = 1 THEN 'Плановая' ELSE 'Экстренная' END AS varchar(20)) AS [ТипГоспитализации]
--		 ,c.rf_idV002
--		 ,CAST(CASE WHEN c.IsChildTariff = 0 THEN 'Взрослый' ELSE 'Детский' END AS VARCHAR(20)) AS [Тариф]
--		 ,c.NumberHistoryCase 
--		 ,c.DateBegin 
--		 ,c.DateEnd 
--		 ,c.rf_idV009
--		 ,c.rf_idV012 
--		 ,c.rf_idV004
--		 ,c.rf_idV010
--		 ,rp.Fam + ' ' + rp.Im + ' '+ ISNULL(rp.Ot,'') as Пациент      
--		 ,rp.rf_idV005
--		 ,rp.BirthDay
--		 ,c.age 
--		 ,rp.BirthPlace 
--		 ,rpa.Fam + ' '+ rpa.Im + ' '+ rpa.Ot AS Представитель
--		 ,rpd.rf_idDocumentType
--		 ,rpd.SeriaDocument 
--		 ,RTRIM(rpd.NumberDocument) AS NumberDocument
--		 ,rpd.SNILS 
--		 ,rcp.SeriaPolis 
--		 ,rcp.NumberPolis
--		 ,f.DateRegistration 
--		 ,mo.filialName 
--		 ,f.CodeM 
--		 ,mo.FilialId 
--		 ,mo.MOName 
--		 ,d.DS1 
--		 ,rpd.OKATO
--		 ,rpd.OKATO_Place
--		 ,ra.Account 
--		 ,ra.[DateRegister]
--		 ,rcp.[AttachLPU] 
--	 FROM   dbo.t_File f INNER JOIN #LPU AS mo ON 
--				f.CodeM = mo.CodeM 
--						INNER JOIN dbo.t_RegistersAccounts ra ON 
--				f.id=ra.rf_idFiles 				
--						INNER JOIN dbo.t_RecordCasePatient AS rcp ON 
--				ra.id=rcp.rf_idRegistersAccounts
--						INNER JOIN dbo.t_Case c ON 
--				rcp.id=c.rf_idRecordCasePatient 
--						INNER JOIN dbo.t_RegisterPatient AS rp ON 
--				rp.rf_idRecordCase=rcp.id
--						INNER JOIN dbo.vw_Diagnosis d ON
--				c.id=d.rf_idCase                  
--						LEFT JOIN dbo.t_RegisterPatientAttendant rpa ON
--				rp.id=rpa.rf_idRegisterPatient 
--						LEFT JOIN dbo.t_RegisterPatientDocument AS rpd ON 
--				rpd.rf_idRegisterPatient = rp.id          														
--	WHERE  f.id=@p_AccountCode
				
-- END
--ELSE 
-----------------------------------------------------------------------------------
--IF ( @p_AccountCode IS NULL ) 
--BEGIN
   
                    
--	SELECT @p_FilialCode =CASE WHEN @p_FilialCode = -1 THEN NULL ELSE (SELECT filialCode FROM dbo.vw_sprFilial WHERE FilialId=@p_FilialCode) end
--		 ,@p_LPUCode =CASE WHEN @p_LPUCode=-1 AND @p_LPUManualEnteredCode=-1 THEN NULL 
--							WHEN @p_LPUCode=-1 AND @p_LPUManualEnteredCode>-1 THEN @p_LPUManualEnteredCode 
--							WHEN @p_LPUCode>-1 AND @p_LPUManualEnteredCode>-1 THEN @p_LPUManualEnteredCode
--				ELSE @p_LPUCode END
--		,@p_EndDate=@p_EndDate+' 23:59:59'		
		  
   
--	INSERT #LPU
--	SELECT CodeM, [NAMES], filialCode,filialName 
--	FROM dbo.vw_sprT001 
--	WHERE CodeM=ISNULL(@p_LPUCode,codeM) AND filialCode=ISNULL(@p_FilialCode,filialCode)
--	ORDER BY CodeM



 
--SET @Query ='SELECT  c.id AS CaseId
--     ,c.idRecordCase AS Случай  
--     ,c.AmountPayment AS Выставлено 
--     ,c.rf_idV006
--     ,c.rf_idV008
--     ,c.rf_idDirectMO
--     ,CAST(CASE WHEN c.HopitalisationType = 1 THEN ''Плановая'' ELSE ''Экстренная'' END AS varchar(20)) AS [ТипГоспитализации]
--     ,c.rf_idV002
--     ,CAST(CASE WHEN c.IsChildTariff = 0 THEN ''Взрослый'' ELSE ''Детский'' END AS VARCHAR(20)) AS [Тариф]
--     ,c.NumberHistoryCase 
--     ,c.DateBegin 
--     ,c.DateEnd 
--     ,c.rf_idV009
--     ,c.rf_idV012 
--     ,c.rf_idV004
--     ,c.rf_idV010
--     ,rp.Fam + '' '' + rp.Im + '' ''+ ISNULL(rp.Ot,'''') as Пациент      
--     ,rp.rf_idV005
--     ,rp.BirthDay
--     ,c.age 
--     ,rp.BirthPlace 
--     ,rpa.Fam + '' ''+ rpa.Im + '' ''+ rpa.Ot AS Представитель
--     ,rpd.rf_idDocumentType
--     ,rpd.SeriaDocument 
--     ,RTRIM(rpd.NumberDocument) AS NumberDocument
--     ,rpd.SNILS 
--     ,rcp.SeriaPolis 
--     ,rcp.NumberPolis
--     ,f.DateRegistration 
--     ,mo.filialName 
--     ,f.CodeM 
--     ,mo.FilialId 
--     ,mo.MOName 
--	 ,d.DS1 
--     ,rpd.OKATO
--     ,rpd.OKATO_Place
--     ,ra.Account 
--     ,ra.[DateRegister]
--     ,rcp.[AttachLPU] 
-- FROM   dbo.t_File f INNER JOIN #LPU AS mo ON 
--			f.CodeM = mo.CodeM 
--					INNER JOIN dbo.t_RegistersAccounts ra ON 
--			f.id=ra.rf_idFiles 
--			AND ra.PrefixNumberRegister<>''34''
--					INNER JOIN dbo.t_RecordCasePatient AS rcp ON 
--			ra.id=rcp.rf_idRegistersAccounts
--					INNER JOIN dbo.t_Case c ON 
--			rcp.id=c.rf_idRecordCasePatient AND c.DateEnd<'''+@p_EndDate+'''
--					INNER JOIN dbo.t_RegisterPatient AS rp ON 
--			rp.rf_idRecordCase=rcp.id
--					INNER JOIN dbo.vw_Diagnosis d ON
--			c.id=d.rf_idCase                  
--					LEFT JOIN dbo.t_RegisterPatientAttendant rpa ON
--			rp.id=rpa.rf_idRegisterPatient 
--					LEFT JOIN dbo.t_RegisterPatientDocument AS rpd ON 
--			rpd.rf_idRegisterPatient = rp.id          														
--		WHERE  f.DateRegistration >= '''+@p_StartDate+ ''' AND f.DateRegistration <='''+ @p_EndDate+ ''' ' + @p_AdditionalFilter


--INSERT INTO #cte_cases( CaseId ,Случай ,Выставлено ,rf_idV006 ,rf_idV008 ,rf_idDirectMO ,ТипГоспитализации ,rf_idV002 ,Тариф ,NumberHistoryCase ,DateBegin 
--					,DateEnd ,rf_idV009 ,rf_idV012 ,rf_idV004 ,rf_idV010 ,Пациент ,rf_idV005 ,BirthDay ,age ,BirthPlace ,Представитель ,rf_idDocumentType 
--					,SeriaDocument ,NumberDocument ,SNILS ,SeriaPolis ,NumberPolis ,DateRegistration ,filialName ,CodeM ,FilialId ,MOName ,DS1 
--					,OKATO ,OKATO_Place ,Account ,DateRegister ,AttachLPU) 
--EXEC (@Query)
--DROP TABLE #LPU      
--END 

--SELECT  c.CaseId ,
--        c.Случай ,
--        c.Выставлено,
--		v06.Name AS УсловияОказания,
--		v8.Name AS ВидМП,
--		dmo.NAM_MOK AS Направление
--        ,c.ТипГоспитализации 
--        ,v2.name AS Профиль
--        ,c.Тариф 
--		,c.NumberHistoryCase AS НомерКарты 
--		,c.DateBegin AS Начат 
--		,c.DateEnd AS Окончен
--		,v9.Name AS Результат
--        ,v12.Name AS Исход
--        ,v4.Name AS СпециальностьМедРаботника
--        ,v10.Name AS СпособОплаты
--        ,c.Пациент      
--		,v5.Name AS Пол 
--		,c.BirthDay AS ДатаРождения
--        ,c.age AS Возраст 
--		,c.BirthPlace AS МестоРождения
--		,c.Представитель
--		,dt.Name AS ТипДокумента 
--        ,c.SeriaDocument AS Серия 
--        ,c.NumberDocument AS Номер 
--        ,c.SNILS AS СНИЛС 
--		,c.SeriaPolis AS СерияПолиса 
--        ,c.NumberPolis AS НомерПолиса 
--		,c.DateRegistration AS ДатаРегистрации 
--		,c.filialName AS Филиал 
--		,c.CodeM AS CodeMO     
--		,c.FilialId AS CodeFilial 
--		,c.MOName AS МО 
--        ,c.DS1 AS КодДиагноза 
--        ,mkb.Diagnosis AS Диагноз 
--        ,okato1.namel AS АдресРегистрации 
--        ,okato2.namel  AS АдресМестаЖительства 
--        ,c.Account AS accountnumber 
--        ,c.[DateRegister] AS accountdate 
--        ,c.[AttachLPU] AS attachMO
--FROM #cte_cases c  INNER JOIN OMS_NSI.dbo.sprV002 AS v2 ON 
--			c.rf_idV002 = v2.Id
--				  INNER JOIN OMS_NSI.dbo.sprV006 AS v06 ON 
--		    c.rf_idV006 = v06.Id
--				  INNER JOIN OMS_NSI.dbo.sprV008 AS v8 ON 
--			c.rf_idV008 = v8.Id
--				  INNER JOIN OMS_NSI.dbo.sprV010 AS v10 ON 
--		    c.rf_idV010 = v10.Id
--				  INNER JOIN OMS_NSI.dbo.sprV005 AS v5 ON 
--			c.rf_idV005 = v5.Id
--				  INNER JOIN OMS_NSI.dbo.sprMKB AS mkb ON 
--			mkb.DiagnosisCode = c.DS1
--				  INNER JOIN OMS_NSI.dbo.sprMedicalSpeciality AS v4 ON 
--		   ISNULL(c.rf_idV004,0) = v4.Id	        
--				INNER JOIN OMS_NSI.dbo.vw_sprOKATO okato1 on 
--		   ISNULL(c.OKATO,'0')=okato1.okato
--				INNER JOIN OMS_NSI.dbo.vw_sprOKATO okato2 on 
--		   ISNULL(c.OKATO_place,'0')=okato2.okato
--				INNER JOIN OMS_NSI.dbo.sprDocumentType AS dt ON 
--			ISNULL(c.rf_idDocumentType,0) = dt.ID
--				  LEFT JOIN OMS_NSI.dbo.sprMO AS dmo ON 
--		    c.rf_idDirectMO=dmo.mcod 
--				  LEFT JOIN OMS_NSI.dbo.sprV009 AS v9 ON 
--		   c.rf_idV009 = v9.Id
--				LEFT JOIN OMS_NSI.dbo.sprV012 AS v12 ON 
--		   c.rf_idV012 = v12.Id


  
  
GO
GRANT EXECUTE ON  [dbo].[usp_selectCasesTMP] TO [db_AccountOMS]
GO
