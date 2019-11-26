IF NOT EXISTS (SELECT * FROM master.dbo.syslogins WHERE loginname = N'VTFOMS\EPoletkina')
CREATE LOGIN [VTFOMS\EPoletkina] FROM WINDOWS
GO
CREATE USER [vtfoms\EPoletkina] FOR LOGIN [VTFOMS\EPoletkina]
GO
