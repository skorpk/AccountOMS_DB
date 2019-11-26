SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE procedure [dbo].[usp_GetCaseFromRegisterCaseDBFilesH2019]
		@account varchar(15)
		,@rf_idF003 char(6)
		,@month tinyint
		,@year smallint
as

declare @number int,
		@property tinyint,
		@smo char(5),
		@letter CHAR(1)
		
select @number=dbo.fn_NumberRegister(@account),@smo=dbo.fn_PrefixNumberRegister(@account),@property=dbo.fn_PropertyNumberRegister(@account),
		@letter=RIGHT(@account,1)

declare @diag as table (rf_idCase bigint,DS0 char(10),DS1 char(10),DS2 char(10))
declare @id int

select @id=reg.id 
from RegisterCases.dbo.t_FileBack f inner join RegisterCases.dbo.t_RegisterCaseBack reg on
			f.id=reg.rf_idFilesBack
			and f.CodeM=@rf_idF003 
where reg.ReportMonth=@month and	reg.ReportYear=@year and reg.NumberRegister=@number and	reg.PropertyNumberRegister=@property

insert #case( ID_Patient ,id ,GUID_Case ,rf_idV006 ,rf_idV008 ,rf_idV014 ,rf_idV018 ,rf_idV019 ,rf_idDirectMO ,HopitalisationType ,rf_idMO ,
			rf_idV002 ,IsChildTariff ,NumberHistoryCase ,DateBegin ,DateEnd ,DS0 ,DS1 ,DS2 ,MES ,rf_idV009 ,rf_idV012 ,rf_idV004 ,IsSpecialCase ,
			rf_idV010 ,Quantity ,Tariff ,AmountPayment ,SANK_MEK ,SANK_MEE ,SANK_EKMP ,Emergency ,Comments ,IT_SL ,P_PER,IDDOCT, rf_idSubMO,
			rf_idDepartmentMO,MSE,C_ZAB,DS_ONK,SL_ID,VB_P ,DATE_Z_1 , DATE_Z_2 ,  KD_Z ,SUMV, KD )
SELECT DISTINCT UPPER(t.ID_Patient),t.id		
		,t.GUID_ZSL
		,t.rf_idV006,t.rf_idV008,t.rf_idV014,t.rf_idV018,t.rf_idV019,t.rf_idDirectMO,t.HopitalisationType,t.rf_idMO
			,t.rf_idV002,t.IsChildTariff,t.NumberHistoryCase,t.DateBegin,t.DateEnd,d.DS0
		,d.DS1
		,NULL AS DS2	
		,mes.MES
		,t.rf_idV009
		,t.rf_idV012
		,t.rf_idV004
		,t.IsSpecialCase
		,t.rf_idV010
		,mes.Quantity
		,mes.Tariff
		,t.AmountPayment
		,t.SANK_MEK
		,t.SANK_MEE
		,t.SANK_EKMP
		,t.[Emergency]
		,t.Comments
		,t.IT_SL
		,t.TypeTranslation
		,t.rf_idDoctor
		,t.rf_idSubMO
		,rf_idDepartmentMO
		,t.MSE
		,t.C_ZAB
		,ds.DS_ONK
		,t.GUID_Case
		,t.VB_P
		,t.DateBegin_ZSL
		,t.DateEnd_ZSL		
		,t.HospitalizationPeriod
		,t.AmountPayment_ZSL
		,KD
