SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE proc [dbo].[usp_TestAccountDataLPUFileF_Test]
			@doc xml,
			@patient xml,
			--@file varbinary(max),
			@fileName varchar(26),
			@fileKey varbinary(max)=null--файл цифровой подписи
AS
SET XACT_ABORT ON
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;

DECLARE @idoc int,
		@ipatient int,
		@id int,
		@idFile int--,
		--@error tinyint=0

---create tempory table----------------------------------------------

declare @t1 as table([VERSION] char(5),DATA date,[FILENAME] varchar(26),SD_Z INT)

declare @t2 as table(
					 CODE bigint,
					 CODE_MO int,
					 [YEAR] smallint,
					 [MONTH] tinyint,
					 NSCHET nvarchar(15),
					 DSCHET date,
					 PLAT nvarchar(5),
					 SUMMAV decimal(15, 2),
					 COMENTS nvarchar(250)
					 ) 

create table #t3 
(
	N_ZAP int,
	PR_NOV tinyint,
	ID_PAC nvarchar(36),
	VPOLIS tinyint,
	ENP VARCHAR(16),  --new
	ST_OKATO VARCHAR(5),--new
	SPOLIS nchar(10),
	NPOLIS nchar(20),
	SMO nchar(5),
	SMO_OK nchar(5),
	SMO_NAM nvarchar(100),
	NOVOR nchar(9),
	MO_PR nchar(6)
)


create table #t5
(
	N_ZAP int,
	ID_PAC nvarchar(36),
	IDCASE bigint,
	ID_C UNIQUEIDENTIFIER,
	DISP NVARCHAR(3),
	USL_OK tinyint,
	VIDPOM smallint,
	FOR_POM tinyint,
	LPU nchar(6),
	LPU_1 nchar(8),
	PROFIL smallint,
	VBR tinyint, 
	NHISTORY nvarchar(50), 
	P_OTK TINYINT,
	DATE_1 date,
	DATE_2 date,
	DS1 nchar(10),
	DS1_PR TINYINT, 
	PR_D_N TINYINT,
	CODE_MES1 nchar(20),
	RSLT smallint,
	ISHOD smallint,
	PRVS bigint,
	IDDOCT VARCHAR(25),
	IDSP TINYINT,
	ED_COL numeric(5, 2),
	TARIF numeric(15, 2),
	SUMV numeric(15, 2),
	COMENTSL nvarchar(250),
	DS_ONK TINYINT --изменения от 16.07.2018
)
		
--16.07.2018		
CREATE TABLE #tPrescription(IDCASE int,ID_C UNIQUEIDENTIFIER, NAZR TINYINT, NAZ_SP SMALLINT,NAZ_V TINYINT,NAZ_PMP SMALLINT, NAZ_PK SMALLINT,NAZ_N TINYINT)
 
CREATE TABLE #tDS2_N(IDCASE int,ID_C UNIQUEIDENTIFIER,DS2 VARCHAR(10), DS2_PR bit, PR_D TINYINT)   				 
					 

create table #t6(IDCASE int,ID_C uniqueidentifier,IDSERV nvarchar(36),ID_U uniqueidentifier,LPU nchar(6),PROFIL smallint,
			DATE_IN date,DATE_OUT date,P_OTK TINYINT,
			CODE_USL nchar(20),KOL_USL numeric(6, 2),TARIF numeric(15, 2),SUMV_USL numeric(15, 2),
			PRVS bigint,COMENTU nvarchar(250),CODE_MD VARCHAR(25)
			)

					   
declare @t7 as table([VERSION] nchar(5),DATA date,[FILENAME] nchar(26),FILENAME1 nchar(26))

create table #t8 (ID_PAC nvarchar(36),FAM nvarchar(40),IM nvarchar(40),OT nvarchar(40),W tinyint,DR date, TEL VARCHAR(10)
				 ,FAM_P nvarchar(40),IM_P nvarchar(40),OT_P nvarchar(40),
				  W_P tinyint,DR_P DATE
				  ,DOST_P TINYINT
				  ,MR nvarchar(100),DOCTYPE nchar(2),DOCSER nchar(10),DOCNUM nchar(20),SNILS nchar(14),OKATOG nchar(11),OKATOP nchar(11),
				  COMENTP nvarchar(250))

CREATE TABLE #tDost(ID_PAC nvarchar(36),DOST TINYINT, IsAttendant BIT)


declare @tempID as table(id int, ID_PAC nvarchar(36),N_ZAP int)

declare @tableId as table(id int,ID_PAC nvarchar(36))
---------------------------------------------------------------------
EXEC sp_xml_preparedocument @idoc OUTPUT, @doc

insert @t1
SELECT [version],REPLACE(DATA,'-',''),[FILENAME],SD_Z
FROM OPENXML (@idoc, 'ZL_LIST/ZGLV',2)
	WITH(
			[VERSION] NCHAR(5) './VERSION',
			[DATA] NCHAR(10) './DATA',
			[FILENAME] NCHAR(26) './FILENAME',
			SD_Z INT './SD_Z'
		)

DECLARE @Version CHAR(5)
SELECT @Version=[VERSION] FROM @t1
	
