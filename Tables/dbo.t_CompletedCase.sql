CREATE TABLE [dbo].[t_CompletedCase]
(
[id] [int] NOT NULL IDENTITY(1, 1),
[rf_idRecordCasePatient] [int] NOT NULL,
[idRecordCase] [bigint] NOT NULL,
[GUID_ZSL] [uniqueidentifier] NOT NULL,
[DateBegin] [date] NOT NULL,
[DateEnd] [date] NOT NULL,
[VB_P] [tinyint] NULL,
[HospitalizationPeriod] [smallint] NULL,
[AmountPayment] [decimal] (15, 2) NULL
) ON [AccountMU]
GO
GRANT SELECT ON  [dbo].[t_CompletedCase] TO [AccountsOMS]
GO

ALTER TABLE [dbo].[t_CompletedCase] ADD CONSTRAINT [PK__t_Comple__3213E83F1D3212B9] PRIMARY KEY CLUSTERED  ([id]) ON [AccountMU]
GO
CREATE NONCLUSTERED INDEX [IX_RefRecordCasePatient_VBP] ON [dbo].[t_CompletedCase] ([rf_idRecordCasePatient]) INCLUDE ([AmountPayment], [DateBegin], [DateEnd], [HospitalizationPeriod], [id], [VB_P]) ON [AccountMU]
GO
ALTER TABLE [dbo].[t_CompletedCase] ADD CONSTRAINT [FK_CompCases_Patient] FOREIGN KEY ([rf_idRecordCasePatient]) REFERENCES [dbo].[t_RecordCasePatient] ([id]) ON DELETE CASCADE
GO
