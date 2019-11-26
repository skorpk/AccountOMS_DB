CREATE TABLE [dbo].[t_SlipOfPaper]
(
[rf_idCase] [bigint] NOT NULL,
[GetDatePaper] [date] NULL,
[DateHospitalization] [date] NULL,
[NumberTicket] [varchar] (20) COLLATE Cyrillic_General_CI_AS NULL
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_SlipOfPaper] ON [dbo].[t_SlipOfPaper] ([rf_idCase]) INCLUDE ([DateHospitalization], [GetDatePaper], [NumberTicket]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[t_SlipOfPaper] ADD CONSTRAINT [FK_SlipOfPaper_Cases] FOREIGN KEY ([rf_idCase]) REFERENCES [dbo].[t_Case] ([id]) ON DELETE CASCADE
GO
GRANT SELECT ON  [dbo].[t_SlipOfPaper] TO [db_AccountOMS]
GRANT INSERT ON  [dbo].[t_SlipOfPaper] TO [db_AccountOMS]
GO