insert @t2
select CODE,CODE_MO,[YEAR],[MONTH],NSCHET,replace(DSCHET,'-',''),PLAT,SUMMAV,COMENTS
FROM OPENXML (@idoc, 'ZL_LIST/SCHET',2)
	WITH 
	(	
		CODE bigint './CODE',
		CODE_MO int './CODE_MO',
		[YEAR]	smallint './YEAR',
		[MONTH] tinyint './MONTH',
		NSCHET nvarchar(15) './NSCHET',
		DSCHET nchar(10) './DSCHET',
		PLAT nvarchar(5) './PLAT',
		SUMMAV decimal(15,2) './SUMMAV',
		COMENTS nvarchar(250) './COMENTS'		
	)
PRINT '#t3 start'
--добавил Вес новорожденного 13.01.2014

insert #t3( N_ZAP ,PR_NOV ,ID_PAC ,VPOLIS ,SPOLIS ,NPOLIS ,ENP ,ST_OKATO ,SMO ,SMO_OK ,SMO_NAM ,NOVOR ,MO_PR)
SELECT N_ZAP,PR_NOV,ID_PAC,VPOLIS,SPOLIS,NPOLIS,ENP,ST_OKATO,SMO,SMO_OK,SMO_NAM,NOVOR,MO_PR
FROM OPENXML (@idoc, 'ZL_LIST/ZAP/PACIENT',2)
	WITH(
			N_ZAP int '../N_ZAP',
			PR_NOV tinyint '../PR_NOV',
			ID_PAC nvarchar(36),
			VPOLIS tinyint ,
			SPOLIS nchar(10),
			NPOLIS nchar(20),
			ENP VARCHAR(16),
			ST_OKATO VARCHAR(5),
			SMO nchar(5) ,
			SMO_OK nchar(5),
			SMO_NAM nvarchar(100),
			NOVOR nchar(9),
			MO_PR nchar(6)			
		)
PRINT '#t3 end'

insert #t5( N_ZAP, ID_PAC ,IDCASE ,ID_C ,DISP ,USL_OK ,VIDPOM ,FOR_POM ,LPU ,PROFIL ,VBR ,NHISTORY ,P_OTK ,DATE_1 ,DATE_2 ,DS1 ,
			DS1_PR ,PR_D_N ,CODE_MES1 ,RSLT ,ISHOD ,PRVS ,IDDOCT ,IDSP ,ED_COL ,TARIF ,SUMV ,COMENTSL,LPU_1, DS_ONK)
SELECT     N_ZAP,ID_PAC, IDCASE, ID_C, DISP, USL_OK, VIDPOM,FOR_POM, LPU,PROFIL, VBR, NHISTORY,P_OTK,replace(DATE_1,'-',''),replace(DATE_2,'-',''),DS1
		   ,DS1_PR, PR_D_N, CODE_MES1,RSLT,ISHOD,PRVS, IDDOKT,IDSP,ED_COL,TARIF,SUMV,COMENTSL,LPU_1, DS_ONK
FROM OPENXML (@idoc, 'ZL_LIST/ZAP/SLUCH',3)
	WITH(
			N_ZAP int '../N_ZAP',
			ID_PAC nvarchar(36) '../PACIENT/ID_PAC',
			IDCASE bigint ,
			ID_C uniqueidentifier,
			DISP NVARCHAR(3),
			USL_OK tinyint ,
			VIDPOM smallint,
			FOR_POM tinyint,			
			LPU nchar(6) ,
			LPU_1 nchar(8) ,
			PROFIL smallint,	
			VBR TINYINT,		
			NHISTORY nvarchar(50) ,
			P_OTK tinyint,
			DATE_1 nchar(10) ,
			DATE_2 nchar(10) ,
			DS1 nchar(10) ,			
			DS1_PR tinyint,
			PR_D_N tinyint,
			CODE_MES1 nchar(20) ,			
			RSLT smallint ,
			ISHOD smallint,
			PRVS bigint ,			
			IDSP TINYINT ,
			ED_COL DECIMAL(5,2) ,
			TARIF DECIMAL(15,2) ,	
			SUMV DECIMAL(15,2) ,				
			COMENTSL NVARCHAR(250),				
			IDDOKT VARCHAR(25),
			DS_ONK TINYINT				
		)
PRINT '#t5 end'		
---множественность диагнозов		
INSERT #tDS2_N( IDCASE, ID_C, DS2, DS2_PR, PR_D )
SELECT IDCASE,ID_C,DS2,DS2_PR,PR_D
FROM OPENXML (@idoc, '/ZL_LIST/ZAP/SLUCH/DS2_N',3)
WITH(
			IDCASE int '../IDCASE',
			ID_C uniqueidentifier '../ID_C',			
			DS2 nchar(10)  ,
			DS2_PR bit,
			PR_D tinyint
	)

--SELECT * FROM #tDS2_N
	
