CREATE TABLE [dbo].[t_NEWs]
(
[IsSpecialCase] [tinyint] NULL,
[id] [bigint] NOT NULL,
[GUID_Case] [uniqueidentifier] NOT NULL,
[Fam] [nvarchar] (40) COLLATE Cyrillic_General_CI_AS NOT NULL,
[Im] [nvarchar] (40) COLLATE Cyrillic_General_CI_AS NOT NULL,
[Ot] [nvarchar] (40) COLLATE Cyrillic_General_CI_AS NOT NULL,
[AttachLPU] [char] (6) COLLATE Cyrillic_General_CI_AS NULL,
[BirthDay] [date] NOT NULL,
[AttachMoName] [varchar] (250) COLLATE Cyrillic_General_CI_AS NULL,
[Account] [varchar] (15) COLLATE Cyrillic_General_CI_AS NULL,
[idRecordCase] [bigint] NOT NULL,
[DateRegister] [date] NOT NULL,
[Name] [varchar] (254) COLLATE Cyrillic_General_CI_AS NULL,
[DateBegin] [varchar] (10) COLLATE Cyrillic_General_CI_AS NULL,
[DateEnd] [varchar] (10) COLLATE Cyrillic_General_CI_AS NULL,
[AmountPayment] [decimal] (15, 2) NOT NULL,
[CodeM] [varchar] (6) COLLATE Cyrillic_General_CI_AS NULL,
[MOName] [varchar] (250) COLLATE Cyrillic_General_CI_AS NULL,
[PeopleID] [bigint] NULL,
[AmountPaymentAccept] [numeric] (11, 2) NULL,
[sNameS] [varchar] (250) COLLATE Cyrillic_General_CI_AS NULL
) ON [PRIMARY]
GO
GRANT SELECT ON  [dbo].[t_NEWs] TO [db_AccountOMS]
GRANT INSERT ON  [dbo].[t_NEWs] TO [db_AccountOMS]
GO
