CREATE TABLE [dbo].[t_SendingDataIntoFFOMS2017]
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
[IsFullDoubleDate] [bit] NOT NULL CONSTRAINT [DF__t_Sending__IsFul__1FA39FB9] DEFAULT ((0)),
[IsUnload] [bit] NOT NULL CONSTRAINT [DF__t_Sending__IsUnl__61716316] DEFAULT ((0)),
[IT_SL] [decimal] (3, 2) NULL,
[SL_K] AS (case when [IT_SL] IS NOT NULL then (1) else (0) end),
[ENP] [varchar] (16) COLLATE Cyrillic_General_CI_AS NULL,
[TypeCases] [tinyint] NOT NULL CONSTRAINT [DF__t_Sending__TypeC__662BF692] DEFAULT ((9))
) ON [PRIMARY]
GO
GRANT SELECT ON  [dbo].[t_SendingDataIntoFFOMS2017] TO [db_AccountOMS]
GRANT INSERT ON  [dbo].[t_SendingDataIntoFFOMS2017] TO [db_AccountOMS]
GO
