CREATE TABLE [dbo].[t_SendingDataIntoFFOMS]
(
[id] [bigint] NULL,
[IDPeople] [int] NULL,
[rf_idCase] [bigint] NOT NULL,
[CodeM] [char] (6) COLLATE Cyrillic_General_CI_AS NOT NULL,
[rf_idMO] [char] (6) COLLATE Cyrillic_General_CI_AS NOT NULL,
[ReportMonth] [tinyint] NOT NULL,
[ReportYear] [smallint] NOT NULL,
[rf_idF008] [tinyint] NOT NULL,
[rf_idV006] [tinyint] NOT NULL,
[SeriaPolis] [varchar] (10) COLLATE Cyrillic_General_CI_AS NULL,
[NumberPolis] [varchar] (20) COLLATE Cyrillic_General_CI_AS NOT NULL,
[BirthDay] [date] NOT NULL,
[rf_idV005] [tinyint] NOT NULL,
[idRecordCase] [bigint] NOT NULL,
[rf_idV014] [tinyint] NULL,
[UnitOfHospital] [varchar] (16) COLLATE Cyrillic_General_CI_AS NULL,
[DateBegin] [date] NOT NULL,
[DateEnd] [date] NOT NULL,
[DS1] [char] (10) COLLATE Cyrillic_General_CI_AS NULL,
[DS2] [char] (10) COLLATE Cyrillic_General_CI_AS NULL,
[DS3] [char] (10) COLLATE Cyrillic_General_CI_AS NULL,
[rf_idV009] [smallint] NOT NULL,
[MES] [varchar] (20) COLLATE Cyrillic_General_CI_AS NULL,
[AmountPayment] [decimal] (15, 2) NOT NULL,
[idMU] [varchar] (36) COLLATE Cyrillic_General_CI_AS NULL,
[MUSurgery] [varchar] (16) COLLATE Cyrillic_General_CI_AS NULL,
[Age] [smallint] NULL,
[VZST] [int] NOT NULL,
[K_KSG] [varchar] (5) COLLATE Cyrillic_General_CI_AS NULL,
[KSG_PG] [int] NOT NULL,
[PVT] [int] NOT NULL,
[IsDisableCheck] [int] NOT NULL,
[IsFullDoubleDate] [bit] NOT NULL CONSTRAINT [DF__t_Sending__IsFul__43A1D464] DEFAULT ((0)),
[IsUnload] [bit] NOT NULL CONSTRAINT [DF__t_Sending__IsUnl__4495F89D] DEFAULT ((0)),
[IT_SL] [decimal] (3, 2) NULL,
[SL_K] AS (case when [IT_SL] IS NOT NULL then (1) else (0) end),
[ENP] [varchar] (16) COLLATE Cyrillic_General_CI_AS NULL,
[TypeCases] [tinyint] NOT NULL CONSTRAINT [DF__t_Sending__TypeC__458A1CD6] DEFAULT ((9)),
[Quantity] [int] NULL,
[TotalPriceMU] [decimal] (15, 2) NULL,
[UR_K] [tinyint] NULL,
[DKK1] [varchar] (10) COLLATE Cyrillic_General_CI_AS NULL,
[DKK2] [varchar] (10) COLLATE Cyrillic_General_CI_AS NULL
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_SendIsUnloadReportYearDs2] ON [dbo].[t_SendingDataIntoFFOMS] ([IsUnload], [ReportYear]) INCLUDE ([DS1], [DS2], [DS3]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_ReportYear_MES_IdCase] ON [dbo].[t_SendingDataIntoFFOMS] ([IsUnload], [ReportYear]) INCLUDE ([MES], [rf_idCase]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_ReportMonthFullDoubleDate2018] ON [dbo].[t_SendingDataIntoFFOMS] ([ReportMonth], [ReportYear], [IsFullDoubleDate], [IsUnload]) INCLUDE ([AmountPayment], [BirthDay], [DateBegin], [DateEnd], [DS1], [DS2], [DS3], [id], [idMU], [IT_SL], [K_KSG], [KSG_PG], [MUSurgery], [NumberPolis], [PVT], [rf_idCase], [rf_idF008], [rf_idMO], [rf_idV005], [rf_idV009], [rf_idV014], [SeriaPolis], [SL_K], [UnitOfHospital], [VZST]) ON [PRIMARY]
GO
