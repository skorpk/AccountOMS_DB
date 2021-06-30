CREATE TABLE [dbo].[DNPersons202007]
(
[ENP] [varchar] (16) COLLATE Cyrillic_General_CI_AS NULL,
[DATE_F] [date] NULL,
[rf_D02Person] [int] NOT NULL,
[DS] [char] (6) COLLATE Cyrillic_General_CI_AS NOT NULL,
[CODEM] [varchar] (6) COLLATE Cyrillic_General_CI_AS NULL,
[Age] [int] NULL,
[sex_ENP] [int] NULL,
[Sex] AS (case  when [sex_ENP]=(1) then 'М' else 'Ж' end),
[flag] [tinyint] NULL,
[ReportYear] [smallint] NOT NULL CONSTRAINT [DF__DNPersons__Repor__413112BB] DEFAULT ((2021)),
[DateRegistration] [datetime] NULL
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_ENP] ON [dbo].[DNPersons202007] ([ENP]) INCLUDE ([Age], [sex_ENP]) ON [PRIMARY]
GO