----16.07.2018	
--INSERT #tPrescription( IDCASE ,ID_C ,NAZR ,NAZ_SP ,NAZ_V ,NAZ_PMP ,NAZ_PK,NAZ_N)
--SELECT IDCASE ,ID_C ,NAZ_R ,NAZ_SP ,NAZ_V ,NAZ_PMP ,NAZ_PK, NAZ_N
--FROM OPENXML (@idoc, '/ZL_LIST/ZAP/SLUCH/PRESCRIPTION/PRESCRIPTIONS',3)
--WITH(
--			IDCASE int '../../IDCASE',
--			ID_C uniqueidentifier '../../ID_C',			
--			NAZ_N TINYINT,
--			NAZ_R TINYINT,
--			NAZ_SP SMALLINT,
--			NAZ_V TINYINT,
--			NAZ_PMP SMALLINT,
--			NAZ_PK SMALLINT
--  )   
IF @Version!='2.12'
begin
INSERT #tPrescription( IDCASE ,ID_C ,NAZR ,NAZ_SP ,NAZ_V ,NAZ_PMP ,NAZ_PK,NAZ_N)
SELECT IDCASE ,ID_C ,NAZ_R ,NAZ_SP ,NAZ_V ,NAZ_PMP ,NAZ_PK, NAZ_N
FROM OPENXML (@idoc, '/ZL_LIST/ZAP/SLUCH/PRESCRIPTION/PRESCRIPTIONS',3)
WITH(
			IDCASE int '../../IDCASE',
			ID_C uniqueidentifier '../../ID_C',			
			NAZ_N TINYINT,
			NAZ_R TINYINT,
			NAZ_SP SMALLINT,
			NAZ_V TINYINT,
			NAZ_PMP SMALLINT,
			NAZ_PK SMALLINT
  )          
END 
ELSE 
BEGIN
INSERT #tPrescription( IDCASE ,ID_C ,NAZR ,NAZ_SP ,NAZ_V ,NAZ_PMP ,NAZ_PK)
SELECT IDCASE ,ID_C ,NAZR ,NAZ_SP ,NAZ_V ,NAZ_PMP ,NAZ_PK
FROM OPENXML (@idoc, '/ZL_LIST/ZAP/SLUCH/PRESCRIPTION/PRESCRIPTIONS',3)
WITH(
			IDCASE int '../../IDCASE',
			ID_C uniqueidentifier '../../ID_C',			
			NAZR TINYINT,
			NAZ_SP SMALLINT,
			NAZ_V TINYINT,
			NAZ_PMP SMALLINT,
			NAZ_PK SMALLINT
  )          
END                

--SELECT * FROM #tPrescription            
		
insert #t6
SELECT IDCASE,ID_C,IDSERV,ID_U,LPU,PROFIL,
		replace(DATE_IN,'-',''),replace(DATE_OUT,'-',''),P_OTK
		,CODE_USL,KOL_USL,TARIF,SUMV_USL,PRVS,COMENTU,CODE_MD
FROM OPENXML (@idoc, 'ZL_LIST/ZAP/SLUCH/USL',3)
	WITH(
			IDCASE int '../IDCASE',
			ID_C uniqueidentifier '../ID_C',
			IDSERV nvarchar(36) ,
			ID_U uniqueidentifier ,
			LPU nchar(6) ,
			PROFIL smallint,			
			DATE_IN nchar(10),
			DATE_OUT nchar(10),
			P_OTK TINYINT,
			CODE_USL nchar(20),
			KOL_USL DECIMAL(6,2),
			TARIF DECIMAL(15,2) ,	
			SUMV_USL DECIMAL(15,2),	
			PRVS bigint ,
			COMENTU NVARCHAR(250),
			CODE_MD VARCHAR(25) 
		)

EXEC sp_xml_removedocument @idoc

---------------Patient----------------------------------
EXEC sp_xml_preparedocument @ipatient OUTPUT, @patient

insert @t7
SELECT [VERSION],replace(DATA,'-',''),[FILENAME],FILENAME1
FROM OPENXML (@ipatient, 'PERS_LIST/ZGLV',2)
	WITH(
			[VERSION] NCHAR(5) './VERSION',
			[DATA] NCHAR(10) './DATA',
			[FILENAME] NCHAR(26) './FILENAME',
			[FILENAME1] NCHAR(26) './FILENAME1'
		)
		
INSERT #t8(ID_PAC, FAM, IM, OT, W, DR, TEL, FAM_P, IM_P, OT_P, W_P, DR_P, MR, DOCTYPE, DOCSER, DOCNUM, SNILS, OKATOG, OKATOP, COMENTP)
SELECT ID_PAC,CASE WHEN LEN(FAM)=0 THEN NULL ELSE FAM END ,CASE WHEN LEN(IM)=0 THEN NULL ELSE IM END ,
		CASE WHEN LEN(OT)=0 THEN NULL ELSE OT END ,W,replace(DR,'-',''), TEL,FAM_P,IM_P,OT_P,W_P,replace(DR_P,'-',''),MR,DOCTYPE,DOCSER,DOCNUM,SNILS,OKATOG,OKATOP,COMENTP
FROM OPENXML (@ipatient, 'PERS_LIST/PERS',2)
	WITH(
			ID_PAC NVARCHAR(36),
			FAM NVARCHAR(40),
			IM NVARCHAR(40),
			OT NVARCHAR(40),
			W TINYINT,
			DR NCHAR(10),
			TEL VARCHAR(10),
			FAM_P NVARCHAR(40),
			IM_P NVARCHAR(40),
			OT_P NVARCHAR(40),
			W_P TINYINT,
			DR_P NCHAR(10),
			MR NVARCHAR(100),
			DOCTYPE NCHAR(2),
			DOCSER NCHAR(10),
			DOCNUM NCHAR(20),
			SNILS NCHAR(14),
			OKATOG NCHAR(11),
			OKATOP NCHAR(11),
			COMENTP NVARCHAR(250)
		)
--SELECT * FROM #t8

