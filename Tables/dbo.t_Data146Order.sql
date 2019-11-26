CREATE TABLE [dbo].[t_Data146Order]
(
[CodeM] [char] (6) COLLATE Cyrillic_General_CI_AS NOT NULL,
[CodeSMO] [char] (5) COLLATE Cyrillic_General_CI_AS NOT NULL,
[ReportMonth] [tinyint] NULL,
[ReportYear] [smallint] NULL,
[UnitAccounting] [tinyint] NOT NULL,
[MonthQuantity] [decimal] (11, 2) NOT NULL,
[MonthPeople] [int] NOT NULL,
[MonthAmount] [decimal] (11, 2) NOT NULL,
[YearQuantity] [decimal] (11, 2) NOT NULL,
[YearPeople] [int] NOT NULL,
[YearAmount] [decimal] (11, 2) NOT NULL
) ON [PRIMARY]
GO
GRANT SELECT ON  [dbo].[t_Data146Order] TO [db_AccountOMS]
GRANT INSERT ON  [dbo].[t_Data146Order] TO [db_AccountOMS]
GO
