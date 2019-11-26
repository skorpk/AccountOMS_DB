IF NOT EXISTS (SELECT * FROM master.dbo.syslogins WHERE loginname = N'vtfoms\eiloktionova')
CREATE LOGIN [vtfoms\eiloktionova] FROM WINDOWS
GO
CREATE USER [vtfoms\eiloktionova] FOR LOGIN [vtfoms\eiloktionova]
GO
