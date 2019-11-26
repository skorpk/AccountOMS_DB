SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE view [dbo].[view_MO]
as
SELECT [MOId]
	 , [rf_FirstLvlId]
	 , [rf_SecondLvlId]
	 , [isFirstLvl]
	 , [canBill]
	 , [mcod]
	 , [mNameF]
	 , [mNameS]
	 , [ogrn]
	 , [inn]
	 , [kpp]
	 , [postIndex]
	 , [rf_OKOPFId]
	 , [rf_VPId]
	 , [fam]
	 , [im]
	 , [ot]
	 , [phone]
	 , [fax]
	 , [eMail]
	 , [www]
	 , [beginDate]
	 , [endDate]
	 , [editDate]
	 , left([tfomsCode], 6) as tfomsCode
	 , [rf_ExceptionReasonId]
	 , [flag]
	 , [region]
	 , [area]
	 , [city]
	 , [street]
	 , [building]
	 , [corp]
	 , [rf_FilialId]
	 , [rf_CityAreaId]
FROM
	[oms_NSI].[dbo].[tMO]
WHERE
	flag = 'A'




GO
GRANT SELECT ON  [dbo].[view_MO] TO [db_AccountOMS]
GO
