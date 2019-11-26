CREATE TABLE [dbo].[t_AdditionalFilterRequests]
(
[userLogin] [nchar] (50) COLLATE Cyrillic_General_CI_AS NULL,
[additionalFilterRequest] [nchar] (256) COLLATE Cyrillic_General_CI_AS NULL,
[timeStamp] [datetime] NULL,
[dateBeginFilter] [date] NULL,
[dateEndFilter] [date] NULL,
[MOCodeFilter] [bigint] NULL,
[filialCodeFilter] [smallint] NULL,
[selRCount] [int] NULL,
[version] [nchar] (20) COLLATE Cyrillic_General_CI_AS NULL,
[startRepPeriod] [nchar] (6) COLLATE Cyrillic_General_CI_AS NULL,
[endRepPeriod] [nchar] (6) COLLATE Cyrillic_General_CI_AS NULL
) ON [PRIMARY]
GO
GRANT SELECT ON  [dbo].[t_AdditionalFilterRequests] TO [db_AccountOMS]
GRANT INSERT ON  [dbo].[t_AdditionalFilterRequests] TO [db_AccountOMS]
GO
