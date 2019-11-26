SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
--проверка на наличие уже зарегестрированного счета с такми номером от МО
CREATE FUNCTION dbo.fn_CheckAccountExistInDB(@account VARCHAR(15),@codeMO CHAR(6),@month TINYINT,@year SMALLINT)
RETURNS TABLE
AS
RETURN(
		SELECT DISTINCT a.id
		FROM t_File f INNER JOIN t_RegistersAccounts a ON
				f.id=a.rf_idFiles
				AND f.CodeM=@codeMO
				AND a.ReportYear=@year
		WHERE RTRIM(PrefixNumberRegister)+'-'+CAST(NumberRegister AS VARCHAR(6))+'-'+CAST(PropertyNumberRegister AS CHAR(1))+ISNULL(Letter,'')=@account
	)
GO
