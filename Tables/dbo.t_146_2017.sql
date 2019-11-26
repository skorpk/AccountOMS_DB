CREATE TABLE [dbo].[t_146_2017]
(
[DateRegistration] [datetime] NULL,
[id] [int] NULL,
[rf_idSMO] [int] NULL,
[rf_idMO] [int] NULL,
[MUGroupCode] [tinyint] NULL,
[MUUnGroupCode] [tinyint] NULL,
[MUCode] [smallint] NULL,
[MUSurgery] [varchar] (20) COLLATE Cyrillic_General_CI_AS NULL,
[Quantity] [decimal] (6, 2) NULL,
[AmountPayment] [decimal] (15, 2) NULL,
[Fam] [varchar] (40) COLLATE Cyrillic_General_CI_AS NULL,
[Im] [varchar] (40) COLLATE Cyrillic_General_CI_AS NULL,
[Ot] [varchar] (40) COLLATE Cyrillic_General_CI_AS NULL,
[BirthDay] [date] NULL,
[Age] [smallint] NULL,
[NewBorn] [varchar] (9) COLLATE Cyrillic_General_CI_AS NULL,
[FamP] [varchar] (40) COLLATE Cyrillic_General_CI_AS NULL,
[ImP] [varchar] (40) COLLATE Cyrillic_General_CI_AS NULL,
[OtP] [varchar] (40) COLLATE Cyrillic_General_CI_AS NULL,
[BirthDayP] [date] NULL,
[VMP_K] [varchar] (1) COLLATE Cyrillic_General_CI_AS NULL,
[UE] [varchar] (20) COLLATE Cyrillic_General_CI_AS NULL,
[AdultUET] [numeric] (5, 2) NULL,
[ChildUET] [numeric] (5, 2) NULL
) ON [PRIMARY]
GO