--1- Код надежности относится к пациента
--2 Код надежности сопровождающего
INSERT #tDOST(ID_PAC, DOST,IsAttendant)				
SELECT DISTINCT ID_PAC,DOST,1
FROM OPENXML (@ipatient, 'PERS_LIST/PERS/DOST',2)
	WITH(
			ID_PAC NVARCHAR(36) '../ID_PAC',
			DOST tinyint  'text()'
		)

INSERT #tDOST(ID_PAC, DOST,IsAttendant)				
SELECT DISTINCT ID_PAC,DOST,2
FROM OPENXML (@ipatient, 'PERS_LIST/PERS/DOST_P',2)
	WITH(
			ID_PAC NVARCHAR(36) '../ID_PAC',
			DOST TINYINT 'text()'
		)  
EXEC sp_xml_removedocument @ipatient

--select * from @t7
--select * from #t8

declare @account varchar(15),
		@codeMO char(6),
		@month tinyint,
		@year smallint
---26.12.2011----------------------------------------------
select @codeMO=(substring(@fileName,(3),(6))) 
declare @et as table(errorId smallint,id tinyint)
----------------------------------------------------------
--DATA
if exists(select * from @t1 where DATA>GETDATE() ) 
begin
	insert @et values(904,1)
end
if NOT EXISTS(select * from @et)
begin
	if exists(select * from @t2 where DSCHET>GETDATE() ) 
	begin
		insert @et values(904,2)
	end
end
--проверка CODE_MO в теге SCHET
declare @mcodeFile char(6),
		@mcodeSPR char(6)

select @mcodeFile=CODE_MO from @t2
	
	select @mcodeSPR=mcod from dbo.vw_sprT001 where CodeM=@codeMO
	
if(@mcodeFile!=@mcodeSPR)
begin
		insert @et values(904,3)
end
----------------
--NSCHET
if NOT EXISTS(select * from @et)
begin
	select @account=NSCHET,@year=[YEAR],@month=[MONTH] from @t2
	--проверяем счет на соответствие ему реестра СП и ТК. добавить проверку счета на уникальность
	
	if NOT EXISTS(select * from dbo.fn_CheckAccountExistSPTK(@account,@codeMO,@month,@year))
	begin	
		insert @et values(585,4)
	end
	if EXISTS(select * from dbo.fn_CheckAccountExistInDB(@account,@codeMO,@month,@year))
	begin	
		insert @et values(586,5)
	end	
end
-- check parameter of number account
	declare @letter char(1)
	select @letter=right(NSCHET,1) from @t2
if NOT EXISTS(select * from @et)
begin
	
	if NOT EXISTS(select MU from vw_sprMuWithParamAccount where AccountParam=@Letter UNION ALL select MU from vw_sprCSGWithParamAccount where AccountParam=@Letter)
	begin
		insert @et values(590,21)
	end
