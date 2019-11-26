IF NOT EXISTS (SELECT * FROM master.dbo.syslogins WHERE loginname = N'vtfoms\OKolesnikova')
CREATE LOGIN [vtfoms\OKolesnikova] FROM WINDOWS
GO
CREATE USER [vtfoms\OKolesnikova] FOR LOGIN [vtfoms\OKolesnikova]
GO
