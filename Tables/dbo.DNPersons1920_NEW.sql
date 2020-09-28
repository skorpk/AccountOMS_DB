CREATE TABLE [dbo].[DNPersons1920_NEW]
(
[ENP] [varchar] (16) COLLATE Cyrillic_General_CI_AS NULL,
[YEAR] [int] NULL,
[Pid] [int] NULL
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_DN] ON [dbo].[DNPersons1920_NEW] ([YEAR]) INCLUDE ([ENP], [Pid]) ON [PRIMARY]
GO
