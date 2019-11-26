CREATE TABLE [dbo].[t_DiagnosticBlock]
(
[rf_idONK_SL] [int] NOT NULL,
[TypeDiagnostic] [tinyint] NULL,
[CodeDiagnostic] [smallint] NULL,
[ResultDiagnostic] [smallint] NULL,
[DateDiagnostic] [date] NULL,
[REC_RSLT] [tinyint] NULL
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_DiagnosticBlock_RefONKSL] ON [dbo].[t_DiagnosticBlock] ([rf_idONK_SL]) INCLUDE ([CodeDiagnostic], [DateDiagnostic], [REC_RSLT], [ResultDiagnostic], [TypeDiagnostic]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[t_DiagnosticBlock] ADD CONSTRAINT [FK_t_DiagnosticBlock_ONK_SL] FOREIGN KEY ([rf_idONK_SL]) REFERENCES [dbo].[t_ONK_SL] ([id]) ON DELETE CASCADE
GO
GRANT SELECT ON  [dbo].[t_DiagnosticBlock] TO [db_AccountOMS]
GRANT INSERT ON  [dbo].[t_DiagnosticBlock] TO [db_AccountOMS]
GO
