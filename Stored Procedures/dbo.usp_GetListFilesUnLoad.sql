SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
--данные для формы отображающей файлы входящие
CREATE proc [dbo].[usp_GetListFilesUnLoad]
			@smo varchar(5)
as
select f.id,rtrim(f.FileNameHR) as FileNameHR,cast(rtrim(a.PrefixNumberRegister) as VARCHAR(5))+'-'+cast(a.NumberRegister as VARCHAR(6))+'-'
			+CAST(a.PropertyNumberRegister as CHAR(1))+ISNULL(a.Letter,'') as Account,CONVERT(CHAR(10),a.DateRegister,104) as DateAccount,
			cast(a.AmountPayment as decimal(11,2)) as Summa,cast(1 as bit) as IsUnchecked,l.CodeM,l.NameS,CONVERT(CHAR(10),f.DateRegistration,104) AS DateReg
from t_File f inner join t_RegistersAccounts a on
			f.id=a.rf_idFiles
				inner join vw_sprSMO s on
			rtrim(a.PrefixNumberRegister)=s.smocod				
			and s.smocod=@smo
				inner join vw_sprT001 l on
			f.CodeM=l.CodeM
				left join t_FileExit fe on
			f.id=fe.rf_idFile
where fe.rf_idFile is null
ORDER BY f.id
GO
GRANT EXECUTE ON  [dbo].[usp_GetListFilesUnLoad] TO [db_AccountOMS]
GO
