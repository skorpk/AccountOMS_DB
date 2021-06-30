CREATE TABLE [dbo].[t_DS2_Info]
(
[rf_idCase] [bigint] NULL,
[DiagnosisCode] [varchar] (10) COLLATE Cyrillic_General_CI_AS NOT NULL,
[IsFirst] [bit] NULL,
[IsNeedDisp] [tinyint] NULL
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_DS_Cases] ON [dbo].[t_DS2_Info] ([DiagnosisCode]) INCLUDE ([IsNeedDisp], [rf_idCase]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_DS2_NeedDisp_IdCase] ON [dbo].[t_DS2_Info] ([IsNeedDisp]) INCLUDE ([rf_idCase]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_DS2_Diagnosis_Case] ON [dbo].[t_DS2_Info] ([rf_idCase], [DiagnosisCode]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[t_DS2_Info] ADD CONSTRAINT [FK_DS2_Info_Cases] FOREIGN KEY ([rf_idCase]) REFERENCES [dbo].[t_Case] ([id]) ON DELETE CASCADE
GO
GRANT INSERT ON  [dbo].[t_DS2_Info] TO [db_AccountOMS]
GO
GRANT SELECT ON  [dbo].[t_DS2_Info] TO [db_AccountOMS]
GO
