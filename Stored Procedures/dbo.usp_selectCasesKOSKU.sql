SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[usp_selectCasesKOSKU]
--declare
    @p_StartDate VARCHAR(8)=null,
    @p_EndDate VARCHAR(17)=null,
	@p_StartRepPeriod varchar(6)=null,
	@p_EndRepPeriod varchar(6)=null,
    @p_FilialCode INT = -1,
    @p_MOCode INT = -1,
    @p_MOManualEnteredCode INT = -1,--имеет более высокий приоритет, чем данные в переменной @p_MOCode
	@p_TypeCheckup char,
	@p_StartKOSKUCreationDate VARCHAR(8)=null,
	@p_EndKOSKUCreationDate VARCHAR(17)=null,
    @p_AdditionalFilter NVARCHAR(2000)='',
    @Query NVARCHAR(max)=null

AS

create TABLE #lpu(CodeM CHAR(6),MOName VARCHAR(250), FilialId TINYINT,filialName VARCHAR(50))
                   
SELECT @p_FilialCode =CASE WHEN @p_FilialCode = -1 THEN NULL ELSE (SELECT filialCode FROM dbo.vw_sprFilial WHERE FilialId=@p_FilialCode) end
,@p_MOCode =CASE WHEN @p_MOCode=-1 AND @p_MOManualEnteredCode=-1 THEN NULL 
				  WHEN @p_MOCode=-1 AND @p_MOManualEnteredCode>-1 THEN @p_MOManualEnteredCode 
				  WHEN @p_MOCode>-1 AND @p_MOManualEnteredCode>-1 THEN @p_MOManualEnteredCode ELSE @p_MOCode END
,@p_EndDate = @p_EndDate + ' 23:59:59'		
,@p_EndKOSKUCreationDate = @p_EndKOSKUCreationDate + ' 23:59:59'
		  
   
INSERT #LPU
SELECT CodeM, [NAMES], filialCode,filialName 
FROM dbo.vw_sprT001 
WHERE CodeM=ISNULL(@p_MOCode,codeM) AND filialCode=ISNULL(@p_FilialCode,filialCode)
ORDER BY CodeM
 

create table #t (id bigint,idRecordCase bigint,AmountPayment decimal(15, 2),HospType varchar(10),Tarif varchar(9),NumberHistoryCase nvarchar(50),DateBegin date,DateEnd date,Pac varchar (120),BirthDay date,
				age int, SeriaPolis varchar(10),NumberPolis varchar(20),DateRegistration datetime,CodeM char(6),FilialId smallint,MOName varchar(250),DS1 char(10),Account varchar(15), 
				AccDate date,attachMO char(6),rf_idDoctor varchar(25),NewBorn varchar(9),rf_idV002 smallint,rf_idV006 tinyint,rf_idV008 smallint,rf_idV010 tinyint,rf_idV005 tinyint,rf_idV009 smallint,
				rf_idV012 smallint,rpid int,rf_idV004 int, rcpid bigint/*, Reason varchar(20), infoMEK tinyint, infoMEE varchar(300), infoEKMP varchar(300), deducMEK decimal(15,2), deducMEE decimal(15,2), deducEKMP decimal(15,2)*/)

