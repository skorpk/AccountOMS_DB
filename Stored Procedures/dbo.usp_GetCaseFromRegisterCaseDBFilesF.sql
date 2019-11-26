SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE procedure [dbo].[usp_GetCaseFromRegisterCaseDBFilesF]
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

INSERT #case( ID_Patient ,id ,GUID_Case ,rf_idV006 ,rf_idV008 ,rf_idV014 ,rf_idMO ,rf_idV002 ,NumberHistoryCase ,DateBegin ,DateEnd ,DS1 ,DS1_PR ,
			PR_D_N ,MES ,rf_idV009 ,rf_idV012 ,rf_idV004 ,rf_idV010 ,Quantity ,Tariff ,AmountPayment ,Comments,IDDOCT, rf_idSubMO )
SELECT DISTINCT UPPER(t.ID_Patient)
		,t.id
		,t.GUID_Case
		,t.rf_idV006,t.rf_idV008
		,t.rf_idV014
		--,t.rf_idDirectMO
		,t.rf_idMO
		,t.rf_idV002
		,t.NumberHistoryCase
		,t.DateBegin
		,t.DateEnd		
		,d.DS1
		,t.IsFirstDS
		,t.IsNeedDisp	
		,mes.MES
		,t.rf_idV009
		,t.rf_idV012
		,t.rf_idV004
		,t.rf_idV010
		,mes.Quantity
		,mes.Tariff
		,t.AmountPayment		
		,t.Comments
		,t.rf_idDoctor
		,t.rf_idSubMO
from (
		select rc.ID_Patient
				,c.id
				,c.GUID_Case
				,c.rf_idV006
				,c.rf_idV008
				,c.rf_idV014				
				,c.rf_idDirectMO
				,c.rf_idMO
				,c.rf_idV002
				,c.NumberHistoryCase
				,c.DateBegin
				,c.DateEnd	
				,c.IsFirstDS
				,c.IsNeedDisp	
				,c.rf_idV009
				,c.rf_idV012
				,c.rf_idV004
				,c.rf_idV010
				,c.AmountPayment				
				,c.Comments
				,c.rf_idDoctor
				,c.rf_idSubMO
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
			) t inner join RegisterCases.dbo.vw_Diagnosis d on
					t.id=d.rf_idCase
				left join RegisterCases.dbo.t_Mes mes on
					t.id=mes.rf_idCase

INSERT #tDispInfo(GUID_CASE,TypeDisp,IsMobileTeam,TypeFailure,DS_ONK )
select c.GUID_Case,d.TypeDisp,d.IsMobileTeam,d.TypeFailure,d.IsOnko
FROM #case c INNER JOIN RegisterCases.dbo.t_DispInfo d ON
		c.id=d.rf_idCase

INSERT #tDS2_Info(GUID_CASE ,DiagnosisCode,IsFirst, IsNeedDisp )
SELECT GUID_CASE ,DiagnosisCode,IsFirst, IsNeedDisp 
FROM #case c INNER JOIN RegisterCases.dbo.t_DS2_Info d ON
		c.id=d.rf_idCase

INSERT #tPrescriptions(GUID_CASE, NAZR,rf_idV015,TypeExamination,rf_dV002 ,rf_idV020,id)
SELECT GUID_CASE, NAZR,rf_idV015,TypeExamination,rf_dV002 ,rf_idV020, p.id
FROM #case c INNER JOIN RegisterCases.dbo.t_Prescriptions p ON
		c.id=p.rf_idCase
GO
GRANT EXECUTE ON  [dbo].[usp_GetCaseFromRegisterCaseDBFilesF] TO [db_AccountOMS]
GO
