CREATE TABLE [dbo].[T_inform202007]
(
[ENP] [varchar] (16) COLLATE Cyrillic_General_CI_AS NOT NULL,
[flag] [float] NULL,
[DS] [varchar] (6) COLLATE Cyrillic_General_CI_AS NULL,
[Sex] [tinyint] NULL,
[Age] [smallint] NULL,
[ReportYear] [smallint] NOT NULL CONSTRAINT [DF__T_inform2__Repor__422536F4] DEFAULT ((2021)),
[NotificationDate] [date] NULL
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_Inform] ON [dbo].[T_inform202007] ([flag], [Sex]) INCLUDE ([Age], [ENP]) ON [PRIMARY]
GO
