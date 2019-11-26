CREATE TABLE [dbo].[t_BadDiag260]
(
[rf_idONK_SL] [int] NOT NULL,
[CodeDiagnostic] [smallint] NOT NULL
) ON [PRIMARY]
GO
CREATE UNIQUE NONCLUSTERED INDEX [qu_Id_Code] ON [dbo].[t_BadDiag260] ([rf_idONK_SL], [CodeDiagnostic]) WITH (IGNORE_DUP_KEY=ON) ON [PRIMARY]
GO
