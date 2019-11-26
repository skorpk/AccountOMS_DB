SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE VIEW [dbo].[vw_SendingDataIntoFFOMS]
AS
SELECT  DISTINCT 
        IDPeople ,--
        rf_idCase ,
        CodeM ,	--
        rf_idV006 ,	  --
        SeriaPolis ,--
        NumberPolis , --
        BirthDay ,	--
        rf_idV005 ,--
        DateBegin ,--
        DateEnd ,	 --
        DS1 ,     --   
        rf_idV009 ,	--
        MES ,  --
        AmountPayment ,  --      
        PVT ,--
        IsUnload , --
        ENP	  --
FROM dbo.t_SendingDataIntoFFOMS
WHERE IsDisableCheck=0  AND IsFullDoubleDate=0
GO