from (
		select rc.ID_Patient
				,c.id
				,c.GUID_Case
				,c.rf_idV006,c.rf_idV008
				,c.rf_idV014,c.rf_idV018,c.rf_idV019
				,c.rf_idDirectMO,c.HopitalisationType,
				c.rf_idMO,c.rf_idV002,c.IsChildTariff,c.NumberHistoryCase,c.DateBegin,c.DateEnd		
				,c.rf_idV009
				,c.rf_idV012
				,c.rf_idV004
				,c.IsSpecialCase
				,c.rf_idV010
				,c.AmountPayment
				,0.00 as SANK_MEK
				,0.00 as SANK_MEE
				,0.00 as SANK_EKMP
				,c.[Emergency]
				,c.Comments
				,c.IT_SL
				,c.TypeTranslation
				,c.rf_idDoctor, c.rf_idSubMO, c.rf_idDepartmentMO,c.MSE,c.C_ZAB
				,cc.GUID_ZSL,cc.DateBegin AS DateBegin_ZSL,cc.DateEnd AS DateEnd_ZSL,cc.VB_P,cc.HospitalizationPeriod,cc.AmountPayment AS AmountPayment_ZSL
				,c.KD
		from RegisterCases.dbo.t_FileBack f inner join RegisterCases.dbo.t_RegisterCaseBack reg on
					f.id=reg.rf_idFilesBack
					and reg.id=@id
									inner join RegisterCases.dbo.t_RecordCaseBack rec on
						reg.id=rec.rf_idRegisterCaseBack 				
									inner join RegisterCases.dbo.t_PatientBack p on
						rec.id=p.rf_idRecordCaseBack and
						p.rf_idSMO=@smo
									inner join RegisterCases.dbo.t_CaseBack cb on
						rec.id=cb.rf_idRecordCaseBack and
						cb.TypePay=1
									inner join RegisterCases.dbo.t_Case c on
						rec.rf_idCase=c.id
									inner join RegisterCases.dbo.t_RecordCase rc on
						c.rf_idRecordCase=rc.id		
									INNER JOIN RegisterCases.dbo.t_CompletedCase cc ON
						rc.id=cc.rf_idRecordCase						
			) t inner join RegisterCases.dbo.vw_Diagnosis d on
					t.id=d.rf_idCase
				left join RegisterCases.dbo.t_Mes mes on
					t.id=mes.rf_idCase
				LEFT JOIN RegisterCases.dbo.t_DS_ONK_REAB ds ON
					t.id=ds.rf_idCase              


---Вес новорожденных					
INSERT #tBirthWeight(GUID_Case,VNOV_M)
SELECT c.GUID_Case, b.BirthWeight						  	
from #Case c INNER JOIN RegisterCases.dbo.t_BirthWeight b ON
						c.id=b.rf_idCase 
--Диагнозы
INSERT #tDisgnosis(GUID_Case,Code,TypeDiagnosis)														
SELECT c.GUID_Case,d.DiagnosisCode,d.TypeDiagnosis
from #Case c INNER JOIN RegisterCases.dbo.t_Diagnosis d ON
						c.id=d.rf_idCase 
WHERE d.TypeDiagnosis IN(3,4)
--КСЛП
INSERT #tCoeff_0(GUID_Case,CODE_SL,VAL_C)
SELECT c.GUID_Case,co.Code_SL,co.Coefficient
from #Case c INNER JOIN RegisterCases.dbo.t_Coefficient co ON
						c.id=co.rf_idCase
			 INNER JOIN (select MU from vw_sprMuWithParamAccount where AccountParam=@Letter 
						 UNION ALL 
						 select MU from vw_sprCSGWithParamAccount where AccountParam=@Letter) sm ON
						c.Mes=sm.MU         
---Талоны на продовольствия :-)
INSERT #tTalon(GUID_Case, Tal_D, Tal_P,NumberOfTicket)						              
SELECT c.GUID_Case, s.DateHospitalization, s.GetDatePaper, s.NumberTicket
FROM #case c INNER JOIN RegisterCases.dbo.t_SlipOfPaper s ON
		c.id=s.rf_idCase
			 INNER JOIN (select MU from vw_sprMuWithParamAccount where AccountParam=@Letter 
						 UNION ALL 
						 select MU from vw_sprCSGWithParamAccount where AccountParam=@Letter) sm ON
						c.Mes=sm.MU 
WHERE c.rf_idV008=32

INSERT #tmpKiro(GUID_Case,CODE_KIRO, VAL_K )
SELECT c.GUID_Case,k.rf_idKiro,ValueKiro
FROM #case c INNER JOIN RegisterCases.dbo.t_Kiro k ON
		c.id=k.rf_idCase		

INSERT #tmpAddCriterion(GUID_Case,Add_Criterion )
SELECT c.GUID_Case,a.rf_idAddCretiria
FROM #case c INNER JOIN RegisterCases.dbo.t_AdditionalCriterion a ON
		c.id=a.rf_idCase	
		
INSERT #tmpNEXT(GUID_Case,NEXT_VISIT)
SELECT c.GUID_Case,a.DateVizit
FROM #case c INNER JOIN RegisterCases.dbo.t_NextVisitDate a ON
		c.id=a.rf_idCase				

---------------------18.04.2018--------------		
INSERT #tDirectionDate(GUID_Case,NPR_Date)
SELECT c.GUID_Case,a.DirectionDate
FROM #case c INNER JOIN RegisterCases.dbo.t_DirectionDate a ON
		c.id=a.rf_idCase	

INSERT #tProfileOfBed(GUID_Case,PROFIL_K)
SELECT c.GUID_Case,a.rf_idV020
FROM #case c INNER JOIN RegisterCases.dbo.t_ProfileOfBed a ON
		c.id=a.rf_idCase	

