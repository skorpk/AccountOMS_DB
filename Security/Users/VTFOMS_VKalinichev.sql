IF NOT EXISTS (SELECT * FROM master.dbo.syslogins WHERE loginname = N'vtfoms\vkalinichev')
CREATE LOGIN [vtfoms\vkalinichev] FROM WINDOWS
GO
CREATE USER [VTFOMS\VKalinichev] FOR LOGIN [vtfoms\vkalinichev]
GO
