CREATE TABLE [dbo].[t_ProfileOfBed]
(
[rf_idCase] [bigint] NOT NULL,
[rf_idV020] [smallint] NOT NULL
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_ProfilOfBed] ON [dbo].[t_ProfileOfBed] ([rf_idCase]) INCLUDE ([rf_idV020]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[t_ProfileOfBed] ADD CONSTRAINT [FK_ProfileOfBed_Cases] FOREIGN KEY ([rf_idCase]) REFERENCES [dbo].[t_Case] ([id]) ON DELETE CASCADE
GO
GRANT INSERT ON  [dbo].[t_ProfileOfBed] TO [db_AccountOMS]
GO
