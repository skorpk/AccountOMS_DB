SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE VIEW [dbo].[V_KOEF_U]
AS
/*
select isnull(B.mcod, F.mcod) as LPU,
       E.code as LPU_1,
	   C.code as PODR,
	   A.rf_MSConditionId as USL_OK,
	   G.levelPay as LEVEL,
	   A.dateBeg as DATEBEG_LEVEL,
	   A.dateEnd as DATEEND_LEVEL,
	   H.coefficient as KOEF_U,
	   H.dateBeg as DATEBEG_KOEF_U,
	   H.dateEnd as DATEEND_KOEF_U
from	oms_NSI.dbo.tMOLevel A
        left join oms_NSI.dbo.tMO B on A.rf_MOId = B.MOId
		left join oms_NSI.dbo.tMODept C on A.rf_MODeptId = C.MODeptId
		left join oms_NSI.dbo.tMOPlaceDept D on C.MODeptId = D.rf_MODeptId
		left join oms_NSI.dbo.tMOPlace E on D.rf_MOPlaceId = E.MOPlaceId
		left join oms_NSI.dbo.tMO F on E.rf_MOId = F.MOId
		inner join oms_NSI.dbo.sprLevel G on A.rf_LevelId = G.LevelId
		inner join oms_NSI.dbo.sprLevelCoefficient H on G.LevelId = H.rf_LevelId and A.rf_MSConditionId = H.rf_MSConditionId and H.dateBeg >= '20190101'
WHERE H.dateBeg >= '20190101' and A.dateBeg >= '20190101' and A.rf_MSConditionId in (1, 2)
 */
select case when isnull(B.mcod, F.mcod) = '' then isnull(M.mcod,F.mcod) else isnull(B.mcod, F.mcod) end as LPU,
       E.code as LPU_1,
	   C.code as PODR,
	   A.rf_MSConditionId as USL_OK,
	   G.levelPay as LEVEL,
	   A.dateBeg as DATEBEG_LEVEL,
	   A.dateEnd as DATEEND_LEVEL,
	   H.coefficient as KOEF_U,
	   H.dateBeg as DATEBEG_KOEF_U,
	   H.dateEnd as DATEEND_KOEF_U--, 
	   --left(isnull(B.tfomsCode,F.tfomsCode),6) as TFOMS_CODE
from	oms_nsi.dbo.tMOLevel A
        left join oms_nsi.dbo.tMO B on A.rf_MOId = B.MOId 
		left join oms_nsi.dbo.tMO M on B.rf_FirstLvlId = M.MOId 
		left join oms_nsi.dbo.tMODept C on A.rf_MODeptId = C.MODeptId
		left join oms_nsi.dbo.tMOPlaceDept D on C.MODeptId = D.rf_MODeptId
		left join oms_nsi.dbo.tMOPlace E on D.rf_MOPlaceId = E.MOPlaceId
		left join oms_nsi.dbo.tMO F on E.rf_MOId = F.MOId
		left join oms_nsi.dbo.sprLevel G on A.rf_LevelId = G.LevelId
		left join oms_nsi.dbo.sprLevelCoefficient H on G.LevelId = H.rf_LevelId and A.rf_MSConditionId = H.rf_MSConditionId and H.dateBeg >= '20190101'
WHERE H.dateBeg >= '20190101' and A.dateBeg >= '20190101' and A.rf_MSConditionId in (1, 2) 
GO
