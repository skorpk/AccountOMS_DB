CREATE TABLE [dbo].[t_AgeSexDisp]
(
[BirthYear2015] [smallint] NULL,
[letter] [nchar] (1) COLLATE Cyrillic_General_CI_AS NULL
) ON [PRIMARY]
GO
GRANT SELECT ON  [dbo].[t_AgeSexDisp] TO [db_AccountOMS]
GRANT INSERT ON  [dbo].[t_AgeSexDisp] TO [db_AccountOMS]
GO
