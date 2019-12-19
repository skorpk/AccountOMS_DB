SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[usp_selectUSL_TIPs]
AS 
select [ID_TLech],[TLech_NAME],[sprN013Id] from [dbo].[vw_sprN013]
GO
GRANT EXECUTE ON  [dbo].[usp_selectUSL_TIPs] TO [AccountsOMS]
GO
GRANT EXECUTE ON  [dbo].[usp_selectUSL_TIPs] TO [db_AccountOMS]
GO
