CREATE TABLE [dbo].[sprDiagnosisKSG]
(
[DiagnosisName] [varchar] (202) COLLATE Cyrillic_General_CI_AS NOT NULL,
[Diagnosis] [varchar] (6) COLLATE Cyrillic_General_CI_AS NOT NULL,
[GroupID] [int] NOT NULL
) ON [PRIMARY]
GO
GRANT SELECT ON  [dbo].[sprDiagnosisKSG] TO [db_AccountOMS]
GRANT INSERT ON  [dbo].[sprDiagnosisKSG] TO [db_AccountOMS]
GO
