CREATE TABLE [dbo].[t_DataForWCFSynch]
(
[rf_idCase] [bigint] NULL,
[PID] [int] NULL,
[DateLoad] [datetime] NOT NULL CONSTRAINT [DF__t_DataFor__DateL__40857097] DEFAULT (getdate())
) ON [PRIMARY]
GO
CREATE UNIQUE CLUSTERED INDEX [CL_ID_PID] ON [dbo].[t_DataForWCFSynch] ([rf_idCase], [PID]) ON [PRIMARY]
GO
