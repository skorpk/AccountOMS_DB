IF NOT EXISTS (SELECT * FROM master.dbo.syslogins WHERE loginname = N'VTFOMS\RSatonina')
CREATE LOGIN [VTFOMS\RSatonina] FROM WINDOWS
GO
CREATE USER [vtfoms\rsatonina] FOR LOGIN [VTFOMS\RSatonina]
GO
