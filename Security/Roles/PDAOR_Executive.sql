CREATE ROLE [PDAOR_Executive]
AUTHORIZATION [VTFOMS\VZarya]
GO
EXEC sp_addrolemember N'PDAOR_Executive', N'secret\ngonzhal'
GO
EXEC sp_addrolemember N'PDAOR_Executive', N'VTFOMS\ggaidarova'
GO
EXEC sp_addrolemember N'PDAOR_Executive', N'vtfoms\snikitenko'
GO
EXEC sp_addrolemember N'PDAOR_Executive', N'vtfoms\spavlenko'
GO
EXEC sp_addrolemember N'PDAOR_Executive', N'vtfoms\SSomova'
GO
EXEC sp_addrolemember N'PDAOR_Executive', N'vtfoms\TLoginova'
GO
