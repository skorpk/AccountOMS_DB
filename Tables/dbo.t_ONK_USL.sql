CREATE TABLE [dbo].[t_ONK_USL]
(
[rf_idCase] [bigint] NOT NULL,
[GUID_MU] [uniqueidentifier] NULL,
[rf_idN013] [tinyint] NOT NULL,
[TypeSurgery] [tinyint] NULL,
[TypeDrug] [tinyint] NULL,
[TypeCycleOfDrug] [tinyint] NULL,
[TypeRadiationTherapy] [tinyint] NULL,
[PPTR] [tinyint] NULL,
[id] [smallint] NULL
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_Case_ONKSL_All] ON [dbo].[t_ONK_USL] ([rf_idCase]) INCLUDE ([PPTR], [rf_idN013], [TypeCycleOfDrug], [TypeDrug], [TypeRadiationTherapy], [TypeSurgery]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_ONKUSL_N013] ON [dbo].[t_ONK_USL] ([rf_idN013]) INCLUDE ([rf_idCase]) ON [PRIMARY]
GO
GRANT INSERT ON  [dbo].[t_ONK_USL] TO [db_AccountOMS]
GO
GRANT SELECT ON  [dbo].[t_ONK_USL] TO [db_AccountOMS]
GO
