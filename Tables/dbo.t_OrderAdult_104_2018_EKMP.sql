CREATE TABLE [dbo].[t_OrderAdult_104_2018_EKMP]
(
[rf_idCase] [bigint] NOT NULL,
[AmountPayment] [decimal] (15, 2) NOT NULL,
[AmountDeduction] [decimal] (15, 2) NOT NULL,
[Age] [smallint] NULL,
[DS1] [char] (10) COLLATE Cyrillic_General_CI_AS NULL,
[ENP] [varchar] (16) COLLATE Cyrillic_General_CI_AS NULL,
[rf_idV009] [smallint] NOT NULL,
[rf_idV006] [tinyint] NOT NULL,
[rf_idV014] [tinyint] NULL,
[BirthDay] [date] NULL,
[AP_Type] [char] (1) COLLATE Cyrillic_General_CI_AS NULL,
[DateBegin] [date] NOT NULL,
[DateEnd] [date] NOT NULL,
[Gosp_type] [int] NULL,
[ReportMonth] [tinyint] NOT NULL,
[ReportYear] [smallint] NOT NULL,
[PVT] [int] NOT NULL,
[Reason] [varchar] (20) COLLATE Cyrillic_General_CI_AS NULL,
[TypeExp] [int] NOT NULL,
[IsEKMP] [int] NOT NULL
) ON [PRIMARY]
GO