INSERT 	#tPurposeOfVisit(GUID_Case,P_CEL,DN)
SELECT c.GUID_Case,a.rf_idV025, a.DN
FROM #case c INNER JOIN RegisterCases.dbo.t_PurposeOfVisit a ON
		c.id=a.rf_idCase

INSERT 	#tCombinationOfSchema(GUID_Case,DKK2)
SELECT c.GUID_Case,a.rf_idV024
FROM #case c INNER JOIN RegisterCases.dbo.t_CombinationOfSchema a ON
		c.id=a.rf_idCase

-------------20.07.2018----------
INSERT #ONK_SL_RC(GUID_Case ,DS1_T ,STAD , ONK_T ,ONK_N ,ONK_M ,MTSTZ ,SOD,K_FR,WEI ,HEI ,BSA )
SELECT c.GUID_CASE,a.DS1_T ,a.rf_idN002 ,a.rf_idN003 ,a.rf_idN004 ,a.rf_idN005 ,a.IsMetastasis ,TotalDose, a.K_FR,a.WEI,a.HEI,a.BSA 
from #case c INNER JOIN RegisterCases.dbo.t_ONK_SL a ON
		c.id=a.rf_idCase

INSERT #B_DIAG_RC(GUID_Case ,DIAG_TIP ,DIAG_CODE , DIAG_RSLT , DIAG_DATE, REC_RSLT )
SELECT c.GUID_CASE, aa.TypeDiagnostic ,aa.CodeDiagnostic ,aa.ResultDiagnostic ,aa.DateDiagnostic, aa.REC_RSLT
from #case c INNER JOIN RegisterCases.dbo.t_ONK_SL a ON
		c.id=a.rf_idCase
				INNER JOIN RegisterCases.dbo.t_DiagnosticBlock aa ON
		a.id=aa.rf_idONK_SL

INSERT #B_PROT_RC(GUID_Case ,PROT ,D_PROT )
SELECT c.GUID_CASE,  aa.Code ,aa.DateContraindications
from #case c INNER JOIN RegisterCases.dbo.t_ONK_SL a ON
		c.id=a.rf_idCase
				INNER JOIN RegisterCases.dbo.t_Contraindications aa ON
		a.id=aa.rf_idONK_SL

INSERT #CONS_RC(GUID_Case ,PR_CONS ,DT_CONS )
SELECT c.GUID_CASE,  aa.PR_CONS, aa.DateCons
from #case c INNER JOIN RegisterCases.dbo.t_Consultation aa ON
		c.id=aa.rf_idCase

INSERT #NAPR_RC(GUID_Case ,NAPR_DATE ,NAPR_V ,MET_ISSL ,NAPR_USL,NAPR_MO )
SELECT c.GUID_CASE,  a.DirectionDate ,a.TypeDirection ,a.MethodStudy ,a.DirectionMU,a.DirectionMO
from #case c INNER JOIN RegisterCases.dbo.t_DirectionMU a ON
		c.id=a.rf_idCase

INSERT #ONK_USL_RC(GUID_Case ,USL_TIP, HIR_TIP , LEK_TIP_L ,LEK_TIP_V ,LUCH_TIP,PPTR)      
SELECT c.GUID_CASE,u.rf_idN013 ,u.TypeSurgery ,u.TypeDrug ,u.TypeCycleOfDrug ,u.TypeRadiationTherapy, u.PPTR  
from #case c INNER JOIN RegisterCases.dbo.t_ONK_USL u ON
		c.id=u.rf_idCase

INSERT #LEK_PR_RC(GUID_Case ,USL_TIP, REGNUM,DATE_INJ,CODE_SH)		
SELECT c.Guid_Case, u.rf_idN013, u.rf_idV020,u.DateInjection, u.rf_idV024
from #case c INNER JOIN RegisterCases.dbo.t_DrugTherapy u ON
		c.id=u.rf_idCase
		              
INSERT #SL_K_RC(Guid_Case,SL_K)
SELECT c.Guid_Case, u.SL_K
from #case c INNER JOIN RegisterCases.dbo.t_SLK u ON
		c.id=u.rf_idCase

INSERT #MES_RC(GUID_Case,MES,TypeMES)
SELECT c.Guid_Case, u.MES,u.TypeMES
from #case c INNER JOIN RegisterCases.dbo.t_MES u ON
		c.id=u.rf_idCase
GO
GRANT EXECUTE ON  [dbo].[usp_GetCaseFromRegisterCaseDBFilesH2019] TO [db_AccountOMS]
GO
