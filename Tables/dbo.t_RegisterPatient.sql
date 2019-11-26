CREATE TABLE [dbo].[t_RegisterPatient]
(
[id] [int] NOT NULL IDENTITY(1, 1) NOT FOR REPLICATION,
[rf_idFiles] [int] NOT NULL,
[ID_Patient] [varchar] (36) COLLATE Cyrillic_General_CI_AS NOT NULL,
[Fam] [nvarchar] (40) COLLATE Cyrillic_General_CI_AS NULL,
[Im] [nvarchar] (40) COLLATE Cyrillic_General_CI_AS NULL,
[Ot] [nvarchar] (40) COLLATE Cyrillic_General_CI_AS NULL,
[rf_idV005] [tinyint] NOT NULL,
[BirthDay] [date] NULL,
[BirthPlace] [nvarchar] (100) COLLATE Cyrillic_General_CI_AS NULL,
[rf_idRecordCase] [int] NULL,
[Sex] AS (case when [rf_idV005]=(1) then 'М' else 'Ж' end),
[TEL] [varchar] (10) COLLATE Cyrillic_General_CI_AS NULL
) ON [AccountOMSInsurer]
GO
ALTER TABLE [dbo].[t_RegisterPatient] ADD CONSTRAINT [PK__t_Regist__3213E83F267ABA7A] PRIMARY KEY CLUSTERED  ([id]) ON [AccountOMSInsurer]
GO
CREATE NONCLUSTERED INDEX [ix_IndexName] ON [dbo].[t_RegisterPatient] ([Fam], [rf_idFiles]) INCLUDE ([BirthDay], [BirthPlace], [id], [Im], [Ot], [rf_idRecordCase], [rf_idV005]) ON [AccountOMSInsurer]
GO
CREATE NONCLUSTERED INDEX [IX_People_idFiles] ON [dbo].[t_RegisterPatient] ([rf_idFiles]) INCLUDE ([BirthDay], [BirthPlace], [Fam], [id], [ID_Patient], [Im], [Ot], [rf_idRecordCase], [rf_idV005]) ON [AccountOMSInsurer]
GO
CREATE NONCLUSTERED INDEX [IX_RegisterPatient_rf_idRecordCase] ON [dbo].[t_RegisterPatient] ([rf_idRecordCase], [TEL]) INCLUDE ([BirthDay], [BirthPlace], [Fam], [Im], [Ot], [rf_idFiles], [rf_idV005]) ON [AccountOMSInsurer]
GO
ALTER TABLE [dbo].[t_RegisterPatient] ADD CONSTRAINT [FK_RegisterPatient_Files] FOREIGN KEY ([rf_idFiles]) REFERENCES [dbo].[t_File] ([id]) ON DELETE CASCADE
GO
GRANT SELECT ON  [dbo].[t_RegisterPatient] TO [AccountsOMS]
GRANT SELECT ON  [dbo].[t_RegisterPatient] TO [db_AccountOMS]
GRANT INSERT ON  [dbo].[t_RegisterPatient] TO [db_AccountOMS]
GRANT SELECT ON  [dbo].[t_RegisterPatient] TO [PDAOR_Executive]
GO
