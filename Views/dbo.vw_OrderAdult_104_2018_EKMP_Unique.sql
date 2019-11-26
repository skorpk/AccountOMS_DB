SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE VIEW [dbo].[vw_OrderAdult_104_2018_EKMP_Unique]
as
SELECT DISTINCT  rf_idCase ,AmountPayment ,AmountDeduction ,Age ,DS1 ,ENP ,rf_idV009 ,rf_idV006 ,rf_idV014 ,BirthDay ,AP_Type ,DateBegin ,DateEnd ,Gosp_type ,ReportMonth ,ReportYear ,PVT ,TypeExp ,IsEKMP 
FROM dbo.t_OrderAdult_104_2018_EKMP o
WHERE NOT EXISTS(SELECT * FROM dbo.t_OrderAdult_104_2018_EKMP_2 e WHERE o.rf_idCase=e.rf_idCase)
UNION ALL
SELECT  DISTINCT rf_idCase ,AmountPayment ,AmountDeduction ,Age ,DS1 ,ENP ,rf_idV009 ,rf_idV006 ,rf_idV014 ,BirthDay ,AP_Type ,DateBegin ,DateEnd ,Gosp_type ,ReportMonth ,ReportYear ,PVT ,TypeExp ,IsEKMP 
FROM dbo.t_OrderAdult_104_2018_EKMP_2 o
GO
