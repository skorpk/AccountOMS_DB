CREATE TABLE [dbo].[t_PurposeOfVisit]
(
[rf_idCase] [bigint] NOT NULL,
[rf_idV025] [varchar] (3) COLLATE Cyrillic_General_CI_AS NULL,
[DN] [tinyint] NULL
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_PurposeOfVisit_Case] ON [dbo].[t_PurposeOfVisit] ([rf_idCase]) INCLUDE ([DN], [rf_idV025]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_PurposeOfVisit] ON [dbo].[t_PurposeOfVisit] ([rf_idV025], [DN]) INCLUDE ([rf_idCase]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_V025_DN_Case] ON [dbo].[t_PurposeOfVisit] ([rf_idV025], [DN]) INCLUDE ([rf_idCase]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[t_PurposeOfVisit] ADD CONSTRAINT [FK_PurposeOfVisit_Cases] FOREIGN KEY ([rf_idCase]) REFERENCES [dbo].[t_Case] ([id]) ON DELETE CASCADE
GO
GRANT INSERT ON  [dbo].[t_PurposeOfVisit] TO [db_AccountOMS]
GO