SET @Query ='
insert #t
SELECT  c.id CaseId
		,c.idRecordCase Случай 	
		,c.AmountPayment Выставлено 
        ,CAST(CASE WHEN c.HopitalisationType = 1 THEN ''Плановая'' ELSE ''Экстренная'' END AS varchar(20)) ТипГоспитализации 
        ,CAST(CASE WHEN c.IsChildTariff = 0 THEN ''Взрослый'' WHEN c.IsChildTariff = 1 THEN ''Детский'' ELSE ''Не указан'' END AS VARCHAR(20)) Тариф 
		,c.NumberHistoryCase НомерКарты 
		,c.DateBegin Начат 
		,c.DateEnd Окончен
        ,rp.Fam + '' '' + rp.Im + '' '' + ISNULL(rp.Ot,'''') Пациент      
		,rp.BirthDay ДатаРождения
		,c.age Возраст 
		,rcp.SeriaPolis СерияПолиса 
		,rcp.NumberPolis НомерПолиса 
		,f.DateRegistration ДатаРегистрации 
		,f.CodeM CodeMO 				
		,mo.FilialId CodeFilial 
		,mo.MOName МО 
        ,d.DS1 КодДиагноза 
		,ra.Account accountnumber 
		,ra.[DateRegister] accountdate 
		,rcp.[AttachLPU] attachMO
		,c.rf_idDoctor СНИЛСВрача
		,RTRIM(rcp.[NewBorn]) NewBorn
		,c.rf_idV002,c.rf_idV006,c.rf_idV008,c.rf_idV010,rp.rf_idV005,c.rf_idV009,c.rf_idV012,rp.id,c.rf_idV004,rcp.id
FROM   dbo.t_File f 
INNER JOIN #LPU AS mo ON f.CodeM = mo.CodeM	
INNER JOIN dbo.t_RegistersAccounts ra ON f.id=ra.rf_idFiles AND ra.PrefixNumberRegister<>''34''
INNER JOIN dbo.t_RecordCasePatient AS rcp ON ra.id=rcp.rf_idRegistersAccounts
INNER JOIN dbo.t_Case c ON rcp.id=c.rf_idRecordCasePatient AND c.DateEnd<'''+@p_EndDate+ '''
INNER JOIN dbo.t_RegisterPatient AS rp ON rp.rf_idRecordCase=rcp.id
INNER JOIN dbo.vw_Diagnosis AS d ON c.id = d.rf_idCase
inner join [dbo].[t_PaymentAcceptedCase2] pac2 on pac2.rf_idCase=c.id and pac2.TypeCheckup='''+@p_TypeCheckup+''' and pac2.[DocumentDate] between '''+@p_StartKOSKUCreationDate+''' and '''+@p_EndKOSKUCreationDate+''' 

																
WHERE 
ra.ReportYearMonth between '''+@p_StartRepPeriod+''' and '''+@p_EndRepPeriod+'''
and f.DateRegistration >= '''+@p_StartDate+ ''' AND f.DateRegistration <='''+ @p_EndDate+ ''' ' + @p_AdditionalFilter+'

group by c.id,c.idRecordCase,c.AmountPayment ,CAST(CASE WHEN c.HopitalisationType = 1 THEN ''Плановая'' ELSE ''Экстренная'' END AS varchar(20))
		,CAST(CASE WHEN c.IsChildTariff = 0 THEN ''Взрослый'' WHEN c.IsChildTariff = 1 THEN ''Детский'' ELSE ''Не указан'' END AS VARCHAR(20))
		,c.NumberHistoryCase,c.DateBegin,c.DateEnd,rp.Fam + '' '' + rp.Im + '' '' + ISNULL(rp.Ot,''''),rp.BirthDay,c.age,rcp.SeriaPolis,rcp.NumberPolis 
		,f.DateRegistration,f.CodeM,mo.FilialId,mo.MOName,d.DS1,ra.Account,ra.[DateRegister],rcp.[AttachLPU],c.rf_idDoctor,RTRIM(rcp.[NewBorn])
		,c.rf_idV002,c.rf_idV006,c.rf_idV008,c.rf_idV010,rp.rf_idV005,c.rf_idV009,c.rf_idV012,rp.id,c.rf_idV004,rcp.id'



--print (@Query)

EXEC (@Query)

select c.*, v6.Name УсловияОказания
,v8.Name ВидПомощи
,v2.name Профиль
,v9.Name Результат
,v12.Name Исход
,v4.Name СпециальностьМедРаботника
,v10.Name СпособОплаты
,v5.Name Пол 
,rpa.Fam + ' ' + rpa.Im + ' ' + rpa.Ot Представитель
,mkb.Diagnosis Диагноз 
,rpd.SNILS СНИЛС
,psmo.ENP 

		,max(case when pac2.TypeCheckup=1 then 1 else 0 end) InfoMEK
		,(SELECT cast(pac2_.[DocumentNumber] as varchar) + ', ' + cast([DocumentDate] as varchar) + ', ' + cast([AmountDeduction] as varchar) +', '+ isnull(rtrim(r.Reason),'') +'; ' FROM [dbo].[t_PaymentAcceptedCase2] pac2_ left join [dbo].[vw_PaymnetMekMeeEkmp_ReasonOneRow] r on pac2_.rf_idCase=r.[rf_idCase] and pac2_.TypeCheckup=r.TypeCheckup and pac2_.idAkt=r.idAkt WHERE pac2_.rf_idCase = c.id and pac2_.TypeCheckup=2 FOR XML PATH('')) InfoMEE 
		,(SELECT cast(pac2_.[DocumentNumber] as varchar) + ', ' + cast([DocumentDate] as varchar) + ', ' + cast([AmountDeduction] as varchar) +', '+ isnull(rtrim(r.Reason),'') +'; ' FROM [dbo].[t_PaymentAcceptedCase2] pac2_ left join [dbo].[vw_PaymnetMekMeeEkmp_ReasonOneRow] r on pac2_.rf_idCase=r.[rf_idCase] and pac2_.TypeCheckup=r.TypeCheckup and pac2_.idAkt=r.idAkt WHERE pac2_.rf_idCase = c.id and pac2_.TypeCheckup=3 FOR XML PATH('')) InfoEKMP
		,sum(case when pac2.TypeCheckup=1 then pac2.[AmountDeduction] end) deducMEK
		,sum(case when pac2.TypeCheckup=2 then pac2.[AmountDeduction] end) deducMEE
		,sum(case when pac2.TypeCheckup=3 then pac2.[AmountDeduction] end) deducEKMP
		,psmo.rf_idSMO SMO

from #t c
INNER JOIN OMS_NSI.dbo.sprV002 AS v2 ON c.rf_idV002 = v2.Id
INNER JOIN OMS_NSI.dbo.sprV006 AS v6 ON c.rf_idV006 = v6.Id
INNER JOIN OMS_NSI.dbo.sprV008 AS v8 ON c.rf_idV008 = v8.Id
INNER JOIN OMS_NSI.dbo.sprV010 AS v10 ON c.rf_idV010 = v10.Id
INNER JOIN OMS_NSI.dbo.sprV005 AS v5 ON c.rf_idV005 = v5.Id
INNER JOIN OMS_NSI.dbo.sprMKB AS mkb ON mkb.DiagnosisCode = c.DS1
inner join [dbo].[t_PaymentAcceptedCase2] pac2 on pac2.rf_idCase=c.id

LEFT JOIN dbo.t_PatientSMO psmo ON psmo.rf_idRecordCasePatient=c.rcpid
LEFT JOIN OMS_NSI.dbo.sprV009 AS v9 ON c.rf_idV009 = v9.Id
LEFT JOIN OMS_NSI.dbo.sprV012 AS v12 ON c.rf_idV012 = v12.Id
LEFT JOIN dbo.t_RegisterPatientAttendant AS rpa ON rpa.rf_idRegisterPatient = c.rpid
LEFT JOIN dbo.t_RegisterPatientDocument AS rpd ON rpd.rf_idRegisterPatient = c.rpid
LEFT JOIN [dbo].[vw_sprMedicalSpeciality] v4 on c.rf_idV004=v4.id AND c.DateEnd>=v4.DateBeg AND c.DateEnd<v4.DateEnd
--where c.id in (80405598,
--80405613,
--80405614)
group by c.id,c.idRecordCase,c.AmountPayment ,HospType,Tarif,c.NumberHistoryCase,c.DateBegin,c.DateEnd,Pac,c.BirthDay,c.age,c.SeriaPolis,c.NumberPolis 
		,c.DateRegistration,c.CodeM,c.FilialId,c.MOName,c.DS1,c.Account,c.AccDate,c.[AttachMO],c.rf_idDoctor,c.[NewBorn]
		,c.rf_idV002,c.rf_idV006,c.rf_idV008,c.rf_idV010,c.rf_idV005,c.rf_idV009,c.rf_idV012,c.rpid,c.rf_idV004,c.rcpid,
		v6.Name,v8.Name,v2.name,v9.Name,v12.Name,v4.Name,v10.Name,v5.Name ,rpa.Fam + ' ' + rpa.Im + ' ' + rpa.Ot,mkb.Diagnosis,rpd.SNILS,psmo.ENP,psmo.rf_idSMO

--select count(distinct id) from #t

--select * from #t1 t1
--inner join(
--select id from #t1
--group by id having count(id)>1) t on t.id=t1.id
--order by t1.id


DROP TABLE #LPU   
DROP TABLE #t   

GO
GRANT EXECUTE ON  [dbo].[usp_selectCasesKOSKU] TO [AccountsOMS]
GO
GRANT EXECUTE ON  [dbo].[usp_selectCasesKOSKU] TO [db_AccountOMS]
GO
