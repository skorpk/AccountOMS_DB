CREATE TABLE [dbo].[t_DoubleGuidCase]
(
[rf_idFiles] [int] NOT NULL,
[FileNameHR] [varchar] (26) COLLATE Cyrillic_General_CI_AS NOT NULL,
[DateRegistration] [datetime] NOT NULL
) ON [PRIMARY]
GO
GRANT SELECT ON  [dbo].[t_DoubleGuidCase] TO [db_AccountOMS]
GRANT INSERT ON  [dbo].[t_DoubleGuidCase] TO [db_AccountOMS]
GO
