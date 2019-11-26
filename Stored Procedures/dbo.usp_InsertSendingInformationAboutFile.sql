SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[usp_InsertSendingInformationAboutFile]
				 @nameFile varchar(20),
				 @reportMonth TINYINT,
				 @reportYear SMALLINT,
				 @code TINYINT
as            
IF LEN(@nameFile)!=11
BEGIN
	INSERT dbo.t_SendingFileToFFOMS( NameFile,ReportMonth,ReportYear,NumberOfEndFile,UserName ) VALUES(@nameFile+RIGHT('000'+CAST(@code AS varchar(3)),4),@reportMonth,@reportYear,@code, ORIGINAL_LOGIN())
END
ELSE
BEGIN
	INSERT dbo.t_SendingFileToFFOMS( NameFile,ReportMonth,ReportYear,NumberOfEndFile,UserName ) VALUES(@nameFile,@reportMonth,@reportYear,@code, ORIGINAL_LOGIN())
END 


GO
GRANT EXECUTE ON  [dbo].[usp_InsertSendingInformationAboutFile] TO [db_AccountOMS]
GO
