IF NOT EXISTS (SELECT * FROM master.dbo.syslogins WHERE loginname = N'vtfoms\AKrehov')
CREATE LOGIN [vtfoms\AKrehov] FROM WINDOWS
GO
CREATE USER [vtfoms\AKrehov] FOR LOGIN [vtfoms\AKrehov]
GO
