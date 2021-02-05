CREATE ROLE [db_AccountsFinancing]
AUTHORIZATION [dbo]
EXEC sp_addrolemember N'db_AccountsFinancing', N'vtfoms\imednikov'

GO
EXEC sp_addrolemember N'db_AccountsFinancing', N'secret\ngonzhal'
GO
EXEC sp_addrolemember N'db_AccountsFinancing', N'test'
GO
EXEC sp_addrolemember N'db_AccountsFinancing', N'VTFOMS\ggaidarova'
GO
EXEC sp_addrolemember N'db_AccountsFinancing', N'vtfoms\snikitenko'
GO
EXEC sp_addrolemember N'db_AccountsFinancing', N'vtfoms\SSomova'
GO
