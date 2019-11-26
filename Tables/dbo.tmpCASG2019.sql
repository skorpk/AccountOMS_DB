CREATE TABLE [dbo].[tmpCASG2019]
(
[CSG2019] [nvarchar] (10) COLLATE Cyrillic_General_CI_AS NULL,
[NameCSG2019] [nvarchar] (255) COLLATE Cyrillic_General_CI_AS NULL,
[CSG2018] [nvarchar] (10) COLLATE Cyrillic_General_CI_AS NULL,
[тип совпадения] [tinyint] NULL,
[CodeCSG] AS (left([CSG2018],(4)))
) ON [PRIMARY]
GO
