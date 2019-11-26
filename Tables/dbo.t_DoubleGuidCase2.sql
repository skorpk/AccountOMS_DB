CREATE TABLE [dbo].[t_DoubleGuidCase2]
(
[rf_idFiles] [int] NOT NULL,
[FileNameHR] [varchar] (26) COLLATE Cyrillic_General_CI_AS NOT NULL,
[DateRegistration] [datetime] NOT NULL,
[rf_idAccount] [int] NOT NULL,
[rf_idAccountNew] [int] NULL
) ON [PRIMARY]
GO
GRANT SELECT ON  [dbo].[t_DoubleGuidCase2] TO [db_AccountOMS]
GRANT INSERT ON  [dbo].[t_DoubleGuidCase2] TO [db_AccountOMS]
GO
