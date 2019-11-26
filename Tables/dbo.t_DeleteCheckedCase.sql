CREATE TABLE [dbo].[t_DeleteCheckedCase]
(
[rf_idCase] [bigint] NULL,
[DateRegistration] [datetime] NULL,
[idAct] [int] NULL
) ON [PRIMARY]
GO
CREATE UNIQUE NONCLUSTERED INDEX [UQ_IdChechedCase_DateRegistration] ON [dbo].[t_DeleteCheckedCase] ([rf_idCase], [DateRegistration]) WITH (IGNORE_DUP_KEY=ON) ON [PRIMARY]
GO
