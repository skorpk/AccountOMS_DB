CREATE TABLE [dbo].[t_ReliabilityPatient]
(
[rf_idRegisterPatient] [int] NULL,
[TypeReliability] [tinyint] NULL,
[IsAttendant] [bit] NULL
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_idRegisterPatient_Type_Attendant] ON [dbo].[t_ReliabilityPatient] ([rf_idRegisterPatient]) INCLUDE ([IsAttendant], [TypeReliability]) ON [PRIMARY]
GO
GRANT SELECT ON  [dbo].[t_ReliabilityPatient] TO [db_AccountOMS]
GRANT INSERT ON  [dbo].[t_ReliabilityPatient] TO [db_AccountOMS]
GO
