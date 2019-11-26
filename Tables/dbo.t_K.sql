CREATE TABLE [dbo].[t_K]
(
[npp] [int] NULL,
[nschet] [varchar] (50) COLLATE Cyrillic_General_CI_AS NULL,
[dschet] [varchar] (50) COLLATE Cyrillic_General_CI_AS NULL,
[ncase] [int] NULL,
[polis] [varchar] (20) COLLATE Cyrillic_General_CI_AS NULL,
[enp] [varchar] (20) COLLATE Cyrillic_General_CI_AS NULL,
[address] [varchar] (1000) COLLATE Cyrillic_General_CI_AS NULL,
[addressp] [varchar] (1000) COLLATE Cyrillic_General_CI_AS NULL,
[id] [bigint] NOT NULL,
[rf_idSMO] [char] (5) COLLATE Cyrillic_General_CI_AS NULL
) ON [PRIMARY]
GO
