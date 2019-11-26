SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
---- =============================================
----20.10.2016
---- =============================================
CREATE PROCEDURE [dbo].[usp_selectHC_Doubles]
@p_StartRegistrationDate nvarchar(8),
@p_EndRegistrationDate nvarchar(8),
@p_RAKRegistrationDate nvarchar(8),
@reportYear int,
@reportMonth int
AS

SELECT c.id, c.[GUID_Case],
	p.Fam, p.Im, isnull(p.Ot,'') as Ot, r.AttachLPU, p.BirthDay,'' as AttachMoName,
	a.[PrefixNumberRegister], a.[Account], c.[idRecordCase], a.[DateRegister], v009.[Name],
	cast (c.[DateBegin] as varchar(10)) as [DateBegin], cast (c.[DateEnd] as varchar(10)) as [DateEnd], c.AmountPayment, 
	f.CodeM, cast(0 as bigint) as ENP, cast (0 as decimal(6,2)) as AmountPaymentAccept,
	rpa.[Fam] as FamAtt, rpa.[Im] as ImAtt,isnull(rpa.[Ot],'') as OtAtt, 0 as MEK, 0 as MEE, 0 as EKMP
	into #tCase		
	FROM AccountOMS.dbo.t_File f INNER JOIN AccountOMS.dbo.t_RegistersAccounts a ON f.id=a.rf_idFiles					
    INNER JOIN AccountOMS.dbo.t_RecordCasePatient r ON a.id=r.rf_idRegistersAccounts
    INNER JOIN AccountOMS.dbo.t_RegisterPatient p ON f.id=p.rf_idFiles AND r.id=p.rf_idRecordCase
    INNER JOIN AccountOMS.dbo.t_Case c ON r.id=c.rf_idRecordCasePatient
    INNER JOIN AccountOMS.dbo.t_Meduslugi m ON c.id=m.rf_idCase
    INNER JOIN OMS_NSI.dbo.sprV009 v009 on v009.id=c.rf_idv009
    left JOIN [AccountOMS].[dbo].[t_RegisterPatientAttendant] rpa on rpa.[rf_idRegisterPatient]=p.id
	WHERE a.Letter='J' and a.PrefixNumberRegister<>34 AND m.[MUGroupCode] = 2 and m.[MUUnGroupCode] = 76 and m.[MUCode]=5 			
	and
		((
		f.DateRegistration >=@p_StartRegistrationDate and f.DateRegistration<=@p_EndRegistrationDate+' 23:59:59'  AND 
		a.ReportYearMonth < (CONVERT([int],CONVERT([char](4),@reportYear,0)+right('0'+CONVERT([varchar](2),@reportMonth,0),(2)),0))
		and a.ReportYear = @reportYear
		) 
	   OR
	   (
		f.DateRegistration >=(CONVERT([int],CONVERT([char](4),@reportYear,0)+right('0'+CONVERT([varchar](2),@reportMonth,0),(2)),0))+'01' and f.DateRegistration<=@p_EndRegistrationDate+' 23:59:59' AND 
		a.ReportYear = @reportYear AND a.ReportMonth = @reportMonth
	   ))	

UPDATE c SET c.ENP=p.ENP--.[PID]
FROM #tCase c 
INNER JOIN AccountOMS.dbo.t_Case_PID_ENP p ON c.id=p.rf_idCase
				
DELETE
FROM #tCase
WHERE ENP is null or ENP=0--ИНОГОРОДНИЕ 				
-----------------------------------RAK-------------------------------------------------------------------
--БЕЗ ИНОГОРОДНИХ
UPDATE c1 SET c1.AmountPaymentAccept=c1.AmountPayment-p.AmountDeduction
FROM #tCase c1 LEFT JOIN (
        SELECT rf_idCase,SUM(ISNULL(AmountDeduction,0)) AS AmountDeduction
        FROM 
        (
			SELECT rf_idCase, DateRegistration, Letter,
			 ISNULL(AmountEKMP, 0) + ISNULL(AmountMEE, 0) + ISNULL(AmountMEK, 0) AS AmountDeduction
			FROM AccountOMS.dbo.t_PaymentAcceptedCase2
			WHERE DateRegistration >@p_StartRegistrationDate
        ) RAK
        WHERE DateRegistration>=@p_StartRegistrationDate AND DateRegistration<=@p_RAKRegistrationDate+' 23:59:59'  AND Letter='J'        
        GROUP BY rf_idCase
						  ) p ON
				c1.id=p.rf_idCase
--UPDATE c1 SET c1.AmountPaymentAccept=c1.AmountPayment-p.AmountDeduction
--FROM #tCase c1 LEFT JOIN (
--        SELECT rf_idCase,SUM(ISNULL(AmountDeduction,0)) AS AmountDeduction
--        FROM 
--        (
--			SELECT        sc.rf_idCase, f.DateRegistration, sc.AmountPaymentAccept, f.CodeM, RIGHT(a.Account, 1) AS Letter,
--			 ISNULL(sc.AmountEKMP, 0) + ISNULL(sc.AmountMEE, 0) + ISNULL(sc.AmountMEK, 0) AS AmountDeduction
--			FROM            ExchangeFinancing.dbo.t_AFileIn f INNER JOIN
--							ExchangeFinancing.dbo.t_DocumentOfCheckup p ON f.id = p.rf_idAFile INNER JOIN
--							ExchangeFinancing.dbo.t_CheckedAccount a ON p.id = a.rf_idDocumentOfCheckup INNER JOIN
--							ExchangeFinancing.dbo.t_CheckedCase sc ON a.id = sc.rf_idCheckedAccount
--			WHERE f.DateRegistration >@p_StartRegistrationDate
--        ) RAK
--        WHERE DateRegistration>=@p_StartRegistrationDate AND DateRegistration<=@p_RAKRegistrationDate+' 23:59:59'  AND Letter='J'        
--        GROUP BY rf_idCase
--						  ) p ON
--				c1.id=p.rf_idCase				
				
