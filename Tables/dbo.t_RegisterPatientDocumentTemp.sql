CREATE TABLE [dbo].[t_RegisterPatientDocumentTemp]
(
[rf_idRegisterPatient] [int] NULL,
[rf_idDocumentType] [char] (2) COLLATE Cyrillic_General_CI_AS NULL,
[SeriaDocument] [varchar] (10) COLLATE Cyrillic_General_CI_AS NULL,
[NumberDocument] [varchar] (20) COLLATE Cyrillic_General_CI_AS NULL,
[SNILS] [char] (14) COLLATE Cyrillic_General_CI_AS NULL,
[OKATO] [char] (11) COLLATE Cyrillic_General_CI_AS NULL,
[OKATO_Place] [char] (11) COLLATE Cyrillic_General_CI_AS NULL,
[Comments] [nvarchar] (250) COLLATE Cyrillic_General_CI_AS NULL
) ON [PRIMARY]
GO
CREATE UNIQUE NONCLUSTERED INDEX [UI_refID] ON [dbo].[t_RegisterPatientDocumentTemp] ([rf_idRegisterPatient]) WITH (IGNORE_DUP_KEY=ON) ON [PRIMARY]
GO
GRANT SELECT ON  [dbo].[t_RegisterPatientDocumentTemp] TO [db_AccountOMS]
GRANT INSERT ON  [dbo].[t_RegisterPatientDocumentTemp] TO [db_AccountOMS]
GO
