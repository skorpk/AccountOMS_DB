CREATE TABLE [dbo].[t_Diagnosis]
(
[DiagnosisCode] [char] (10) COLLATE Cyrillic_General_CI_AS NULL,
[rf_idCase] [bigint] NOT NULL,
[TypeDiagnosis] [tinyint] NOT NULL
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_Diagnosis_Type_IdCase] ON [dbo].[t_Diagnosis] ([DiagnosisCode], [TypeDiagnosis]) INCLUDE ([rf_idCase]) ON [PRIMARY]
GO
CREATE CLUSTERED INDEX [PK_RefCase_Type] ON [dbo].[t_Diagnosis] ([rf_idCase], [TypeDiagnosis]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_DIagnosis_Primary] ON [dbo].[t_Diagnosis] ([rf_idCase], [TypeDiagnosis]) INCLUDE ([DiagnosisCode]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_Diagnosis_Case_DS] ON [dbo].[t_Diagnosis] ([TypeDiagnosis]) INCLUDE ([DiagnosisCode], [rf_idCase]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[t_Diagnosis] ADD CONSTRAINT [FK_Diagnosis_Cases] FOREIGN KEY ([rf_idCase]) REFERENCES [dbo].[t_Case] ([id]) ON DELETE CASCADE
GO
GRANT SELECT ON  [dbo].[t_Diagnosis] TO [db_AccountOMS]
GRANT INSERT ON  [dbo].[t_Diagnosis] TO [db_AccountOMS]
GO
