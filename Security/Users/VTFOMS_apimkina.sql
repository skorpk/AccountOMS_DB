IF NOT EXISTS (SELECT * FROM master.dbo.syslogins WHERE loginname = N'VTFOMS\apimkina')
CREATE LOGIN [VTFOMS\apimkina] FROM WINDOWS
GO
CREATE USER [VTFOMS\apimkina] FOR LOGIN [VTFOMS\apimkina]
GO
