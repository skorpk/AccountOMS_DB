IF NOT EXISTS (SELECT * FROM master.dbo.syslogins WHERE loginname = N'vtfoms\VUshakova')
CREATE LOGIN [vtfoms\VUshakova] FROM WINDOWS
GO
CREATE USER [vtfoms\VUshakova] FOR LOGIN [vtfoms\VUshakova]
GO
