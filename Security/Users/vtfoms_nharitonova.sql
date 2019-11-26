IF NOT EXISTS (SELECT * FROM master.dbo.syslogins WHERE loginname = N'vtfoms\nharitonova')
CREATE LOGIN [vtfoms\nharitonova] FROM WINDOWS
GO
CREATE USER [vtfoms\nharitonova] FOR LOGIN [vtfoms\nharitonova]
GO
