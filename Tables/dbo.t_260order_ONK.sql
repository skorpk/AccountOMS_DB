CREATE TABLE [dbo].[t_260order_ONK]
(
[id] [int] NOT NULL,
[VERSION] [char] (5) COLLATE Cyrillic_General_CI_AS NOT NULL,
[DATA] [date] NULL,
[FILENAME] [varchar] (26) COLLATE Cyrillic_General_CI_AS NULL,
[CODE] [int] NOT NULL,
[CODE_MO] [char] (6) COLLATE Cyrillic_General_CI_AS NOT NULL,
[YEAR] [smallint] NULL,
[MONTH] [tinyint] NULL,
[Account] [varchar] (15) COLLATE Cyrillic_General_CI_AS NULL,
[DateRegister] [date] NOT NULL,
[PLAT] [char] (5) COLLATE Cyrillic_General_CI_AS NULL,
[SUMMAV] [decimal] (15, 2) NOT NULL,
[rf_idRecordCasePatient] [int] NOT NULL,
[N_ZAP] [int] NULL,
[IsNew] [bit] NULL,
[ID_PAC] [varchar] (36) COLLATE Cyrillic_General_CI_AS NOT NULL,
[VPOLIS] [tinyint] NOT NULL,
[SPOLIS] [varchar] (10) COLLATE Cyrillic_General_CI_AS NULL,
[NPOLIS] [varchar] (20) COLLATE Cyrillic_General_CI_AS NULL,
[ST_OKATO] [varchar] (5) COLLATE Cyrillic_General_CI_AS NULL,
[rf_idSMO] [char] (5) COLLATE Cyrillic_General_CI_AS NULL,
[SMO_OGRN] [char] (15) COLLATE Cyrillic_General_CI_AS NULL,
[SMO_OK] [char] (5) COLLATE Cyrillic_General_CI_AS NULL,
[SMO_NAM] [nvarchar] (100) COLLATE Cyrillic_General_CI_AS NULL,
[MSE] [tinyint] NULL,
[NOVOR] [varchar] (9) COLLATE Cyrillic_General_CI_AS NOT NULL,
[BirthWeight] [smallint] NULL,
[IDCASE] [bigint] NOT NULL,
[USL_OK] [tinyint] NOT NULL,
[VIDPOM] [smallint] NOT NULL,
[FOR_POM] [tinyint] NULL,
[NPR_MO] [char] (6) COLLATE Cyrillic_General_CI_AS NULL,
[LPU] [char] (6) COLLATE Cyrillic_General_CI_AS NOT NULL,
[DATE_Z_1] [date] NOT NULL,
[Date_Z_2] [date] NOT NULL,
[KD_Z] [smallint] NULL,
[RSLT] [smallint] NOT NULL,
[ISHOD] [smallint] NOT NULL,
[IDSP] [tinyint] NOT NULL,
[AmountPayment] [decimal] (15, 2) NULL,
[rf_idCase] [bigint] NOT NULL,
[GUID_Case] [uniqueidentifier] NOT NULL,
[VID_HMP] [varchar] (19) COLLATE Cyrillic_General_CI_AS NULL,
[METOD_HMP] [int] NULL,
[LPU_1] [varchar] (8) COLLATE Cyrillic_General_CI_AS NULL,
[PODR] [int] NULL,
[rf_idV002] [smallint] NOT NULL,
[PROFIL_K] [smallint] NULL,
[DET] [bit] NULL,
[TAL_D] [date] NULL,
[TAL_NUM] [varchar] (20) COLLATE Cyrillic_General_CI_AS NULL,
[TAL_P] [date] NULL,
[NHISTORY] [nvarchar] (50) COLLATE Cyrillic_General_CI_AS NOT NULL,
[DATE_1] [date] NOT NULL,
[DATE_2] [date] NOT NULL,
[DS1] [char] (10) COLLATE Cyrillic_General_CI_AS NULL,
[C_ZAB] [tinyint] NULL,
[DS_ONK] [tinyint] NULL,
[PRVS] [int] NOT NULL,
[VERS_SPEC] [varchar] (4) COLLATE Cyrillic_General_CI_AS NOT NULL,
[IDDOKT] [varchar] (25) COLLATE Cyrillic_General_CI_AS NULL,
[Quantity] [decimal] (5, 2) NULL,
[Tariff] [decimal] (15, 2) NULL,
[SUM_M] [decimal] (15, 2) NOT NULL,
[NumberPackage] AS (right([FILENAME],(1))),
[CodeSMO34] [char] (5) COLLATE Cyrillic_General_CI_AS NULL,
[IsUnload] [tinyint] NULL
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_IDSP] ON [dbo].[t_260order_ONK] ([IDSP]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_Unload_260] ON [dbo].[t_260order_ONK] ([IsUnload]) INCLUDE ([MONTH], [YEAR]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_260_LPU] ON [dbo].[t_260order_ONK] ([LPU]) INCLUDE ([AmountPayment], [DATE_Z_1], [Date_Z_2], [FOR_POM], [id], [IDCASE], [IDSP], [ISHOD], [KD_Z], [N_ZAP], [NPR_MO], [rf_idCase], [rf_idRecordCasePatient], [RSLT], [USL_OK], [VIDPOM]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_IdCase] ON [dbo].[t_260order_ONK] ([rf_idCase]) INCLUDE ([C_ZAB], [DATE_1], [DATE_2], [DET], [DS_ONK], [DS1], [IDDOKT], [NHISTORY], [PROFIL_K], [PRVS], [Quantity], [SUM_M], [VERS_SPEC]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_260_UslOK] ON [dbo].[t_260order_ONK] ([USL_OK]) INCLUDE ([Date_Z_2], [rf_idCase]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_Rerport_1] ON [dbo].[t_260order_ONK] ([YEAR], [MONTH]) INCLUDE ([Account], [CODE], [CODE_MO], [CodeSMO34], [DATA], [DateRegister], [FILENAME], [id], [ID_PAC], [IsNew], [N_ZAP], [NOVOR], [NPOLIS], [PLAT], [rf_idCase], [rf_idRecordCasePatient], [rf_idSMO], [SPOLIS], [SUMMAV], [VERSION], [VPOLIS]) ON [PRIMARY]
GO
