CREATE TABLE [dbo].[t_Contraindications]
(
[rf_idONK_SL] [int] NOT NULL,
[Code] [tinyint] NOT NULL,
[DateContraindications] [date] NOT NULL
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_Contraindications] ON [dbo].[t_Contraindications] ([rf_idONK_SL]) INCLUDE ([Code], [DateContraindications]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[t_Contraindications] ADD CONSTRAINT [FK_t_Contraindications_ONK_SL] FOREIGN KEY ([rf_idONK_SL]) REFERENCES [dbo].[t_ONK_SL] ([id]) ON DELETE CASCADE
GO
GRANT SELECT ON  [dbo].[t_Contraindications] TO [db_AccountOMS]
GRANT INSERT ON  [dbo].[t_Contraindications] TO [db_AccountOMS]
GO
