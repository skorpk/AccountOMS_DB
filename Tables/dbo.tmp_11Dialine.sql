CREATE TABLE [dbo].[tmp_11Dialine]
(
[rf_idCase] [float] NULL,
[Код МО] [float] NULL,
[Наименование МО] [nvarchar] (255) COLLATE Cyrillic_General_CI_AS NULL,
[Номер счета] [nvarchar] (255) COLLATE Cyrillic_General_CI_AS NULL,
[Дата регистрации счета] [datetime] NULL,
[Номер случая в счете] [float] NULL,
[Условия оказания] [nvarchar] (255) COLLATE Cyrillic_General_CI_AS NULL,
[Профиль] [nvarchar] (255) COLLATE Cyrillic_General_CI_AS NULL,
[Код КСГ/Законченного случая] [nvarchar] (255) COLLATE Cyrillic_General_CI_AS NULL,
[Наименование КСГ/ЗС] [nvarchar] (255) COLLATE Cyrillic_General_CI_AS NULL,
[Код МУ] [nvarchar] (255) COLLATE Cyrillic_General_CI_AS NULL,
[Наименование МУ] [nvarchar] (255) COLLATE Cyrillic_General_CI_AS NULL,
[Начало случая] [datetime] NULL,
[Окончание случая] [datetime] NULL,
[Стоимость случая] [float] NULL,
[ENP] [varchar] (16) COLLATE Cyrillic_General_CI_AS NULL,
[Fam] [nvarchar] (40) COLLATE Cyrillic_General_CI_AS NULL,
[Im] [nvarchar] (40) COLLATE Cyrillic_General_CI_AS NULL,
[Ot] [nvarchar] (40) COLLATE Cyrillic_General_CI_AS NULL,
[BirthDay] [date] NULL,
[RepMon] [smallint] NULL
) ON [PRIMARY]
GO
