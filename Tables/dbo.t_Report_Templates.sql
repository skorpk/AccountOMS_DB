CREATE TABLE [dbo].[t_Report_Templates]
(
[id] [int] NOT NULL IDENTITY(1, 1),
[NameFile] [varchar] (50) COLLATE Cyrillic_General_CI_AS NOT NULL,
[DateLoad] [datetime] NOT NULL CONSTRAINT [DF__t_Report___DateL__7F57970F] DEFAULT (getdate()),
[UserName] [varchar] (50) COLLATE Cyrillic_General_CI_AS NOT NULL CONSTRAINT [DF__t_Report___UserN__004BBB48] DEFAULT (original_login()),
[DATA] [varbinary] (max) NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
