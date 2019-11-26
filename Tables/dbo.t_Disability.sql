CREATE TABLE [dbo].[t_Disability]
(
[rf_idRecordCasePatient] [int] NOT NULL,
[TypeOfGroup] [tinyint] NOT NULL,
[DateDefine] [date] NULL,
[rf_idReasonDisability] [tinyint] NULL,
[Diagnosis] [varchar] (10) COLLATE Cyrillic_General_CI_AS NULL
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_t_Disability_rfIdRCP] ON [dbo].[t_Disability] ([rf_idRecordCasePatient], [DateDefine]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[t_Disability] ADD CONSTRAINT [FK_Disability_RecordCasesPatient] FOREIGN KEY ([rf_idRecordCasePatient]) REFERENCES [dbo].[t_RecordCasePatient] ([id]) ON DELETE CASCADE
GO
GRANT SELECT ON  [dbo].[t_Disability] TO [AccountsOMS]
GRANT SELECT ON  [dbo].[t_Disability] TO [db_AccountOMS]
GRANT INSERT ON  [dbo].[t_Disability] TO [db_AccountOMS]
GO
