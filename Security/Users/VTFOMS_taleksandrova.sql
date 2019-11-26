IF NOT EXISTS (SELECT * FROM master.dbo.syslogins WHERE loginname = N'VTFOMS\taleksandrova')
CREATE LOGIN [VTFOMS\taleksandrova] FROM WINDOWS
GO
CREATE USER [VTFOMS\taleksandrova] FOR LOGIN [VTFOMS\taleksandrova]
GO
