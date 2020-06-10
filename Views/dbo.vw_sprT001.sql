SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO






CREATE VIEW [dbo].[vw_sprT001]
AS
--select * from oms_nsi.dbo.vw_sprT001 
SELECT t.mcod,LEFT(t1.tfomsCode,6) AS CodeM,t1.tfomsCode AS CodeLPU,t1.mnameF AS Namef,t1.mnameS AS NAMES,t1.INN,t1.KPP,t1.fam AS fam_ruk,
	   t1.im AS Im_ruk,t1.ot AS Ot_ruk,t1.Phone,t1.email AS Mail,t1.beginDate AS DateBeg,t1.endDate AS DateEnd,f.FilialId,f.filialName,
	   t1.ogrn,t.pfa,t.pfs, f.filialCode,t.MOId,t.mNameS AS LPU_Mcode,t.pfv
FROM oms_NSI.dbo.tMO t INNER JOIN oms_NSI.dbo.tMO t1 ON
		t.MOId=t1.rf_FirstLvlId
			INNER JOIN oms_NSI.dbo.tFilial f ON
		t1.rf_FilialId=f.FilialId			
WHERE t1.canBill=1




GO
GRANT SELECT ON  [dbo].[vw_sprT001] TO [AccountsOMS]
GRANT SELECT ON  [dbo].[vw_sprT001] TO [db_AccountOMS]
GO
