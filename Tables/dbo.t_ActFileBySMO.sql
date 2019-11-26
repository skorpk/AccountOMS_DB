CREATE TABLE [dbo].[t_ActFileBySMO]
(
[id] [int] NOT NULL IDENTITY(1, 1),
[ActFileName] [varchar] (25) COLLATE Cyrillic_General_CI_AS NULL,
[DateCreate] [datetime] NOT NULL CONSTRAINT [DF__t_ActFile__DateC__5EB4F1FC] DEFAULT (getdate()),
[CodeM] AS (substring([ActFileName],(6),(6)))
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[t_ActFileBySMO] ADD CONSTRAINT [PK__t_ActFil__3213E83F5CCCA98A] PRIMARY KEY CLUSTERED  ([id]) ON [PRIMARY]
GO
GRANT SELECT ON  [dbo].[t_ActFileBySMO] TO [db_AccountOMS]
GRANT INSERT ON  [dbo].[t_ActFileBySMO] TO [db_AccountOMS]
GO
