CREATE TABLE [dbo].[t_RegisterPatientAttendant]
(
[rf_idRegisterPatient] [int] NULL,
[Fam] [nvarchar] (40) COLLATE Cyrillic_General_CI_AS NULL,
[Im] [nvarchar] (40) COLLATE Cyrillic_General_CI_AS NULL,
[Ot] [nvarchar] (40) COLLATE Cyrillic_General_CI_AS NULL,
[rf_idV005] [tinyint] NOT NULL,
[BirthDay] [date] NULL
) ON [AccountOMSInsurer]
GO
CREATE NONCLUSTERED INDEX [IDX_RPA_rfidRegPat] ON [dbo].[t_RegisterPatientAttendant] ([rf_idRegisterPatient]) INCLUDE ([BirthDay], [Fam], [Im], [Ot], [rf_idV005]) ON [AccountOMSInsurer]
GO
ALTER TABLE [dbo].[t_RegisterPatientAttendant] ADD CONSTRAINT [FK_RegisterPatientAttendant_RegisterPatient] FOREIGN KEY ([rf_idRegisterPatient]) REFERENCES [dbo].[t_RegisterPatient] ([id]) ON DELETE CASCADE
GO
GRANT SELECT ON  [dbo].[t_RegisterPatientAttendant] TO [AccountsOMS]
GRANT SELECT ON  [dbo].[t_RegisterPatientAttendant] TO [db_AccountOMS]
GRANT INSERT ON  [dbo].[t_RegisterPatientAttendant] TO [db_AccountOMS]
GRANT SELECT ON  [dbo].[t_RegisterPatientAttendant] TO [PDAOR_Executive]
GO
