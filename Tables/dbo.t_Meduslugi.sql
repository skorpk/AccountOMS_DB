CREATE TABLE [dbo].[t_Meduslugi]
(
[rf_idCase] [bigint] NOT NULL,
[id] [varchar] (36) COLLATE Cyrillic_General_CI_AS NOT NULL,
[GUID_MU] [uniqueidentifier] NOT NULL,
[rf_idMO] [char] (6) COLLATE Cyrillic_General_CI_AS NOT NULL,
[rf_idSubMO] [char] (6) COLLATE Cyrillic_General_CI_AS NULL,
[rf_idDepartmentMO] [int] NULL,
[rf_idV002] [smallint] NOT NULL,
[IsChildTariff] [bit] NULL,
[DateHelpBegin] [date] NOT NULL,
[DateHelpEnd] [date] NOT NULL,
[DiagnosisCode] [char] (10) COLLATE Cyrillic_General_CI_AS NULL,
[MUGroupCode] [tinyint] NOT NULL,
[MUUnGroupCode] [tinyint] NOT NULL,
[MUCode] [smallint] NOT NULL,
[Quantity] [decimal] (6, 2) NOT NULL,
[Price] [decimal] (15, 2) NOT NULL,
[TotalPrice] [decimal] (15, 2) NOT NULL,
[rf_idV004] [int] NOT NULL,
[rf_idDoctor] [char] (16) COLLATE Cyrillic_General_CI_AS NULL,
[Comments] [nvarchar] (250) COLLATE Cyrillic_General_CI_AS NULL,
[MUSurgery] [varchar] (20) COLLATE Cyrillic_General_CI_AS NULL,
[MU] AS ((((CONVERT([varchar](2),[MUGroupCode],(0))+'.')+CONVERT([varchar](2),[MUUnGroupCode],(0)))+'.')+CONVERT([varchar](3),[MUCode],(0))),
[MUInt] AS (([MUGroupCode]*(100000)+[MUUnGroupCode]*(1000))+[MUCode]),
[IsNeedUsl] [tinyint] NULL
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_MU_IdCase] ON [dbo].[t_Meduslugi] ([MUGroupCode], [MUUnGroupCode]) INCLUDE ([rf_idCase]) ON [AccountMU]
GO
CREATE NONCLUSTERED INDEX [IX_MU_RefCase_ID] ON [dbo].[t_Meduslugi] ([rf_idCase]) INCLUDE ([Comments], [DateHelpBegin], [DateHelpEnd], [DiagnosisCode], [GUID_MU], [id], [IsChildTariff], [IsNeedUsl], [MUCode], [MUGroupCode], [MUSurgery], [MUUnGroupCode], [Price], [Quantity], [rf_idDepartmentMO], [rf_idDoctor], [rf_idMO], [rf_idSubMO], [rf_idV002], [rf_idV004], [TotalPrice]) ON [AccountMU]
GO
CREATE UNIQUE NONCLUSTERED INDEX [QU_Case_MU] ON [dbo].[t_Meduslugi] ([rf_idCase], [GUID_MU]) WITH (IGNORE_DUP_KEY=ON) ON [AccountMU]
GO
ALTER TABLE [dbo].[t_Meduslugi] ADD CONSTRAINT [FK_Meduslugi_Cases2] FOREIGN KEY ([rf_idCase]) REFERENCES [dbo].[t_Case] ([id]) ON DELETE CASCADE
GO
GRANT SELECT ON  [dbo].[t_Meduslugi] TO [PDAOR_Executive]
GO
