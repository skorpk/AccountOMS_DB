IF NOT EXISTS (SELECT * FROM master.dbo.syslogins WHERE loginname = N'vtfoms\tantonova')
CREATE LOGIN [vtfoms\tantonova] FROM WINDOWS
GO
CREATE USER [vtfoms\tantonova] FOR LOGIN [vtfoms\tantonova]
GO
