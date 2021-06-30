IF NOT EXISTS (SELECT * FROM master.dbo.syslogins WHERE loginname = N'vtfoms\LVeremeeva')
CREATE LOGIN [vtfoms\LVeremeeva] FROM WINDOWS
GO
CREATE USER [vtfoms\LVeremeeva] FOR LOGIN [vtfoms\LVeremeeva]
GO
