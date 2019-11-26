IF NOT EXISTS (SELECT * FROM master.dbo.syslogins WHERE loginname = N'vtfoms\aaleksandrova')
CREATE LOGIN [vtfoms\aaleksandrova] FROM WINDOWS
GO
CREATE USER [vtfoms\aaleksandrova] FOR LOGIN [vtfoms\aaleksandrova]
GO
