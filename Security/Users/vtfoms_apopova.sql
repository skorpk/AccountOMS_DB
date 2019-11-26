IF NOT EXISTS (SELECT * FROM master.dbo.syslogins WHERE loginname = N'vtfoms\apopova')
CREATE LOGIN [vtfoms\apopova] FROM WINDOWS
GO
CREATE USER [vtfoms\apopova] FOR LOGIN [vtfoms\apopova]
GO
