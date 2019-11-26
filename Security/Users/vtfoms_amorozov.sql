IF NOT EXISTS (SELECT * FROM master.dbo.syslogins WHERE loginname = N'vtfoms\amorozov')
CREATE LOGIN [vtfoms\amorozov] FROM WINDOWS
GO
CREATE USER [vtfoms\amorozov] FOR LOGIN [vtfoms\amorozov]
GO
