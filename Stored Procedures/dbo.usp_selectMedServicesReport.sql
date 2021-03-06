SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[usp_selectMedServicesReport]
@p_CaseId bigint
AS
BEGIN
SELECT  m.[rf_idCase]
      ,ISNULL(m.[MUSurgery],m.[MU]) + ' - ' + ISNULL(surg.[RBNAME],s.[MUName]) as [Медуслуга]
      ,m.[Quantity]
      ,[Price]
      ,[TotalPrice]
      ,cast ([DateHelpBegin] as date) as [DateHelpBegin]
      ,cast ([DateHelpEnd] as date) as [DateHelpEnd]
      ,m.[rf_idDoctor]
      ,v002.[Name] AS profile
      ,v4.[Name] AS spec
      ,m.[Comments] as comment
	  , m.[IsNeedUsl] as Rejected
      ,cast(m.[rf_idDoctor] as bigint) as СНИЛС_Врача
  FROM [dbo].[t_Meduslugi] m
  inner join [OMS_NSI].[dbo].[sprV002] v002 on v002.id=m.[rf_idV002]
  inner join dbo.t_Case c on c.id = m.rf_idCase
  --inner join [OMS_NSI].[dbo].[sprMedicalSpeciality] v004 on v004.id=m.[rf_idV004]
  inner JOIN [dbo].[vw_sprMedicalSpeciality] v4 on m.rf_idV004=v4.id AND c.DateEnd>=v4.DateBeg AND c.DateEnd<=v4.DateEnd
  LEFT JOIN [dbo].[vw_sprMU] s on s.[MU]=m.[MU]
  LEFT JOIN [OMS_NSI].[dbo].[V001] surg on m.[MUSurgery]=surg.[IDRB] and c.DateEnd>=case when surg.DATEBEG='' then '2001-01-01' else surg.DATEBEG end and c.DateEnd<=case when surg.DATEEND='' then '2222-01-01' else surg.DATEEND end
               where m.[rf_idCase]=@p_CaseId   
order by m.[MUSurgery],m.MUGroupCode,m.MUUnGroupCode,m.MUCode,[DateHelpBegin]
END
GO
GRANT EXECUTE ON  [dbo].[usp_selectMedServicesReport] TO [AccountsOMS]
GRANT EXECUTE ON  [dbo].[usp_selectMedServicesReport] TO [db_AccountOMS]
GO
