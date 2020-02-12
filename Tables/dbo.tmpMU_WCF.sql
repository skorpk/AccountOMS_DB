CREATE TABLE [dbo].[tmpMU_WCF]
(
[rf_idCase] [bigint] NULL,
[MUUnGroupCode] [tinyint] NULL,
[MUGroupCode] [tinyint] NULL,
[MUCode] [smallint] NULL,
[rf_idV002] [smallint] NULL,
[DateBegin] [date] NULL,
[DateEnd] [date] NULL,
[Quantity] [decimal] (6, 2) NULL,
[Tariff] [decimal] (15, 2) NULL,
[MUSurgery] [varchar] (16) COLLATE Cyrillic_General_CI_AS NULL
) ON [PRIMARY]
GO
