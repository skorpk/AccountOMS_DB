CREATE TABLE [dbo].[t_RegisterPatientDocument]
(
[rf_idRegisterPatient] [int] NULL,
[rf_idDocumentType] [char] (2) COLLATE Cyrillic_General_CI_AS NULL,
[SeriaDocument] [varchar] (10) COLLATE Cyrillic_General_CI_AS NULL,
[NumberDocument] [varchar] (20) COLLATE Cyrillic_General_CI_AS NULL,
[SNILS] [char] (14) COLLATE Cyrillic_General_CI_AS NULL,
[OKATO] [char] (11) COLLATE Cyrillic_General_CI_AS NULL,
[OKATO_Place] [char] (11) COLLATE Cyrillic_General_CI_AS NULL,
[Comments] [nvarchar] (250) COLLATE Cyrillic_General_CI_AS NULL,
[DOCDATE] [date] NULL,
[DOCORG] [varchar] (1000) COLLATE Cyrillic_General_CI_AS NULL
) ON [AccountOMSInsurer]
GO
CREATE UNIQUE NONCLUSTERED INDEX [UQ_t_RegisterPatientDocument_RefID] ON [dbo].[t_RegisterPatientDocument] ([rf_idRegisterPatient]) INCLUDE ([NumberDocument], [SeriaDocument], [SNILS]) WITH (IGNORE_DUP_KEY=ON) ON [AccountOMSInsurer]
GO
CREATE NONCLUSTERED INDEX [IX_RegisterPatientDocument_RefID_Document_OKATO_SNILS] ON [dbo].[t_RegisterPatientDocument] ([rf_idRegisterPatient]) INCLUDE ([NumberDocument], [OKATO], [OKATO_Place], [rf_idDocumentType], [SeriaDocument], [SNILS]) ON [AccountOMSInsurer]
GO
ALTER TABLE [dbo].[t_RegisterPatientDocument] ADD CONSTRAINT [FK_RegisterPatientDocument_RegisterPatient] FOREIGN KEY ([rf_idRegisterPatient]) REFERENCES [dbo].[t_RegisterPatient] ([id]) ON DELETE CASCADE
GO
GRANT SELECT ON  [dbo].[t_RegisterPatientDocument] TO [AccountsOMS]
GO
GRANT INSERT ON  [dbo].[t_RegisterPatientDocument] TO [db_AccountOMS]
GO
GRANT SELECT ON  [dbo].[t_RegisterPatientDocument] TO [db_AccountOMS]
GO
