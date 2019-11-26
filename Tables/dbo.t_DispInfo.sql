CREATE TABLE [dbo].[t_DispInfo]
(
[rf_idCase] [bigint] NOT NULL,
[TypeDisp] [varchar] (3) COLLATE Cyrillic_General_CI_AS NOT NULL,
[IsMobileTeam] [bit] NOT NULL,
[TypeFailure] [tinyint] NOT NULL,
[IsOnko] [tinyint] NULL
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_DispInfo] ON [dbo].[t_DispInfo] ([IsOnko]) INCLUDE ([rf_idCase]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_DispInfo_TypeFailure] ON [dbo].[t_DispInfo] ([rf_idCase]) INCLUDE ([IsMobileTeam], [TypeDisp], [TypeFailure]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_DispType_1] ON [dbo].[t_DispInfo] ([rf_idCase], [TypeDisp]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[t_DispInfo] ADD CONSTRAINT [FK_DispInfo_Cases] FOREIGN KEY ([rf_idCase]) REFERENCES [dbo].[t_Case] ([id]) ON DELETE CASCADE
GO
GRANT SELECT ON  [dbo].[t_DispInfo] TO [db_AccountOMS]
GRANT INSERT ON  [dbo].[t_DispInfo] TO [db_AccountOMS]
GO
