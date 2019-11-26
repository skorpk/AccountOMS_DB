CREATE TABLE [dbo].[t_DrugTherapy]
(
[rf_idCase] [bigint] NOT NULL,
[rf_idN013] [tinyint] NOT NULL,
[rf_idV020] [varchar] (6) COLLATE Cyrillic_General_CI_AS NOT NULL,
[rf_idV024] [varchar] (10) COLLATE Cyrillic_General_CI_AS NOT NULL,
[DateInjection] [date] NOT NULL,
[rf_idONK_USL] [smallint] NULL
) ON [AccountMU]
GO
CREATE NONCLUSTERED INDEX [IX_Case_N0133_Drug] ON [dbo].[t_DrugTherapy] ([rf_idCase], [rf_idN013]) INCLUDE ([DateInjection], [rf_idV020], [rf_idV024]) ON [AccountMU]
GO
ALTER TABLE [dbo].[t_DrugTherapy] ADD CONSTRAINT [FK_DrugTherapy_Cases] FOREIGN KEY ([rf_idCase]) REFERENCES [dbo].[t_Case] ([id]) ON DELETE CASCADE
GO
