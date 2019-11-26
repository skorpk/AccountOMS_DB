CREATE TABLE [dbo].[t_RecordCasePatient]
(
[id] [int] NOT NULL IDENTITY(1, 1) NOT FOR REPLICATION,
[rf_idRegistersAccounts] [int] NOT NULL,
[idRecord] [int] NULL,
[IsNew] [bit] NULL,
[ID_Patient] [varchar] (36) COLLATE Cyrillic_General_CI_AS NOT NULL,
[rf_idF008] [tinyint] NOT NULL,
[SeriaPolis] [varchar] (10) COLLATE Cyrillic_General_CI_AS NULL,
[NumberPolis] [varchar] (20) COLLATE Cyrillic_General_CI_AS NULL,
[NewBorn] [varchar] (9) COLLATE Cyrillic_General_CI_AS NOT NULL,
[AttachLPU] [char] (6) COLLATE Cyrillic_General_CI_AS NULL,
[BirthWeight] [smallint] NULL,
[MSE] [tinyint] NULL
) ON [AccountOMSInsurer]
GO
ALTER TABLE [dbo].[t_RecordCasePatient] ADD CONSTRAINT [PK_RecordCasePatient_idFiles_idRecordCase] PRIMARY KEY CLUSTERED  ([id]) ON [AccountOMSInsurer]
GO
CREATE NONCLUSTERED INDEX [IX_RecordCase_RefAccount] ON [dbo].[t_RecordCasePatient] ([rf_idRegistersAccounts]) INCLUDE ([AttachLPU], [id], [ID_Patient], [idRecord], [IsNew], [NewBorn], [rf_idF008]) ON [AccountOMSInsurer]
GO
CREATE NONCLUSTERED INDEX [IX_RecordCasePatient_RefAccount] ON [dbo].[t_RecordCasePatient] ([rf_idRegistersAccounts]) INCLUDE ([AttachLPU], [id], [NewBorn], [NumberPolis], [SeriaPolis]) ON [AccountOMSInsurer]
GO
ALTER TABLE [dbo].[t_RecordCasePatient] ADD CONSTRAINT [FK_RecordCasePatient_RegistersAccounts] FOREIGN KEY ([rf_idRegistersAccounts]) REFERENCES [dbo].[t_RegistersAccounts] ([id]) ON DELETE CASCADE
GO
GRANT SELECT ON  [dbo].[t_RecordCasePatient] TO [AccountsOMS]
GRANT SELECT ON  [dbo].[t_RecordCasePatient] TO [db_AccountOMS]
GRANT INSERT ON  [dbo].[t_RecordCasePatient] TO [db_AccountOMS]
GRANT SELECT ON  [dbo].[t_RecordCasePatient] TO [db_AccountsFinancing]
GRANT SELECT ON  [dbo].[t_RecordCasePatient] TO [db_Financing]
GRANT SELECT ON  [dbo].[t_RecordCasePatient] TO [PDAOR_Executive]
GO
