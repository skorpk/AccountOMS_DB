CREATE TABLE [dbo].[t_Consultation]
(
[rf_idCase] [bigint] NOT NULL,
[PR_CONS] [tinyint] NOT NULL,
[DateCons] [date] NULL
) ON [AccountMU]
GO
CREATE NONCLUSTERED INDEX [IX_Consultation] ON [dbo].[t_Consultation] ([rf_idCase]) INCLUDE ([DateCons], [PR_CONS]) ON [AccountMU]
GO
ALTER TABLE [dbo].[t_Consultation] ADD CONSTRAINT [FK_Coonsultation_Cases] FOREIGN KEY ([rf_idCase]) REFERENCES [dbo].[t_Case] ([id]) ON DELETE CASCADE
GO
