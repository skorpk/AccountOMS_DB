CREATE TABLE [dbo].[tmp_InformationNMRC]
(
[NumberPolicy] [varchar] (20) COLLATE Cyrillic_General_CI_AS NOT NULL,
[CodeM] [varchar] (6) COLLATE Cyrillic_General_CI_AS NOT NULL,
[DateConsultation] [datetime2] (3) NOT NULL,
[idRow] [int] NULL
) ON [PRIMARY]
GO
