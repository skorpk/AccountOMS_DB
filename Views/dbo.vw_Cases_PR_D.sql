SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE VIEW [dbo].[vw_Cases_PR_D]
AS
SELECT id,IsNeedDisp
from dbo.t_Case WHERE DateEnd>'20180101' AND IsNeedDisp IS NOT NULL
UNION ALL
SELECT rf_idCase,IsNeedDisp from dbo.t_DS2_Info WHERE IsNeedDisp IS NOT null
GO
