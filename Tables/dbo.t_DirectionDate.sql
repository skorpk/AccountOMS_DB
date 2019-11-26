CREATE TABLE [dbo].[t_DirectionDate]
(
[rf_idCase] [bigint] NOT NULL,
[DirectionDate] [date] NOT NULL
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_DirectionDate_RefCase] ON [dbo].[t_DirectionDate] ([rf_idCase]) INCLUDE ([DirectionDate]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[t_DirectionDate] ADD CONSTRAINT [FK_DirectionDate_Cases] FOREIGN KEY ([rf_idCase]) REFERENCES [dbo].[t_Case] ([id]) ON DELETE CASCADE
GO
GRANT INSERT ON  [dbo].[t_DirectionDate] TO [db_AccountOMS]
GO
