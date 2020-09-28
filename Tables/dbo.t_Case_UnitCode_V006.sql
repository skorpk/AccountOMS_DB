CREATE TABLE [dbo].[t_Case_UnitCode_V006]
(
[DateInsert] [datetime] NOT NULL CONSTRAINT [DF__t_Case_Un__DateI__0777DBC4] DEFAULT (getdate()),
[rf_idCase] [bigint] NOT NULL,
[UnitCode] [smallint] NOT NULL,
[V006] [tinyint] NOT NULL,
[DateRegistration] [datetime] NOT NULL,
[CodeM] [varchar] (6) COLLATE Cyrillic_General_CI_AS NOT NULL,
[Qunatity] [int] NOT NULL
) ON [AccountMU]
GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_IdCase] ON [dbo].[t_Case_UnitCode_V006] ([rf_idCase], [UnitCode]) INCLUDE ([V006]) WITH (IGNORE_DUP_KEY=ON) ON [AccountMU]
GO
CREATE NONCLUSTERED INDEX [<Name of Missing Index, sysname,>] ON [dbo].[t_Case_UnitCode_V006] ([UnitCode]) INCLUDE ([rf_idCase]) ON [AccountMU]
GO
CREATE NONCLUSTERED INDEX [IX_UnitCode] ON [dbo].[t_Case_UnitCode_V006] ([UnitCode]) INCLUDE ([Qunatity], [rf_idCase]) ON [AccountMU]
GO
