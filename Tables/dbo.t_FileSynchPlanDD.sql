CREATE TABLE [dbo].[t_FileSynchPlanDD]
(
[rf_idFile] [int] NOT NULL,
[DateSynch] [datetime] NOT NULL CONSTRAINT [DF__t_FileSyn__DateS__2D3D91F9] DEFAULT (getdate())
) ON [PRIMARY]
GO
