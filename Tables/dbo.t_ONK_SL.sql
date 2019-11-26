CREATE TABLE [dbo].[t_ONK_SL]
(
[id] [int] NOT NULL IDENTITY(1, 1),
[rf_idCase] [bigint] NOT NULL,
[DS1_T] [tinyint] NULL,
[rf_idN002] [smallint] NULL,
[rf_idN003] [smallint] NULL,
[rf_idN004] [smallint] NULL,
[rf_idN005] [smallint] NULL,
[IsMetastasis] [tinyint] NULL,
[ConsultationInfo] [tinyint] NULL,
[TotalDose] [decimal] (5, 2) NULL,
[DateConsultation] [date] NULL,
[K_FR] [tinyint] NULL,
[WEI] [decimal] (5, 2) NULL,
[HEI] [tinyint] NULL,
[BSA] [decimal] (3, 2) NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[t_ONK_SL] ADD CONSTRAINT [PK__t_ONK_SL__3213E83F72B1C908] PRIMARY KEY CLUSTERED  ([id]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_ONK_SL_Case] ON [dbo].[t_ONK_SL] ([rf_idCase]) INCLUDE ([id]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[t_ONK_SL] ADD CONSTRAINT [FK_t_ONK_SL_Cases] FOREIGN KEY ([rf_idCase]) REFERENCES [dbo].[t_Case] ([id]) ON DELETE CASCADE
GO
GRANT SELECT ON  [dbo].[t_ONK_SL] TO [db_AccountOMS]
GRANT INSERT ON  [dbo].[t_ONK_SL] TO [db_AccountOMS]
GO
