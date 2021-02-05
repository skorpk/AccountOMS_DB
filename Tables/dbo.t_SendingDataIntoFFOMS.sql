CREATE TABLE [dbo].[t_SendingDataIntoFFOMS]
(
[id_old] [bigint] NULL,
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
[UnitOfHospital] [varchar] (20) COLLATE Cyrillic_General_CI_AS NULL,
[DateBegin] [date] NOT NULL,
[DateEnd] [date] NOT NULL,
[DS1] [char] (10) COLLATE Cyrillic_General_CI_AS NULL,
[DS2] [char] (10) COLLATE Cyrillic_General_CI_AS NULL,
[DS3] [char] (10) COLLATE Cyrillic_General_CI_AS NULL,
[rf_idV009] [smallint] NOT NULL,
[MES] [varchar] (20) COLLATE Cyrillic_General_CI_AS NULL,
[AmountPayment] [decimal] (15, 2) NOT NULL,
[AmountPaymentZSL] [decimal] (15, 2) NOT NULL,
[idMU] [varchar] (36) COLLATE Cyrillic_General_CI_AS NULL,
[MUSurgery] [varchar] (20) COLLATE Cyrillic_General_CI_AS NULL,
[Age] [smallint] NULL,
[VZST] [int] NOT NULL,
[K_KSG] [varchar] (20) COLLATE Cyrillic_General_CI_AS NULL,
[KSG_PG] [int] NOT NULL,
[PVT] [int] NOT NULL,
[IsDisableCheck] [int] NOT NULL,
[IsFullDoubleDate] [bit] NOT NULL CONSTRAINT [DF__t_Sending__IsFul__54D818B5] DEFAULT ((0)),
[IsUnload] [bit] NOT NULL CONSTRAINT [DF__t_Sending__IsUnl__55CC3CEE] DEFAULT ((0)),
[IT_SL] [decimal] (3, 2) NULL,
[ENP] [varchar] (16) COLLATE Cyrillic_General_CI_AS NULL,
[TypeCases] [tinyint] NOT NULL,
[Quantity] [int] NULL,
[TotalPriceMU] [decimal] (15, 2) NULL,
[UR_K] [tinyint] NULL,
[IDSP] [tinyint] NULL,
[NewValue] [tinyint] NOT NULL CONSTRAINT [DF__t_Sending__NewVa__56C06127] DEFAULT ((0)),
[id] [bigint] NULL,
[DateInsert] [smalldatetime] NOT NULL,
[SL_K] AS (case  when [IT_SL] IS NOT NULL then (1) else (0) end)
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_2] ON [dbo].[t_SendingDataIntoFFOMS] ([IDSP]) INCLUDE ([IsDisableCheck]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_10] ON [dbo].[t_SendingDataIntoFFOMS] ([MES]) INCLUDE ([IsDisableCheck]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_3] ON [dbo].[t_SendingDataIntoFFOMS] ([PVT], [IsUnload]) INCLUDE ([DateBegin], [DateEnd], [DS1], [ENP], [rf_idCase], [rf_idV006]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_4] ON [dbo].[t_SendingDataIntoFFOMS] ([ReportMonth], [ReportYear], [DS1]) INCLUDE ([AmountPayment], [BirthDay], [DateBegin], [DateEnd], [DS2], [DS3], [id], [IDSP], [IsDisableCheck], [IsFullDoubleDate], [IsUnload], [IT_SL], [K_KSG], [KSG_PG], [NumberPolis], [PVT], [rf_idCase], [rf_idF008], [rf_idMO], [rf_idV005], [rf_idV009], [rf_idV014], [SeriaPolis], [TypeCases], [UnitOfHospital], [UR_K], [VZST]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_9] ON [dbo].[t_SendingDataIntoFFOMS] ([ReportYear], [IsDisableCheck], [IsFullDoubleDate]) INCLUDE ([DateBegin], [DateEnd], [DS1], [ENP], [rf_idV006]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_11] ON [dbo].[t_SendingDataIntoFFOMS] ([ReportYear], [PVT], [IsDisableCheck], [IsFullDoubleDate]) INCLUDE ([DS1], [ENP], [rf_idCase], [rf_idV006]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_8] ON [dbo].[t_SendingDataIntoFFOMS] ([rf_idCase]) INCLUDE ([PVT]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_5] ON [dbo].[t_SendingDataIntoFFOMS] ([rf_idV006], [DateBegin], [DateEnd], [DS1], [IsUnload], [ENP]) INCLUDE ([IsDisableCheck], [IsFullDoubleDate], [ReportMonth], [ReportYear], [rf_idCase]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_7] ON [dbo].[t_SendingDataIntoFFOMS] ([rf_idV006], [DateBegin], [DateEnd], [DS1], [IsUnload], [ENP]) INCLUDE ([IsDisableCheck], [ReportYear], [rf_idCase]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_1] ON [dbo].[t_SendingDataIntoFFOMS] ([rf_idV006], [MES], [IDSP]) INCLUDE ([IsDisableCheck]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_6] ON [dbo].[t_SendingDataIntoFFOMS] ([rf_idV009], [IsUnload]) INCLUDE ([DateBegin], [DateEnd], [DS1], [ENP], [IsDisableCheck], [rf_idCase], [rf_idV006]) ON [PRIMARY]
GO
