SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE VIEW [dbo].[vw_DS_ONK]
as
SELECT  rf_idCase , DS_ONK FROM dbo.t_DS_ONK_REAB
UNION ALL
SELECT rf_idCase, ISOnko FROM dbo.t_DispInfo WHERE IsOnko IS NOT NULL
GO
