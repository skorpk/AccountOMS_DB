SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE view [dbo].[view_MO_Disp]
AS
SELECT  distinct
		t1.[MOId] AS MOId ,
		LEFT(t1.[tfomsCode], 6) AS tfomsCode ,
        ISNULL(t1.[rf_FirstLvlId], t1.MOId) AS rf_FirstLvlId ,
        t1.[rf_SecondLvlId] ,
        t1.[isFirstLvl] ,
        t1.[canBill] ,
        t.[mcod] ,
        t1.[mNameF] ,
        t1.[mNameS] ,
        t1.[ogrn] ,
        t1.[inn] ,
        t1.[kpp] ,
        t1.[postIndex] ,
        t1.[rf_OKOPFId] ,
        t1.[rf_VPId] ,
        t1.[fam] ,
        t1.[im] ,
        t1.[ot] ,
        t1.[phone] ,
        t1.[fax] ,
        t1.[eMail] ,
        t1.[www] ,
        t1.[beginDate] ,
        t1.[endDate] ,
        t1.[editDate] ,        
        t1.[rf_ExceptionReasonId] ,
        t1.[flag] ,
        t1.[region] ,
        t1.[area] ,
        t1.[city] ,
        t1.[street] ,
        t1.[building] ,
        t1.[corp] ,
        t1.[rf_FilialId] ,
        t1.[rf_CityAreaId],
		b.year as yearExam
FROM    [oms_NSI].[dbo].[tMO] AS t
        INNER JOIN [oms_NSI].[dbo].tMO AS t1 ON t.MOId = ISNULL(t1.rf_FirstLvlId,
																	   t1.MOId)		
		INNER JOIN [oms_NSI].[dbo].tClinicalExamMO b on b.rf_MOId = ISNULL(t1.[rf_FirstLvlId], t1.MOId)
WHERE   t.flag = 'A'
		and b.rf_ClinicalExamTypeId in (1,2)
GO
