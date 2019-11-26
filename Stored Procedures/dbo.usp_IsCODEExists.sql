SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[usp_IsCODEExists]
				@code BIGINT,
				@codeM CHAR(6)
AS
SELECT COUNT(*) 
FROM t_File f INNER JOIN t_RegistersAccounts a ON
		f.id=a.rf_idFiles
WHERE CodeM=@codeM AND a.idRecord=@code
GO
GRANT EXECUTE ON  [dbo].[usp_IsCODEExists] TO [db_AccountOMS]
GO
