CREATE TABLE [dbo].[tmp_BSSS2]
(
[ENP] [varchar] (16) COLLATE Cyrillic_General_CI_AS NULL,
[DS1] [char] (10) COLLATE Cyrillic_General_CI_AS NULL,
[DN] [tinyint] NULL,
[rf_idCase] [bigint] NOT NULL,
[DateRegistration] [datetime] NOT NULL,
[rf_D02Person] [int] NULL,
[ReportMonth] [tinyint] NOT NULL,
[IsListOfDN] [int] NOT NULL,
[MainDS] [varchar] (6) COLLATE Cyrillic_General_CI_AS NULL
) ON [PRIMARY]
GO
