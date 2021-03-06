SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
--подаются тока записи по файлам который были приняты.
create proc [dbo].[usp_ReportUnLoadAccountToSMO]
			@num nvarchar(max),
			@smo nvarchar(5)
as
SET LANGUAGE russian
			
declare @t as table(id int)
		
DECLARE @idoc int,
        @err int,
        @xml xml
        
select @xml=cast(replace('<Root><Num num="'+@num+'" /></Root>',',','" /><Num num="') as xml)
--CAST(dbo.fn_SplitNumber(@num) as xml)

 EXEC  @err = sp_xml_preparedocument @idoc OUTPUT, @xml
insert @t
select num
from OPENXML(@idoc, '/Root/Num', 1)
          WITH (num int)

 EXEC sp_xml_removedocument @idoc
	--производим фиксацию об исходящих файлах(этого делать не надо)
	--insert t_FileExit(rf_idFile,FileName)
	--select f.id,f.FileNameHR
	--from t_File f inner join t_RegistersAccounts a on
	--		f.id=a.rf_idFiles 			
	--			inner join @t t1 on
	--		f.id=t1.id
	
	select t.NameS as LPU,rtrim(f.FileNameHR) as FileNameHR,cast(a.PrefixNumberRegister as VARCHAR(5))+'-'+cast(a.NumberRegister as VARCHAR(6))+'-'
			+CAST(a.PropertyNumberRegister as CHAR(1))+ISNULL(a.Letter,'') as Account,CONVERT(CHAR(10),a.DateRegister,104) as DateAccount,
			cast(a.AmountPayment as money) as Summa,s.sNameS,dbo.fn_MonthName(a.ReportYear,a.ReportMonth) as ReportDate
			--,convert(CHAR(10),f.DateRegistration,104)+' '+cast(cast(f.DateRegistration as time(7)) as varchar(8)) as DateRegistration
	from t_File f inner join t_RegistersAccounts a on
			f.id=a.rf_idFiles 			
				inner join @t t1 on
			f.id=t1.id
				  inner join vw_sprSMO s on
			a.PrefixNumberRegister=s.smocod
			and s.smocod=@smo
				inner join vw_sprT001 t on
			f.CodeM=t.CodeM
	order by LPU,Account
				 
GO
GRANT EXECUTE ON  [dbo].[usp_ReportUnLoadAccountToSMO] TO [db_AccountOMS]
GO
