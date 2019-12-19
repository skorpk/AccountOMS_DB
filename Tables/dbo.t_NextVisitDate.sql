CREATE TABLE [dbo].[t_NextVisitDate]
(
[rf_idCase] [bigint] NOT NULL,
[DateVizit] [date] NOT NULL
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [<Name of Missing Index, sysname,>] ON [dbo].[t_NextVisitDate] ([rf_idCase]) INCLUDE ([DateVizit]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[t_NextVisitDate] ADD CONSTRAINT [FK_NextVisitDate_Cases] FOREIGN KEY ([rf_idCase]) REFERENCES [dbo].[t_Case] ([id]) ON DELETE CASCADE
GO
GRANT INSERT ON  [dbo].[t_NextVisitDate] TO [db_AccountOMS]
GO
GRANT SELECT ON  [dbo].[t_NextVisitDate] TO [db_AccountOMS]
GO
