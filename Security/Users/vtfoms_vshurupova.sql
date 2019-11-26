IF NOT EXISTS (SELECT * FROM master.dbo.syslogins WHERE loginname = N'vtfoms\VShurupova')
CREATE LOGIN [vtfoms\VShurupova] FROM WINDOWS
GO
CREATE USER [vtfoms\vshurupova] FOR LOGIN [vtfoms\VShurupova]
GO
