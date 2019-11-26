CREATE TABLE [dbo].[t_v_2015]
(
[filialCode] [int] NULL,
[filialName] [varchar] (50) COLLATE Cyrillic_General_CI_AS NOT NULL,
[ReportYear] [smallint] NOT NULL,
[rf_idMO] [char] (6) COLLATE Cyrillic_General_CI_AS NOT NULL,
[NAMES] [varchar] (250) COLLATE Cyrillic_General_CI_AS NULL,
[rf_idDoctor] [char] (16) COLLATE Cyrillic_General_CI_AS NULL,
[rf_idV004] [int] NOT NULL,
[Name] [varchar] (100) COLLATE Cyrillic_General_CI_AS NULL
) ON [PRIMARY]
GO
