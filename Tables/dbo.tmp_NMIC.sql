CREATE TABLE [dbo].[tmp_NMIC]
(
[NumberQuestion] [nvarchar] (255) COLLATE Cyrillic_General_CI_AS NULL,
[Адрес ТКП] [nvarchar] (255) COLLATE Cyrillic_General_CI_AS NULL,
[OID] [nvarchar] (255) COLLATE Cyrillic_General_CI_AS NULL,
[FullNameMO] [nvarchar] (255) COLLATE Cyrillic_General_CI_AS NULL,
[ShortNameMO] [nvarchar] (255) COLLATE Cyrillic_General_CI_AS NULL,
[ShortNameNMIC] [nvarchar] (255) COLLATE Cyrillic_General_CI_AS NULL,
[IdPacient] [nvarchar] (255) COLLATE Cyrillic_General_CI_AS NULL,
[SNILS] [nvarchar] (20) COLLATE Cyrillic_General_CI_AS NULL,
[ENP] [nvarchar] (23) COLLATE Cyrillic_General_CI_AS NULL,
[DateConclusion] [datetime] NULL,
[Profil] [nvarchar] (255) COLLATE Cyrillic_General_CI_AS NULL,
[Приоритет] [nvarchar] (255) COLLATE Cyrillic_General_CI_AS NULL,
[CodeM] [char] (6) COLLATE Cyrillic_General_CI_AS NULL,
[id] [int] NOT NULL IDENTITY(1, 1)
) ON [PRIMARY]
GO
