IF NOT EXISTS (SELECT * FROM master.dbo.syslogins WHERE loginname = N'vtfoms\okagalo')
CREATE LOGIN [vtfoms\okagalo] FROM WINDOWS
GO
CREATE USER [vtfoms\okagalo] FOR LOGIN [vtfoms\okagalo]
GO
