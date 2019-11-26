IF NOT EXISTS (SELECT * FROM master.dbo.syslogins WHERE loginname = N'vtfoms\IChekomasova')
CREATE LOGIN [vtfoms\IChekomasova] FROM WINDOWS
GO
CREATE USER [vtfoms\IChekomasova] FOR LOGIN [vtfoms\IChekomasova]
GO
