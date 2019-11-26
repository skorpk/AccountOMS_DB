CREATE TABLE [dbo].[t_Errors]
(
[ErrorNumber] [smallint] NOT NULL,
[rf_idFileError] [int] NOT NULL,
[rf_sprErrorAccount] [tinyint] NULL
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_idFileError_Number] ON [dbo].[t_Errors] ([rf_idFileError]) INCLUDE ([ErrorNumber]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[t_Errors] ADD CONSTRAINT [FK_Errors_FileError] FOREIGN KEY ([rf_idFileError]) REFERENCES [dbo].[t_FileError] ([id]) ON DELETE CASCADE
GO
GRANT SELECT ON  [dbo].[t_Errors] TO [db_AccountOMS]
GRANT INSERT ON  [dbo].[t_Errors] TO [db_AccountOMS]
GO
