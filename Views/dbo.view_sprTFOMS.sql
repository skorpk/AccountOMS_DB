SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE VIEW [dbo].[view_sprTFOMS]
AS
SELECT
         TF_KOD
       , TF_OKATO
       , TF_OGRN
       , NAME_TFP
       , POST_INDEX
       , [ADDRESS]
       , FAM_DIR
       , IM_DIR
       , OT_DIR
       , PHONE
       , FAX
       , E_MAIL
       , KF_TF
       , WEB_SITE
       , D_EDIT
       , D_END
       , UId
       , NAME_TFK
FROM
      oms_NSI.dbo.sprTFOMS
GO
GRANT SELECT ON  [dbo].[view_sprTFOMS] TO [db_AccountOMS]
GO
