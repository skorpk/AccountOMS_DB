CREATE TABLE [dbo].[sprMUSurgeryKSG]
(
[MUSurgery] [varchar] (14) COLLATE Cyrillic_General_CI_AS NOT NULL,
[SurgeryName] [varchar] (240) COLLATE Cyrillic_General_CI_AS NOT NULL
) ON [PRIMARY]
GO
GRANT SELECT ON  [dbo].[sprMUSurgeryKSG] TO [db_AccountOMS]
GRANT INSERT ON  [dbo].[sprMUSurgeryKSG] TO [db_AccountOMS]
GO
