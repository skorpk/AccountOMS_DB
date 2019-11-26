CREATE TABLE [dbo].[tmpTotal2Anket]
(
[rf_idV006] [tinyint] NULL,
[IDPeople] [bigint] NULL,
[rf_idV005] [tinyint] NULL,
[age] [tinyint] NULL,
[CodeM] [char] (6) COLLATE Cyrillic_General_CI_AS NULL,
[rf_idSMO] [char] (5) COLLATE Cyrillic_General_CI_AS NULL
) ON [PRIMARY]
GO
GRANT SELECT ON  [dbo].[tmpTotal2Anket] TO [db_AccountOMS]
GRANT INSERT ON  [dbo].[tmpTotal2Anket] TO [db_AccountOMS]
GO
