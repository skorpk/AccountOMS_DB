CREATE TABLE [dbo].[T_DN2019GOOD]
(
[ReportYear] [smallint] NOT NULL,
[ENP] [varchar] (16) COLLATE Cyrillic_General_CI_AS NULL,
[W] [char] (1) COLLATE Cyrillic_General_CI_AS NULL,
[DateEnd] [date] NOT NULL,
[DS1] [varchar] (50) COLLATE Cyrillic_General_CI_AS NULL,
[DS2] [nvarchar] (max) COLLATE Cyrillic_General_CI_AS NULL,
[IsDNType] [tinyint] NOT NULL,
[col8] [tinyint] NULL,
[Col9] [date] NULL,
[id] [int] NOT NULL IDENTITY(1, 1)
) ON [PRIMARY]
GO
