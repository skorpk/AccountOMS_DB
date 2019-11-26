SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE procedure [dbo].[usp_GetMeduslugiFromRegisterCaseDB2019]
		@account varchar(15)		
AS
		DECLARE @letter CHAR(1)
				
		select @letter=dbo.fn_LetterNumberRegister(@account)	
				
		CREATE TABLE #case1(id BIGINT, GUID_Case UNIQUEIDENTIFIER,IsCompletedCase TINYINT,DateEnd date,rf_idV006 tinyint)
		INSERT #case1( id, GUID_Case, IsCompletedCase,DateEnd,rf_idV006 )
		SELECT c.id,c0.GUID_Case,c.IsCompletedCase,c.DateEnd,c.rf_idV006
		from #Case c0 inner join RegisterCases.dbo.t_Case c on
						c0.id=c.id										
		------------------------------------------------------------------------------------------------------------
		insert #meduslugi
		SELECT distinct c.GUID_Case,m.id,m.GUID_MU,m.rf_idMO,m.rf_idV002,m.MUSurgery,m.IsChildTariff,m.DateHelpBegin,m.DateHelpEnd,m.DiagnosisCode,
		m.MUCode,m.Quantity,m.Price,m.TotalPrice,m.rf_idV004,m.Comments,m.rf_idDoctor,m.IsNeedUsl,m.rf_idDepartmentMO,m.rf_idSubMO
		from #case1 c inner join RegisterCases.dbo.t_Meduslugi m on
				c.id=m.rf_idCase				
				--AND c.IsCompletedCase=0
		--				INNER JOIN vw_sprMuWithParamAccount mu ON
		--		m.MUCode=mu.MU
		--WHERE ISNULL(mu.AccountParam,@letter)=@letter
		------------------------------------------------------------------------------------------------------------
		--добавил медуслуги в связи с тем что ввели хирургический койко-день
		insert #meduslugi
		SELECT distinct c.GUID_Case,m.id,m.GUID_MU,m.rf_idMO,m.rf_idV002,m.MUSurgery,m.IsChildTariff,m.DateHelpBegin,m.DateHelpEnd,m.DiagnosisCode,
		m.MUCode,m.Quantity,m.Price,m.TotalPrice,m.rf_idV004,m.Comments,m.rf_idDoctor,m.IsNeedUsl,m.rf_idDepartmentMO,m.rf_idSubMO
		from #case1 c inner join RegisterCases.dbo.t_Meduslugi m on
						c.id=m.rf_idCase						
									inner join oms_NSI.dbo.V001 v on
						m.MUCode=v.IDRB
		------------------------------------------------------------------------------------------------------------
		--добавил медуслуги в связи с тем что ввели хирургический койко-день
		insert #meduslugi
		SELECT DISTINCT  c.GUID_Case,m.id,m.GUID_MU,m.rf_idMO,m.rf_idV002,m.MUSurgery,m.IsChildTariff,m.DateHelpBegin,m.DateHelpEnd,m.DiagnosisCode,
		m.MUCode,m.Quantity,m.Price,m.TotalPrice,m.rf_idV004,m.Comments,m.rf_idDoctor,m.IsNeedUsl,m.rf_idDepartmentMO,m.rf_idSubMO
		from #case1 c inner join RegisterCases.dbo.t_Meduslugi m on
						c.id=m.rf_idCase						
									inner join oms_NSI.dbo.sprDentalMU v on
						m.MUCode=v.code
		WHERE NOT EXISTS(SELECT * FROM OMS_NSI.dbo.V001 WHERE IDRB=v.code)
		------------------------------------------------------------------------------------------------------------				
		insert #meduslugi ----добавление врачебных приемов
		SELECT distinct c.GUID_Case,m.id,m.GUID_MU,m.rf_idMO,m.rf_idV002,m.MUSurgery,m.IsChildTariff,m.DateHelpBegin,m.DateHelpEnd,m.DiagnosisCode,
				m.MUCode,m.Quantity,m.Price,m.TotalPrice,m.rf_idV004,m.Comments,m.rf_idDoctor,m.IsNeedUsl,m.rf_idDepartmentMO,m.rf_idSubMO
		from #case1 c inner join RegisterCases.dbo.t_Meduslugi m on
								c.id=m.rf_idCase					
											inner join RegisterCases.dbo.vw_mes_2_78 mes on
								c.id=mes.rf_idCase
		------------------------------------------------------------------------------------------------------------								
		insert #meduslugi ----добавление случаев по диспансеризации
		SELECT distinct c.GUID_Case,m.id,m.GUID_MU,m.rf_idMO,m.rf_idV002,m.MUSurgery,m.IsChildTariff,m.DateHelpBegin,m.DateHelpEnd,m.DiagnosisCode,
				m.MUCode,m.Quantity,m.Price,m.TotalPrice,m.rf_idV004,m.Comments,m.rf_idDoctor,m.IsNeedUsl,m.rf_idDepartmentMO,m.rf_idSubMO
		from #case1 c inner join RegisterCases.dbo.t_Meduslugi m on
								c.id=m.rf_idCase					
											inner join RegisterCases.dbo.vw_ClinicalExamination mes ON
								c.id=mes.rf_idCase
		------------------------------------------------------------------------------------------------------------						
		insert #meduslugi ----добавление случаев по дневному стационару, с 01.04.2013 дневной стационар идет как ЗС
		SELECT distinct c.GUID_Case,m.id,m.GUID_MU,m.rf_idMO,m.rf_idV002,m.MUSurgery,m.IsChildTariff,m.DateHelpBegin,m.DateHelpEnd,m.DiagnosisCode,
				m.MUCode,m.Quantity,m.Price,m.TotalPrice,m.rf_idV004,m.Comments,m.rf_idDoctor,m.IsNeedUsl,m.rf_idDepartmentMO,m.rf_idSubMO
		from #case1 c inner join RegisterCases.dbo.t_Meduslugi m on
								c.id=m.rf_idCase					
											inner join RegisterCases.dbo.t_Mes mes on
								c.id=mes.rf_idCase																			
		WHERE c.DateEnd>='20130401' and c.rf_idV006=2
		
DROP TABLE #case1
GO
GRANT EXECUTE ON  [dbo].[usp_GetMeduslugiFromRegisterCaseDB2019] TO [db_AccountOMS]
GO
