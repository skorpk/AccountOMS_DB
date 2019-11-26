CREATE TABLE [dbo].[V_PaymentMethodRelation]
(
[PaymentMethodId] [bigint] NOT NULL,
[Code_old] [bigint] NULL,
[Name_old] [varchar] (250) COLLATE Cyrillic_General_CI_AS NULL,
[PaymentMethodNewId] [bigint] NOT NULL,
[Code_new] [bigint] NULL,
[Name_new] [varchar] (250) COLLATE Cyrillic_General_CI_AS NULL
) ON [PRIMARY]
GO
