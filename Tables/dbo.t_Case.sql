CREATE TABLE [dbo].[t_Case]
(
[id] [bigint] NOT NULL IDENTITY(1, 1) NOT FOR REPLICATION,
[rf_idRecordCasePatient] [int] NOT NULL,
[idRecordCase] [bigint] NOT NULL,
[GUID_Case] [uniqueidentifier] NOT NULL,
[rf_idV006] [tinyint] NOT NULL,
[rf_idV008] [smallint] NOT NULL,
[rf_idDirectMO] [char] (6) COLLATE Cyrillic_General_CI_AS NULL,
[HopitalisationType] [tinyint] NULL,
[rf_idMO] [char] (6) COLLATE Cyrillic_General_CI_AS NOT NULL,
[rf_idDepartmentMO] [int] NULL,
[rf_idV002] [smallint] NOT NULL,
[IsChildTariff] [bit] NULL,
[NumberHistoryCase] [nvarchar] (50) COLLATE Cyrillic_General_CI_AS NOT NULL,
[DateBegin] [date] NOT NULL,
[DateEnd] [date] NOT NULL,
[rf_idV009] [smallint] NOT NULL,
[rf_idV012] [smallint] NOT NULL,
[rf_idV004] [int] NOT NULL,
[IsSpecialCase] [tinyint] NULL,
[rf_idV010] [tinyint] NOT NULL,
[AmountPayment] [decimal] (15, 2) NOT NULL,
[TypePay] [tinyint] NULL,
[AmountPaymentAccept] [decimal] (15, 2) NULL,
[Comments] [nvarchar] (250) COLLATE Cyrillic_General_CI_AS NULL,
[Age] [smallint] NULL,
[IsCompletedCase] AS ([dbo].[IsCompletedCase]([id])),
[Emergency] [tinyint] NULL,
[rf_idV014] [tinyint] NULL,
[rf_idV018] [varchar] (19) COLLATE Cyrillic_General_CI_AS NULL,
[rf_idV019] [int] NULL,
[rf_idSubMO] [varchar] (8) COLLATE Cyrillic_General_CI_AS NULL,
[rf_idDoctor] [varchar] (25) COLLATE Cyrillic_General_CI_AS NULL,
[IT_SL] [decimal] (3, 2) NULL,
[TypeTranslation] [tinyint] NULL,
[IsFirstDS] [tinyint] NULL,
[IsNeedDisp] [tinyint] NULL,
[MSE] [tinyint] NULL,
[C_ZAB] [tinyint] NULL,
[KD] [smallint] NULL
) ON [AccountOMSCase]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE TRIGGER [dbo].[DeleteCase]
on [dbo].[t_Case]
AFTER Delete
AS
insert dbo.t_DeleteCase( rf_idCase ) select d.id from deleted d
GO
ALTER TABLE [dbo].[t_Case] ADD CONSTRAINT [CH_More_Equal_Zero] CHECK (([AmountPayment]>=(0)))
GO
ALTER TABLE [dbo].[t_Case] ADD CONSTRAINT [PK__t_Case__3213E83F38996AB5] PRIMARY KEY CLUSTERED  ([id]) ON [AccountOMSCase]
GO
CREATE NONCLUSTERED INDEX [IX_DateEnd_GUID_Case] ON [dbo].[t_Case] ([DateEnd]) INCLUDE ([Age], [AmountPayment], [DateBegin], [GUID_Case], [id], [idRecordCase], [IsChildTariff], [rf_idDepartmentMO], [rf_idDoctor], [rf_idMO], [rf_idRecordCasePatient], [rf_idSubMO], [rf_idV002], [rf_idV004], [rf_idV006]) ON [AccountOMSCase]
GO
CREATE NONCLUSTERED INDEX [IX_Report_Cardio] ON [dbo].[t_Case] ([DateEnd]) INCLUDE ([AmountPayment], [id], [rf_idRecordCasePatient], [rf_idV006], [rf_idV008]) ON [AccountOMSCase]
GO
CREATE NONCLUSTERED INDEX [IX_DateEnd_WCF_Case] ON [dbo].[t_Case] ([DateEnd], [id]) INCLUDE ([AmountPayment], [DateBegin], [rf_idMO], [rf_idV002], [rf_idV006]) ON [AccountOMSCase]
GO
SET NUMERIC_ROUNDABORT OFF
GO
SET ANSI_PADDING ON
GO
SET ANSI_WARNINGS ON
GO
SET CONCAT_NULL_YIELDS_NULL ON
GO
SET ARITHABORT ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE NONCLUSTERED INDEX [IX_GUID_DateEND_2017] ON [dbo].[t_Case] ([GUID_Case], [DateEnd]) WHERE ([DateEnd]>'20161231') ON [AccountOMSCase]
GO
CREATE NONCLUSTERED INDEX [IX_Case_idRecordCasePatient] ON [dbo].[t_Case] ([rf_idRecordCasePatient], [id]) INCLUDE ([Age], [AmountPayment], [AmountPaymentAccept], [C_ZAB], [Comments], [DateBegin], [DateEnd], [Emergency], [GUID_Case], [HopitalisationType], [idRecordCase], [IsChildTariff], [IsFirstDS], [IsNeedDisp], [IsSpecialCase], [IT_SL], [KD], [MSE], [NumberHistoryCase], [rf_idDepartmentMO], [rf_idDirectMO], [rf_idDoctor], [rf_idMO], [rf_idSubMO], [rf_idV002], [rf_idV004], [rf_idV006], [rf_idV008], [rf_idV009], [rf_idV010], [rf_idV012], [rf_idV014], [rf_idV018], [rf_idV019], [TypePay], [TypeTranslation]) ON [AccountOMSCase]
GO
CREATE NONCLUSTERED INDEX [IX_V006_Case] ON [dbo].[t_Case] ([rf_idV006]) INCLUDE ([Age], [AmountPayment], [DateBegin], [DateEnd], [id], [rf_idRecordCasePatient], [rf_idV002], [rf_idV008]) ON [AccountOMSCase]
GO
CREATE NONCLUSTERED INDEX [IX_rf_idV006_Age] ON [dbo].[t_Case] ([rf_idV006], [Age]) INCLUDE ([AmountPayment], [id], [rf_idRecordCasePatient]) ON [AccountOMSCase]
GO
CREATE NONCLUSTERED INDEX [IX_V006_DateEnd_V009_Age] ON [dbo].[t_Case] ([rf_idV006], [DateEnd], [rf_idV009], [Age]) INCLUDE ([AmountPayment], [DateBegin], [id], [rf_idRecordCasePatient], [rf_idV014]) ON [AccountOMSCase]
GO
CREATE NONCLUSTERED INDEX [IX_ReportShumeiko] ON [dbo].[t_Case] ([rf_idV006], [rf_idV002]) INCLUDE ([AmountPayment], [DateBegin], [DateEnd], [id], [idRecordCase], [NumberHistoryCase], [rf_idDepartmentMO], [rf_idMO], [rf_idRecordCasePatient], [rf_idV008], [rf_idV010]) ON [AccountOMSCase]
GO
CREATE NONCLUSTERED INDEX [IX_V006_V002_Age_Case] ON [dbo].[t_Case] ([rf_idV006], [rf_idV002], [Age]) INCLUDE ([id], [rf_idRecordCasePatient]) ON [AccountOMSCase]
GO
CREATE NONCLUSTERED INDEX [IX_V009_DateEnd_Report1] ON [dbo].[t_Case] ([rf_idV009], [DateEnd]) INCLUDE ([AmountPayment], [id], [idRecordCase], [IsChildTariff], [rf_idDoctor], [rf_idRecordCasePatient], [rf_idV002], [rf_idV006]) ON [AccountOMSCase]
GO
CREATE NONCLUSTERED INDEX [IX_V014] ON [dbo].[t_Case] ([rf_idV014]) INCLUDE ([AmountPayment], [id], [rf_idRecordCasePatient], [rf_idV002], [rf_idV004], [rf_idV006], [rf_idV009], [TypeTranslation]) ON [AccountOMSCase]
GO
ALTER TABLE [dbo].[t_Case] ADD CONSTRAINT [FK_Cases_RecordCasePatient] FOREIGN KEY ([rf_idRecordCasePatient]) REFERENCES [dbo].[t_RecordCasePatient] ([id]) ON DELETE CASCADE
GO
GRANT SELECT ON  [dbo].[t_Case] TO [AccountsOMS]
GO
GRANT INSERT ON  [dbo].[t_Case] TO [db_AccountOMS]
GO
GRANT SELECT ON  [dbo].[t_Case] TO [db_AccountOMS]
GO
GRANT SELECT ON  [dbo].[t_Case] TO [db_AccountsFinancing]
GO
GRANT SELECT ON  [dbo].[t_Case] TO [db_Financing]
GO
GRANT SELECT ON  [dbo].[t_Case] TO [PDAOR_Executive]
GO
SET NUMERIC_ROUNDABORT OFF
GO
SET ANSI_PADDING ON
GO
SET ANSI_WARNINGS ON
GO
SET CONCAT_NULL_YIELDS_NULL ON
GO
SET ARITHABORT ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
SET NUMERIC_ROUNDABORT OFF
GO
SET ANSI_PADDING ON
GO
SET ANSI_WARNINGS ON
GO
SET CONCAT_NULL_YIELDS_NULL ON
GO
SET ARITHABORT ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
SET NUMERIC_ROUNDABORT OFF
GO
SET ANSI_PADDING ON
GO
SET ANSI_WARNINGS ON
GO
SET CONCAT_NULL_YIELDS_NULL ON
GO
SET ARITHABORT ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
SET NUMERIC_ROUNDABORT OFF
GO
SET ANSI_PADDING ON
GO
SET ANSI_WARNINGS ON
GO
SET CONCAT_NULL_YIELDS_NULL ON
GO
SET ARITHABORT ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
SET NUMERIC_ROUNDABORT OFF
GO
SET ANSI_PADDING ON
GO
SET ANSI_WARNINGS ON
GO
SET CONCAT_NULL_YIELDS_NULL ON
GO
SET ARITHABORT ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
