SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
--проверка наличия реестра СП и ТК в БД
CREATE FUNCTION dbo.fn_CheckAccountExistSPTK(@account VARCHAR(15),@codeMO CHAR(6),@month TINYINT,@year SMALLINT)
RETURNS TABLE
AS
	RETURN(
	        SELECT r.id
			FROM RegisterCases.dbo.t_FileBack f INNER JOIN RegisterCases.dbo.t_RegisterCaseBack r ON
					f.id=r.rf_idFilesBack
					AND f.CodeM=@codeMO
						  INNER JOIN RegisterCases.dbo.t_RecordCaseBack rec ON
					r.id=rec.rf_idRegisterCaseBack
					AND ReportMonth=@month 
					AND ReportYear=@year 
						INNER JOIN RegisterCases.dbo.t_PatientBack p ON
					rec.id=p.rf_idRecordCaseBack							
			WHERE RTRIM(p.rf_idSMO)+'-'+CAST(r.NumberRegister AS VARCHAR(6))+'-'+CAST(r.PropertyNumberRegister AS CHAR(1))= 
					(CASE WHEN ISNUMERIC(RIGHT(@account,1))=1 THEN @account ELSE SUBSTRING(@account,1,LEN(@account)-1) END)
		)

GO
