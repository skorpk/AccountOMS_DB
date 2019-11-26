SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[usp_selectDiag]
AS 
begin	

				SELECT 
                            --tmpC.caseid AS CaseId ,
                            --tmpC.idrecordcase AS Случай ,
                            --tmpC.amountpayment AS Выставлено ,
                            rtrim([DiagnosisCode]),
                            rtrim([DiagnosisCode]) + ' — ' +[Diagnosis] 
                            --v8.Name AS ВидПомощи ,
                            --dmo.NAM_MOK AS Направление ,
                            --tmpC.hospitalisationtype AS ТипГоспитализации ,
                            --v2.name AS Профиль ,
                            --tmpC.ischildtarif AS Тариф ,
                            --tmpC.numberhistorycase AS НомерКарты ,
                            --tmpC.datebegin AS Начат ,
                            --tmpC.dateend AS Окончен ,
                            --tmpC.amountpayment AS Выставлено ,
                            --v9.Name AS Результат ,
                            --v12.Name AS Исход ,
                            --v4.Name AS СпециальностьМедРаботника ,
                            --v10.Name AS СпособОплаты ,
                            --tmpC.patient AS Пациент ,
                            --v5.Name AS Пол ,
                            --tmpC.birthday AS ДатаРождения ,
                            --tmpC.age AS Возраст ,
                            --tmpC.birthplace AS МестоРождения ,
                            --rpa.Fam + ' ' + rpa.Im + ' ' + rpa.Ot AS Представитель ,
                            --dt.Name AS ТипДокумента ,
                            --rpd.SeriaDocument AS Серия ,
                            --RTRIM(rpd.NumberDocument) AS Номер ,
                            --rpd.SNILS AS СНИЛС ,
                            --tmpC.seriapolis AS СерияПолиса ,
                            --tmpC.numberpolis AS НомерПолиса ,
                            --tmpC.dateregistration AS ДатаРегистрации ,
                            --tmpC.filialname AS Филиал ,
                            --tmpC.codemo AS CodeMO ,
                            --tmpC.codefilial AS CodeFilial ,
                            --mo.NameS AS МО ,
                            --d.DS1 AS КодДиагноза ,
                            --mkb.Diagnosis AS Диагноз ,
                            --rpd.OKATO AS АдресРегистрации ,
                            --rpd.OKATO_place  AS АдресМестаЖительства ,
                            --tmpC.accountnumber ,
                            --tmpC.accountdate ,
                            --tmpC.attachMO
                    FROM    [OMS_NSI].[dbo].[sprMKB]
                            --INNER JOIN OMS_NSI.dbo.sprV008 AS v8 ON tmpC.rf_idV008 = v8.Id
                            --INNER JOIN OMS_NSI.dbo.sprV010 AS v10 ON tmpC.rf_idV010 = v10.Id
                            --INNER JOIN OMS_NSI.dbo.sprV005 AS v5 ON tmpC.rf_idV005 = v5.Id
                            --INNER JOIN dbo.vw_Diagnosis AS d ON tmpC.caseid = d.rf_idCase
                            --INNER JOIN OMS_NSI.dbo.sprMKB AS mkb ON mkb.DiagnosisCode = d.DS1
                            --INNER JOIN dbo.vw_sprT001_Report AS mo ON mo.CodeM = tmpC.codemo
                            --LEFT JOIN OMS_NSI.dbo.sprMO AS dmo ON dmo.mcod = tmpC.rf_idDirectMO
                            --LEFT JOIN OMS_NSI.dbo.sprV009 AS v9 ON tmpC.rf_idV009 = v9.Id
                            --LEFT JOIN OMS_NSI.dbo.sprV012 AS v12 ON tmpC.rf_idV012 = v12.Id
                            --LEFT JOIN dbo.t_RegisterPatientAttendant AS rpa ON rpa.rf_idRegisterPatient = tmpC.rpid
                            --LEFT JOIN dbo.t_RegisterPatientDocument AS rpd ON rpd.rf_idRegisterPatient = tmpC.rpid
                            --LEFT JOIN OMS_NSI.dbo.sprDocumentType AS dt ON rpd.rf_idDocumentType = dt.ID
                            --LEFT JOIN OMS_NSI.dbo.sprMedicalSpeciality AS v4 ON tmpC.rf_idV004 = v4.Id
   
    END
GO
GRANT EXECUTE ON  [dbo].[usp_selectDiag] TO [AccountsOMS]
GRANT EXECUTE ON  [dbo].[usp_selectDiag] TO [db_AccountOMS]
GO
