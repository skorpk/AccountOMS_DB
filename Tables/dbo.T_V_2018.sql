CREATE TABLE [dbo].[T_V_2018]
(
[filialCode] [int] NULL,
[filialName] [varchar] (50) COLLATE Cyrillic_General_CI_AS NOT NULL,
[ReportYear] [smallint] NOT NULL,
[rf_idMO] [char] (6) COLLATE Cyrillic_General_CI_AS NOT NULL,
[NAMES] [varchar] (250) COLLATE Cyrillic_General_CI_AS NULL,
[rf_idDoctor] [varchar] (25) COLLATE Cyrillic_General_CI_AS NULL,
[rf_idV004] [int] NOT NULL,
[NAME] [nvarchar] (254) COLLATE Cyrillic_General_CI_AS NULL,
[fullNAME] [varchar] (1200) COLLATE Cyrillic_General_CI_AS NULL
) ON [PRIMARY]
GO
