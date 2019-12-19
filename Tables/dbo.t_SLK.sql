CREATE TABLE [dbo].[t_SLK]
(
[rf_idCase] [bigint] NOT NULL,
[SL_K] [tinyint] NOT NULL
) ON [AccountMU]
GO
CREATE NONCLUSTERED INDEX [IX_SLK_IdCase] ON [dbo].[t_SLK] ([rf_idCase]) ON [AccountMU]
GO
CREATE NONCLUSTERED INDEX [IX_SLK] ON [dbo].[t_SLK] ([rf_idCase]) INCLUDE ([SL_K]) ON [AccountMU]
GO
ALTER TABLE [dbo].[t_SLK] ADD CONSTRAINT [FK_SLK_Cases] FOREIGN KEY ([rf_idCase]) REFERENCES [dbo].[t_Case] ([id]) ON DELETE CASCADE
GO
