SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
--функция возвращает 1 если присутствует данный номер реестр СП и ТК и небыл принят счет с данным номером на это лпу
--если возвращаемое значение отлично от 1 значит ошибка.
CREATE FUNCTION dbo.fn_CheckAccount(@account varchar(15),@codeMO char(6),@month tinyint,@year smallint)
RETURNS int
as
begin
declare @i int

	select @i=COUNT(distinct r.id)
	from RegisterCases.dbo.t_FileBack f inner join RegisterCases.dbo.t_RegisterCaseBack r on
			f.id=r.rf_idFilesBack
			and f.CodeM=@codeMO
				  inner join RegisterCases.dbo.t_RecordCaseBack rec on
			r.id=rec.rf_idRegisterCaseBack
			--and r.ref_idF003=@codeMO 
			and ReportMonth=@month 
			and ReportYear=@year 
				inner join RegisterCases.dbo.t_PatientBack p on
			rec.id=p.rf_idRecordCaseBack							
	where rtrim(p.rf_idSMO)+'-'+CAST(r.NumberRegister as varchar(6))+'-'+CAST(r.PropertyNumberRegister as CHAR(1))= (case when ISNUMERIC(RIGHT(@account,1))=1 then @account else SUBSTRING(@account,1,LEN(@account)-1) end)
	select @i=@i+COUNT(distinct a.id) 
	from t_File f inner join t_RegistersAccounts a on
			f.id=a.rf_idFiles
			and f.CodeM=@codeMO
			and a.ReportYear=@year
	where rtrim(PrefixNumberRegister)+'-'+CAST(NumberRegister as varchar(6))+'-'+CAST(PropertyNumberRegister as CHAR(1))+ISNULL(Letter,'')=@account
	
RETURN(isnull(@i,0))
end;
GO
GRANT EXECUTE ON  [dbo].[fn_CheckAccount] TO [db_AccountOMS]
GO