DELETE FROM #tCase
WHERE (AmountPaymentAccept is null) or (AmountPaymentAccept<=0)
---------------------------------------------------------------------------------------------------------	
---------------------------------Проставить признаки по проверкам----------------------------------------
UPDATE c1 SET  c1.MEK = ISNULL(p.MEK,0),c1.MEE = ISNULL(p.MEE,0),c1.EKMP = ISNULL(p.EKMP,0)
FROM #tCase c1 INNER JOIN (
        SELECT rf_idCase,max(MEK) as MEK,max(MEE) as MEE,max(EKMP) as EKMP
        FROM 
        (
			SELECT rf_idCase,
			 case when [TypeCheckup] = 1 then [OrderCheckup] else 0 end as MEK,
			 case when [TypeCheckup] = 2 then [OrderCheckup] else 0 end as MEE,
			 case when [TypeCheckup] = 3 then [OrderCheckup] else 0 end as EKMP
			FROM AccountOMS.dbo.t_PaymentAcceptedCase2
			WHERE DateRegistration >=@p_StartRegistrationDate
        ) Ch
        GROUP BY rf_idCase
						  ) p ON
				c1.id=p.rf_idCase	
--UPDATE c1 SET  c1.MEK = ISNULL(p.MEK,0),c1.MEE = ISNULL(p.MEE,0),c1.EKMP = ISNULL(p.EKMP,0)
--FROM #tCase c1 INNER JOIN (
--        SELECT rf_idCase,max(MEK) as MEK,max(MEE) as MEE,max(EKMP) as EKMP
--        FROM 
--        (
--			SELECT sc.rf_idCase,
--			 case when p.[TypeCheckup] = 1 then [OrderCheckup] else 0 end as MEK,
--			 case when p.[TypeCheckup] = 2 then [OrderCheckup] else 0 end as MEE,
--			 case when p.[TypeCheckup] = 3 then [OrderCheckup] else 0 end as EKMP
--			FROM            ExchangeFinancing.dbo.t_AFileIn f INNER JOIN
--							ExchangeFinancing.dbo.vw_Report_HCDoubles p ON f.id = p.rf_idAFile INNER JOIN
--							ExchangeFinancing.dbo.t_CheckedAccount a ON p.id = a.rf_idDocumentOfCheckup INNER JOIN
--							ExchangeFinancing.dbo.t_CheckedCase sc ON a.id = sc.rf_idCheckedAccount
--			WHERE f.DateRegistration >=@p_StartRegistrationDate
--        ) Ch
--        GROUP BY rf_idCase
--						  ) p ON
--				c1.id=p.rf_idCase				
---------------------------------------------------------------------------------------------------------						
				
				
select cast(c.ENP as varchar(26)) as ENP, cast(c.id as varchar(10)) as 'ID случая', cast(c.[GUID_Case] as varchar(50)) as [GUID_Case]
,isnull(c.Fam +' '+ c.Im + ' '+ isnull(c.Ot,''), c.FamAtt+' '+ c.ImAtt + ' '+ isnull(c.OtAtt,'')) as 'ФИО'
,cast(c.BirthDay as varchar(40)) as 'Дата рождения', tsmo.[sNameS] as 'СМО',c.[Account] as 'Номер счета'
,cast(c.[idRecordCase] as varchar(4)) as 'Номер случая в счете', cast(c.[DateRegister] as varchar(40)) as 'Дата регистрации'
,c.[Name] as 'v009',c.[DateBegin] +' — '+ c.[DateEnd] as 'Сроки лечения', c.AmountPayment as 'Принято к оплате'
,c.MEK,c.MEE,c.EKMP
,c.CodeM as 'код МО', t001.[NameS] as 'Наименование МО'
from #tCase c
inner join [oms_NSI].[dbo].[tSMO] tsmo on tsmo.smocod=c.[PrefixNumberRegister]
INNER JOIN [oms_NSI].[dbo].[vw_sprT001] t001 on t001.[CodeM] = c.CodeM
left JOIN OMS_NSI.dbo.vw_sprT001 T001_2 ON c.AttachLPU = T001_2.CodeM
where ENP in
(
	select ENP from #tCase
	group by ENP
	having count(ENP)>1
)
order by ENP, c.Fam +' '+ c.Im + ' '+ c.Ot


DROP TABLE #tCase


GO
GRANT EXECUTE ON  [dbo].[usp_selectHC_Doubles] TO [AccountsOMS]
GO
GRANT EXECUTE ON  [dbo].[usp_selectHC_Doubles] TO [db_AccountOMS]
GO