end
--compare MU with vw_sprMuWithParamAccount by AccountParam
if NOT EXISTS(select * from @et)
begin	
	if EXISTS(select * 
			  from (select CODE_USL from #t6  WHERE Tarif>0 
					union all 
					select CODE_MES1 from #t5 WHERE Tarif>0) m	 						
						 left join (SELECT MU,AccountParam from vw_sprMuWithParamAccount UNION ALL SELECT MU,AccountParam from vw_sprCSGWithParamAccount) s on			  
						m.CODE_USL=s.MU	and ISNULL(AccountParam,@letter)=@Letter 
					where s.MU is null 
			  )
	begin
		insert @et values(590,21)		
	end
end
	
--DSCHET
if NOT EXISTS(select * from @et)
begin	
	declare @dateAccount date
	declare @dateStart date
	
	--проверка на дату счета и дата окончания случая должна принадлежать отчетному месяцу
	select @dateAccount=DSCHET, @dateStart=CAST([YEAR] as CHAR(4))+right('0'+CAST([month] as varchar(2)),2)+'01' from @t2
	
	if EXISTS(select * from #t5 where DATE_2>@dateAccount and DATE_2<@dateStart)
	begin
		insert @et values(587,7)
	end	
end
--SUMMAV
if NOT EXISTS(select * from @et)
begin
	--производим проверку суммы всех случаев и суммы счета	
	if(select SUM(t.SUMV) from #t5 t)!=(select t.SUMMAV from @t2 t)
	begin
		insert @et values(51,8)
	end
end
--N_ZAP
if NOT EXISTS(select * from @et)
begin
	
	if EXISTS(select * from (select ROW_NUMBER() OVER(order by t.N_ZAP asc) as id,t.N_ZAP from #t3 t) t where id<>N_ZAP)
	begin
		insert @et values(530,9)
	end
end
--PR_NOV
--if NOT EXISTS(select * from @et)
--begin
	
--	if EXISTS(select * from #t3 t where t.PR_NOV<>0)
--	begin
--		insert @et values(531,10)
--	end
--end
--ID_PAC
if NOT EXISTS(select * from @et)
begin
	if EXISTS(select * 
			  from #t3 t left join #t8 p on
					t.ID_PAC=p.ID_PAC
			  where p.ID_PAC is null)
	begin
		insert @et values(532,11)
	end
	
	if EXISTS(select * 
			  from #t3 t right join #t8 p on
					t.ID_PAC=p.ID_PAC
			  where t.ID_PAC is null)
	begin
		insert @et values(532,12)
	end
end
declare @number int,
			@property tinyint,
			@smo char(5)

			
if NOT EXISTS(select * from @et)
begin
	select @number=dbo.fn_NumberRegister(@account),@smo=dbo.fn_PrefixNumberRegister(@account),@property=dbo.fn_PropertyNumberRegister(@account)
end
--Поиск некорректных данных с ошибкой 588 в ZAP
if NOT EXISTS(select * from @et)
begin
	
	declare @zapRC int,
			@zapA int
	
	select @zapA=COUNT(*) from #t3
	
	select @zapRC=COUNT(*)
	from (
			select cast(r1.ID_Patient as nvarchar(36)) as ID_Patient,p.rf_idF008,ISNULL(CAST(p.SeriaPolis AS VARCHAR(10)),'') SeriaPolis
					,p.NumberPolis
					,CASE WHEN p.OKATO<>'18000' THEN '34' ELSE p.rf_idSMO END AS rf_idSMO
					,p.OKATO
					,cast(r1.NewBorn as nvarchar(9)) as NewBorn,
					CASE WHEN att.AttachLPU IS NULL THEN isnull(p.AttachCodeM,'000000') WHEN p.OKATO<>'18000' THEN '000000' ELSE att.AttachLPU end as MO_PR
					,r1.BirthWeight,p.ENP, r1.IsNew
			from RegisterCases.dbo.t_FileBack f inner join RegisterCases.dbo.t_RegisterCaseBack a on 
							f.id=a.rf_idFilesBack
							and f.CodeM=@codeMO
							and a.NumberRegister=@number
							and a.PropertyNumberRegister=@property
							AND a.ReportYear=@year
							AND a.ReportMonth=@month
												inner join RegisterCases.dbo.t_RecordCaseBack r on
							a.id=r.rf_idRegisterCaseBack
												INNER JOIN RegisterCases.dbo.t_CaseBack cp ON
							r.id=cp.rf_idRecordCaseBack					
							and cp.TypePay=1
												inner join RegisterCases.dbo.t_RecordCase r1 on
							r.rf_idRecordCase=r1.id
												inner join RegisterCases.dbo.t_PatientBack p on
							r.id=p.rf_idRecordCaseBack
							--and p.rf_idSMO=@smo
												LEFT JOIN RegisterCases.dbo.t_RefCaseAttachLPUItearion2 att ON
							r.rf_idCase=att.rf_idCase
			GROUP BY cast(r1.ID_Patient as nvarchar(36)),p.rf_idF008,ISNULL(CAST(p.SeriaPolis AS VARCHAR(10)),'')
					,p.NumberPolis
					,CASE WHEN p.OKATO<>'18000' THEN '34' ELSE p.rf_idSMO END 
					,p.OKATO,cast(r1.NewBorn as nvarchar(9)) 
					,CASE WHEN att.AttachLPU IS NULL THEN isnull(p.AttachCodeM,'000000') WHEN p.OKATO<>'18000' THEN '000000' ELSE att.AttachLPU end,r1.BirthWeight,p.ENP
					, r1.IsNew
		  ) r inner join #t3 t on
					r.ID_Patient=t.ID_PAC
					and r.rf_idF008=t.VPOLIS
					and r.SeriaPolis=COALESCE(t.SPOLIS,'')
					and r.NumberPolis=t.NPOLIS
					and r.rf_idSMO=t.SMO
					and r.OKATO=COALESCE(t.SMO_OK,'18000')
					and r.NewBorn=t.NOVOR
					and isnull(r.MO_PR,'000000')=t.MO_PR					
					AND ISNULL(r.ENP,'bla-bla')=ISNULL(t.ENP,'bla-bla')
					AND r.IsNew=t.PR_NOV

		
		
	if(@zapRC-@zapA)<>0	
	begin
		insert @et values(588,13)
	end	
end

--Поиск некорректных данных с ошибкой 588 в SLUCH
if NOT EXISTS(select * from @et)
begin
	
	if EXISTS(select * from (select ROW_NUMBER() OVER(order by t.IDCASE asc) as id,t.IDCASE from #t5 t) t where id<>IDCASE)
	begin
		insert @et values(588,14)
	end
end
--проверка на задвоенность ID_C
if NOT EXISTS(select * from @et)
begin  	
	if EXISTS(select ID_C from  #t5 GROUP BY ID_C HAVING COUNT(*)>1)
	begin
		insert @et values(588,30)
	end
end

if NOT EXISTS(select * from @et)
begin
declare @caseRC int,
		@caseA int
	---Изменения от 23.03.2012 заменил функцию на ХП
	---проверяем совпадение по случаям предоставленным МУ и то что должны предоставить
	--считаем количество строк по случаем в файле
select @caseA=count(*)  from #t5 t	
----------2012-12-29
create table #case
(
	ID_Patient varchar(36) NOT NULL,
	id BIGINT,
	GUID_Case uniqueidentifier NOT NULL,
	rf_idV006 tinyint NULL,
	rf_idV008 smallint NULL,
	rf_idV014 TINYINT,	
	rf_idMO char(6) NOT NULL,
	rf_idV002 smallint NOT NULL,
	NumberHistoryCase nvarchar(50) NOT NULL,
	DateBegin date NOT NULL,
	DateEnd date NOT NULL,
	DS1 char(10) NULL,
	DS1_PR tinyint NULL,
	PR_D_N tinyint NULL,
	MES char(16) NULL,
	rf_idV009 smallint NOT NULL,
	rf_idV012 smallint NOT NULL,
	rf_idV004 int NOT NULL,
	rf_idV010 tinyint NOT NULL,
	Quantity decimal(5, 2) NULL,
	Tariff decimal(15, 2) NULL,
	AmountPayment decimal(15, 2) NOT NULL,
	Comments VARCHAR(250),
	IDDOCT varchar(25),
	rf_idSubMO VARCHAR(8)			
)

--new table
CREATE TABLE #tDispInfo(GUID_CASE uniqueidentifier,TypeDisp VARCHAR(3),IsMobileTeam TINYINT,TypeFailure TINYINT, DS_ONK TINYINT)

CREATE TABLE #tDS2_Info(GUID_CASE uniqueidentifier,DiagnosisCode VARCHAR(10) NOT NULL,	IsFirst BIT, IsNeedDisp tinyint)
CREATE TABLE #tPrescriptions(GUID_CASE uniqueidentifier,NAZR TINYINT ,rf_idV015 SMALLINT,TypeExamination TINYINT,rf_dV002 SMALLINT,rf_idV020 SMALLINT, id TINYINT)
-------------------------------------------------------Переделать---------------------------------------
if OBJECT_ID('tempDB..#case',N'U') is not null
begin
	exec dbo.usp_GetCaseFromRegisterCaseDBFilesF @account,@codeMO,@month,@year
end		 
	select @caseRC=COUNT(distinct t.GUID_Case)
	from #case t inner join #t5 t1 on
			ID_PAC=upper(t.ID_Patient) 
			and ID_C=t.GUID_Case
			and USL_OK=t.rf_idV006 
			and VIDPOM=t.rf_idV008
			AND ISNULL(FOR_POM,0)=ISNULL(t.rf_idV014,0)			
			and LPU=t.rf_idMO
			and PROFIL=t.rf_idV002
			and NHISTORY =NumberHistoryCase
			and DATE_1=DateBegin
			and DATE_2=DateEnd
			and t1.DS1=t.DS1			
			and isnull(CODE_MES1,0)=isnull(t.MES,0) 
			and RSLT=t.rf_idV009  
			and ISHOD=t.rf_idV012  
			and PRVS=t.rf_idV004  
			and IDSP=t.rf_idV010  
			and isnull(ED_COL,0)=ISNULL(t.Quantity,0) 
			and isnull(TARIF ,0)=ISNULL(t.Tariff,0) 
			AND ISNULL(t.Comments,'bla-bla')=ISNULL(t1.COMENTSL,'bla-bla')
			AND t.IDDOCT =t1.IDDOCT
			AND ISNULL(t.rf_idSubMO,'bla-bla')=ISNULL(t1.LPU_1,'bla-bla') 
			AND t.AmountPayment=t1.SUMV



			if(isnull(@caseRC,0)-isnull(@caseA,0))<>0
			begin
				insert @et values(588,15)
			end
			--16.07.2018			
			IF EXISTS(SELECT * FROM #tPrescription b WHERE NOT EXISTS(SELECT * FROM #tPrescriptions WHERE GUID_Case=b.ID_C AND NAZR=b.NAZR
																		AND ISNULL(rf_idV015,0)=ISNULL(b.NAZ_SP,0) 
																		AND ISNULL(TypeExamination,0)=ISNULL(b.NAZ_V,0) 
																		AND ISNULL(rf_dV002,0)=ISNULL(b.NAZ_PMP,0)
																		AND ISNULL(rf_idV020,0)=ISNULL(b.NAZ_PK,0) 
																		AND ISNULL(id,1)=ISNULL(b.NAZ_N,1) ))
			BEGIN 			
				insert @et values(588,15)

				SELECT 'Error', * FROM #tPrescription b 
				WHERE NOT EXISTS(SELECT * FROM #tPrescriptions WHERE GUID_Case=b.ID_C AND NAZR=b.NAZR
																		AND ISNULL(rf_idV015,0)=ISNULL(b.NAZ_SP,0) 
																		AND ISNULL(TypeExamination,0)=ISNULL(b.NAZ_V,0) 
																		AND ISNULL(rf_dV002,0)=ISNULL(b.NAZ_PMP,0)
																		AND ISNULL(rf_idV020,0)=ISNULL(b.NAZ_PK,0) 
																		AND ISNULL(id,1)=ISNULL(b.NAZ_N,1))
				
				SELECT * FROM #tPrescriptions WHERE GUID_CASE ='454CF772-0EA3-4EB3-90DF-C82B66F502B8'
			END
						
			IF EXISTS(SELECT * FROM #tDS2_N b WHERE NOT EXISTS(SELECT * FROM #tDS2_Info 
																WHERE GUID_Case=b.ID_C AND RTRIM(ISNULL(DiagnosisCode,'bla-bla'))=ISNULL(b.DS2,'bla-bla') 
																		AND ISNULL(IsFirst,9)=ISNULL(b.DS2_PR,9) 
																		AND ISNULL(IsNeedDisp,0)=ISNULL(b.PR_D,0) 
																		))
			BEGIN 		
				
				insert @et values(588,15)
			END
			IF EXISTS(SELECT * FROM #t5 b WHERE NOT EXISTS(SELECT * FROM #tDispInfo WHERE GUID_Case=b.ID_C AND TypeDisp=b.DISP
																		AND IsMobileTeam=b.VBR AND TypeFailure=b.P_OTK AND ISNULL(DS_ONK,0)=ISNULL(b.DS_ONK,0) ))--16.07.2018
			BEGIN 		
				insert @et values(588,15)
			END
		          
------------------------------------------------------------------------------------------------			
	
	
end

--Поиск некорректных данных с ошибкой 588 в USL
--проверка на порядок
if NOT EXISTS(select * from @et)
begin
IF @year<2014
BEGIN	
	if EXISTS(select * from (select ROW_NUMBER() OVER(order by CAST(t.IDSERV AS INT) asc) as id, CAST(t.IDSERV AS INT) AS IDSERV from #t6 t) t where id<>IDSERV)
	begin			
		select * from (select ROW_NUMBER() OVER(order by CAST(t.IDSERV AS INT) asc) as id, CAST(t.IDSERV AS INT) AS IDSERV from #t6 t) t where id<>IDSERV
		insert @et values(588,16)
	END
END	
end
---------------------------------------переделать медуслуги-------------------------------
if NOT EXISTS(select * from @et)
begin
declare @meduslugiRC int,
		@meduslugiA int
--внес изменения т.к при зачистке данных в базе Реестров сведений за Страмным удалил хирургические операции.
	select @meduslugiA=count(DISTINCT ID_U) from #t6 t 
	
	CREATE TABLE #meduslugi 
		(
			GUID_Case uniqueidentifier NOT NULL,
			id int NOT NULL,
			GUID_MU uniqueidentifier NOT NULL,
			rf_idMO char(6) NOT NULL,
			rf_idV002 smallint NULL,
			rf_idV001 VARCHAR(15), --пусто
			IsChildTariff bit NULL,	  --пусто
			DateHelpBegin date NOT NULL,
			DateHelpEnd date NOT NULL,
			DiagnosisCode char(10) NULL, --пусто
			MUCode varchar(16) NOT NULL,
			Quantity decimal(6, 2) NOT NULL,
			Price decimal(15, 2) NOT NULL,
			TotalPrice decimal(15, 2) NOT NULL,
			rf_idV004 int NOT NULL,
			Comments VARCHAR(250),
			rf_idDoctor VARCHAR(25),
			P_OTK tinyint,
			rf_idDepartmentMO int,
			rf_idSubMO varchar(6)
		)	
	EXEC usp_GetMeduslugiFromRegisterCaseDB @account
	
	select @meduslugiRC=COUNT(distinct t0.GUID_MU)
	from #meduslugi t0 inner join #t6 t on
			ID_C=t0.GUID_Case
			and ID_U= GUID_MU
			and LPU=rf_idMO
			and PROFIL=rf_idV002
			and DATE_IN =DateHelpBegin
			and DATE_OUT =DateHelpEnd
			AND t.P_OTK=t0.P_OTK
			and rtrim(CODE_USL)=rtrim(MUCode)
			and KOL_USL= Quantity
			and TARIF=Price
			and SUMV_USL =TotalPrice
			and PRVS=rf_idV004
			AND ISNULL(t0.Comments,'bla-bla')=ISNULL(t.COMENTU,'bla-bla')
			AND ISNULL(rf_idDoctor,'0')=ISNULL(t.CODE_MD,'0')
			
	DROP TABLE #meduslugi
	if(isnull(@meduslugiRC,0)-isnull(@meduslugiA,0))<>0
	begin
		insert @et values(588,17)
	end
end

--проверка на кооректное выставление мед.услуг в случае
if NOT EXISTS(select * from @et)
begin
	if EXISTS(	
				select c.ID_C,c.SUMV
				from #t5 c inner join #t6 m on 
						c.ID_C=m.ID_C
						and c.IDCASE=m.IDCASE
				where c.CODE_MES1 is null
				group by c.ID_C,c.SUMV
				having c.SUMV<>cast(SUM(m.KOL_USL*m.TARIF) as decimal(15,2))
			  )	
	begin
			insert @et values(588,18)
	end
end

if NOT EXISTS(select * from @et)
begin
---------поиск случаев без медуслуг
	if EXISTS(	
				select c.* 
				from #t5 c left join #t6 m on 
						c.ID_C=m.ID_C
						and c.IDCASE=m.IDCASE
				where c.CODE_MES1 is null and m.ID_U is null
			  )	
	begin
		insert @et values(588,19)
	end
END
----------01.04.2013
if NOT EXISTS(select * from @et)
begin
---------поиск случаев без медуслуг для ЗС с кодом 2.78.*; 70.*.*;72.*.*
	if EXISTS(	
				select c.* 
				from #t5 c INNER JOIN (SELECT MU FROM vw_sprMUCompletedCase WHERE MUGroupCode=2 AND MUUnGroupCode=78
										UNION ALL
										SELECT MU FROM vw_sprMUCompletedCase WHERE MUGroupCode=70
										UNION ALL
										SELECT MU FROM vw_sprMUCompletedCase WHERE MUGroupCode=72
										) mc ON
						c.CODE_MES1=mc.MU
							left join #t6 m on 
						c.ID_C=m.ID_C
						and c.IDCASE=m.IDCASE
				where c.CODE_MES1 IS NOT NULL and m.ID_U is null
			  )	
	begin
		insert @et values(588,19)
	end
end
---------------------------------Проверка данных из файла L----------------------------------------------------------------------
if NOT EXISTS(select * from @et)
begin
	declare @persA int,
			@persRC int,	
			@idf int
--------не верна работала выборка файла. не был учтен отчетный год			
	select top 1 @idf=f.rf_idFiles
	from RegisterCases.dbo.t_FileBack f inner join RegisterCases.dbo.t_RegisterCaseBack a on 
				f.id=a.rf_idFilesBack
				and f.CodeM=@codeMO
				and a.NumberRegister=@number
				and a.PropertyNumberRegister=@property
				AND a.ReportYear=@year
				
	select @persRC=COUNT(*) 
	from(
			select distinct r1.ID_Patient,rp.Fam,rp.Im,rp.Ot,rp.rf_idV005 as W,rp.BirthDay as DR,ra.Fam as Fam_P, ra.Im as IM_P, ra.Ot as Ot_P,ra.rf_idV005 as W_P,
				  ra.BirthDay as DR_P, rp.BirthPlace as MR, doc.rf_idDocumentType as DOCTYPE, doc.SeriaDocument as DOCSER, doc.NumberDocument as DOCNUM, 
				  doc.SNILS, doc.OKATO as OKATOG, doc.OKATO_Place as OKATOP, rp.TEL
			from RegisterCases.dbo.t_FileBack f inner join RegisterCases.dbo.t_RegisterCaseBack a on 
				f.id=a.rf_idFilesBack
				and f.rf_idFiles=@idF			
									inner join RegisterCases.dbo.t_RecordCaseBack r on
				a.id=r.rf_idRegisterCaseBack
									INNER JOIN RegisterCases.dbo.t_CaseBack cp ON
				r.id=cp.rf_idRecordCaseBack					
				and cp.TypePay=1
									inner join RegisterCases.dbo.t_RecordCase r1 on
				r.rf_idRecordCase=r1.id
									inner join RegisterCases.dbo.t_PatientBack p on
				r.id=p.rf_idRecordCaseBack
				and p.rf_idSMO=@smo
									inner join RegisterCases.dbo.t_RefRegisterPatientRecordCase rf on				
				r1.id=rf.rf_idRecordCase
									inner join RegisterCases.dbo.t_RegisterPatient rp on
				rf.rf_idRegisterPatient=rp.id
				and rp.rf_idFiles=@idF
									left join RegisterCases.dbo.t_RegisterPatientAttendant ra on
				rp.id=ra.rf_idRegisterPatient
									left join RegisterCases.dbo.t_RegisterPatientDocument doc on
				rp.id=doc.rf_idRegisterPatient
		) t inner join #t8 t1 on
			t.ID_Patient=t1.ID_PAC
			and ISNULL(t.FAM,'НЕТ') =ISNULL(t1.FAM,'НЕТ') 
			and ISNULL(t.IM,'НЕТ') =ISNULL(t1.IM,'НЕТ') 
			and ISNULL(t.OT,'НЕТ')=ISNULL(t1.OT,'НЕТ')
			and t.W =t1.W 
			and t.DR =t1.DR 
			and isnull(t.FAM_P,'')=isnull(t1.FAM_P,'')
			and isnull(t.IM_P,'')=isnull(t1.IM_p,'')
			and isnull(t.OT_P,'') =isnull(t1.OT_P,'') 
			--and isnull(t.W_P,'') =isnull(t1.W_P,'') 
			and isnull(t.DR_P,'') =isnull(t1.DR_P,'') 
			and isnull(t.MR,'') =isnull(t1.MR,'') 
			and isnull(t.DOCTYPE,'')=isnull(t1.DOCTYPE,'')
			and isnull(t.DOCSER,'') =isnull(t1.DOCSER,'') 
			and isnull(t.DOCNUM,'') =isnull(t1.DOCNUM,'') 
			and isnull(t.SNILS,'') =isnull(t1.SNILS,'') 
			and isnull(t.OKATOG,'') =isnull(t1.OKATOG,'') 
			and isnull(t.OKATOP,'') =isnull(t1.OKATOP,'') 
			AND ISNULL(t.TEL,'bla-bla')=ISNULL(t1.TEL,'bla-bla')

	select @persA=COUNT(*) from #t8

	if(@persA-@persRC)<>0	
	begin
		insert @et values(588,20)
	end	
end
-------------------------------------------------------------------------------------------------------

--возвращаем @idFile и 0 или 1 отличное от нуля(0- ошибок нету,  1-ошибки есть)
IF EXISTS (select * from @et)
begin
	insert t_FileError([FileName]) values(@fileName)
	
	set @idFile=SCOPE_IDENTITY()
	
	insert t_Errors(rf_idFileError,ErrorNumber,rf_sprErrorAccount) select distinct @idFile,errorId,id from @et	
	
	select @idFile,1
END

--------------------------------------------

drop table #t3
drop table #t5
drop table #t6
drop table #t8
if OBJECT_ID('tempDB..#case',N'U') is not null
	DROP TABLE #case
if OBJECT_ID('tempDB..#meduslugi',N'U') is not null
	DROP TABLE #meduslugi
if OBJECT_ID('tempDB..#tDispInfo',N'U') is not null
	drop table #tDispInfo
if OBJECT_ID('tempDB..#tDS2_Info',N'U') is not null
	drop table #tDS2_Info
if OBJECT_ID('tempDB..#tPrescriptions',N'U') is not null
	drop table #tPrescriptions
GO
