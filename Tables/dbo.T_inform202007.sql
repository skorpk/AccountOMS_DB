CREATE TABLE [dbo].[T_inform202007]
(
[ENP] [varchar] (16) COLLATE Cyrillic_General_CI_AS NOT NULL,
[flag] [float] NULL,
[DS] [varchar] (6) COLLATE Cyrillic_General_CI_AS NULL,
[Sex] [tinyint] NULL,
[Age] [smallint] NULL
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_Inform] ON [dbo].[T_inform202007] ([flag], [Sex]) INCLUDE ([Age], [ENP]) ON [PRIMARY]
GO
