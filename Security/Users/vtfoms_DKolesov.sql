IF NOT EXISTS (SELECT * FROM master.dbo.syslogins WHERE loginname = N'vtfoms\DKolesov')
CREATE LOGIN [vtfoms\DKolesov] FROM WINDOWS
GO
CREATE USER [vtfoms\DKolesov] FOR LOGIN [vtfoms\DKolesov]
GO
