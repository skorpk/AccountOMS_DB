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
[MSE] [tinyint] NULL,
[IsNewBorn] AS (case  when len([NewBorn])>(5) then (1) else (0) end) PERSISTED NOT NULL
) ON [AccountOMSInsurer]
GO
ALTER TABLE [dbo].[t_RecordCasePatient] ADD CONSTRAINT [PK_RecordCasePatient_idFiles_idRecordCase] PRIMARY KEY CLUSTERED  ([id]) ON [AccountOMSInsurer]
GO
CREATE NONCLUSTERED INDEX [IX_RecordCase_RefAccount] ON [dbo].[t_RecordCasePatient] ([rf_idRegistersAccounts]) INCLUDE ([AttachLPU], [BirthWeight], [id], [ID_Patient], [idRecord], [IsNew], [NewBorn], [NumberPolis], [rf_idF008], [SeriaPolis]) ON [AccountOMSInsurer]
GO
CREATE NONCLUSTERED INDEX [IX_RecordCasePatient_RefAccount] ON [dbo].[t_RecordCasePatient] ([rf_idRegistersAccounts]) INCLUDE ([AttachLPU], [id], [NewBorn], [NumberPolis], [SeriaPolis]) ON [AccountOMSInsurer]
GO
ALTER TABLE [dbo].[t_RecordCasePatient] ADD CONSTRAINT [FK_RecordCasePatient_RegistersAccounts] FOREIGN KEY ([rf_idRegistersAccounts]) REFERENCES [dbo].[t_RegistersAccounts] ([id]) ON DELETE CASCADE
GO
GRANT SELECT ON  [dbo].[t_RecordCasePatient] TO [AccountsOMS]
GO
GRANT INSERT ON  [dbo].[t_RecordCasePatient] TO [db_AccountOMS]
GO
GRANT SELECT ON  [dbo].[t_RecordCasePatient] TO [db_AccountOMS]
GO
GRANT SELECT ON  [dbo].[t_RecordCasePatient] TO [db_AccountsFinancing]
GO
GRANT SELECT ON  [dbo].[t_RecordCasePatient] TO [db_Financing]
GO
GRANT SELECT ON  [dbo].[t_RecordCasePatient] TO [PDAOR_Executive]
GO
