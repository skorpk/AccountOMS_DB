CREATE TABLE [dbo].[t_CaseFinancePlan]
(
[id] [int] NULL,
[DateRegistration] [datetime] NULL,
[CodeM] [char] (6) COLLATE Cyrillic_General_CI_AS NULL,
[rf_idCase] [bigint] NULL,
[AmountPayment] [decimal] (15, 2) NULL,
[DateEnd] [date] NULL,
[rf_idV006] [tinyint] NULL,
[Quantity] [int] NULL,
[UnitCode] [int] NULL,
[reportMonth] AS (datepart(month,[DateEnd])),
[ReportYear] AS (datepart(year,[DateEnd]))
) ON [AccountMU]
GO
CREATE NONCLUSTERED INDEX [IX_File] ON [dbo].[t_CaseFinancePlan] ([id]) ON [AccountMU]
GO
CREATE NONCLUSTERED INDEX [IX_UnitCode_Year_DateReg_Month] ON [dbo].[t_CaseFinancePlan] ([UnitCode], [ReportYear], [DateRegistration], [reportMonth]) INCLUDE ([AmountPayment], [CodeM], [Quantity], [rf_idCase]) ON [AccountMU]
GO
