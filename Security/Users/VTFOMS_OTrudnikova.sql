IF NOT EXISTS (SELECT * FROM master.dbo.syslogins WHERE loginname = N'VTFOMS\OTrudnikova')
CREATE LOGIN [VTFOMS\OTrudnikova] FROM WINDOWS
GO
CREATE USER [VTFOMS\OTrudnikova] FOR LOGIN [VTFOMS\OTrudnikova]
GO
