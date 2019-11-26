CREATE TABLE [dbo].[t_uslug]
(
[Stoim] [decimal] (38, 4) NULL,
[rf_idMO] [char] (6) COLLATE Cyrillic_General_CI_AS NOT NULL,
[MUGroupCode] [tinyint] NOT NULL,
[MUUnGroupCode] [tinyint] NOT NULL,
[MUCode] [smallint] NOT NULL
) ON [PRIMARY]
GO
GRANT SELECT ON  [dbo].[t_uslug] TO [db_AccountOMS]
GRANT INSERT ON  [dbo].[t_uslug] TO [db_AccountOMS]
GO
