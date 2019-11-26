CREATE TABLE [dbo].[t_ReasonDenialPayment]
(
[rf_idCase] [bigint] NOT NULL,
[idAkt] [int] NOT NULL,
[CodeReason] [smallint] NULL,
[id] [int] NOT NULL
) ON [PRIMARY]
GO
CREATE UNIQUE NONCLUSTERED INDEX [UQ_ReasonID] ON [dbo].[t_ReasonDenialPayment] ([rf_idCase], [idAkt], [id]) INCLUDE ([CodeReason]) WITH (IGNORE_DUP_KEY=ON) ON [PRIMARY]
GO
GRANT SELECT ON  [dbo].[t_ReasonDenialPayment] TO [AccountsOMS]
GRANT SELECT ON  [dbo].[t_ReasonDenialPayment] TO [db_AccountOMS]
GO
