CREATE TABLE [dbo].[t_PatientSMO]
(
[rf_idRecordCasePatient] [int] NOT NULL,
[rf_idSMO] [char] (5) COLLATE Cyrillic_General_CI_AS NULL,
[OGRN] [char] (15) COLLATE Cyrillic_General_CI_AS NULL,
[OKATO] [char] (5) COLLATE Cyrillic_General_CI_AS NULL,
[Name] [nvarchar] (100) COLLATE Cyrillic_General_CI_AS NULL,
[ENP] [varchar] (16) COLLATE Cyrillic_General_CI_AS NULL,
[ST_OKATO] [varchar] (5) COLLATE Cyrillic_General_CI_AS NULL
) ON [AccountOMSInsurer]
GO
CREATE NONCLUSTERED INDEX [IX_ENP_Ref] ON [dbo].[t_PatientSMO] ([ENP]) INCLUDE ([rf_idRecordCasePatient]) ON [AccountOMSInsurer]
GO
CREATE NONCLUSTERED INDEX [ix_IndexName] ON [dbo].[t_PatientSMO] ([rf_idRecordCasePatient]) INCLUDE ([ENP], [Name], [OGRN], [OKATO], [rf_idSMO], [ST_OKATO]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[t_PatientSMO] ADD CONSTRAINT [FK_PatientSMO_Patient] FOREIGN KEY ([rf_idRecordCasePatient]) REFERENCES [dbo].[t_RecordCasePatient] ([id]) ON DELETE CASCADE
GO
GRANT SELECT ON  [dbo].[t_PatientSMO] TO [db_AccountOMS]
GRANT INSERT ON  [dbo].[t_PatientSMO] TO [db_AccountOMS]
GO
