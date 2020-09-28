CREATE TABLE [dbo].[T_PROC_20200922]
(
[Fam] [nvarchar] (40) COLLATE Cyrillic_General_CI_AS NULL,
[Im] [nvarchar] (40) COLLATE Cyrillic_General_CI_AS NULL,
[Ot] [nvarchar] (40) COLLATE Cyrillic_General_CI_AS NULL,
[BirthDay] [date] NULL,
[ENP] [char] (30) COLLATE Cyrillic_General_CI_AS NULL,
[DateRegister] [date] NOT NULL,
[DateBegin] [date] NOT NULL,
[DateEnd] [date] NOT NULL,
[rf_idMO] [char] (6) COLLATE Cyrillic_General_CI_AS NOT NULL,
[Expr1] [decimal] (38, 2) NULL,
[AmountPayment] [decimal] (15, 2) NOT NULL,
[Address] [nvarchar] (200) COLLATE Cyrillic_General_CI_AS NULL
) ON [PRIMARY]
GO
