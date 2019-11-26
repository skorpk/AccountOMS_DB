SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[usp_IsCODEExists2]
				@code bigint,
				@codeM char(6),
				@year smallint
as
select COUNT(*) 
FROM t_File f INNER JOIN t_RegistersAccounts a ON
		f.id=a.rf_idFiles
WHERE CodeM=@codeM AND a.idRecord=@code AND a.ReportYear=@year

GO
GRANT EXECUTE ON  [dbo].[usp_IsCODEExists2] TO [db_AccountOMS]
GO
