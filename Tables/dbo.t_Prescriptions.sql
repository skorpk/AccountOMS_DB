CREATE TABLE [dbo].[t_Prescriptions]
(
[rf_idCase] [bigint] NOT NULL,
[NAZR] [tinyint] NOT NULL,
[rf_idV015] [smallint] NULL,
[TypeExamination] [tinyint] NULL,
[rf_dV002] [smallint] NULL,
[rf_idV020] [smallint] NULL,
[id] [tinyint] NULL,
[DirectionDate] [date] NULL,
[DirectionMU] [varchar] (15) COLLATE Cyrillic_General_CI_AS NULL,
[DirectionMO] [varchar] (6) COLLATE Cyrillic_General_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[t_Prescriptions] ADD CONSTRAINT [FK_Prescriptions_Info_Cases] FOREIGN KEY ([rf_idCase]) REFERENCES [dbo].[t_Case] ([id]) ON DELETE CASCADE
GO
GRANT SELECT ON  [dbo].[t_Prescriptions] TO [db_AccountOMS]
GRANT INSERT ON  [dbo].[t_Prescriptions] TO [db_AccountOMS]
GO
