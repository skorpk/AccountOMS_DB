IF NOT EXISTS (SELECT * FROM master.dbo.syslogins WHERE loginname = N'vtfoms\MShaporova')
CREATE LOGIN [vtfoms\MShaporova] FROM WINDOWS
GO
CREATE USER [vtfoms\mshaporova] FOR LOGIN [vtfoms\MShaporova]
GO
