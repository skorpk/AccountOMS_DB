IF NOT EXISTS (SELECT * FROM master.dbo.syslogins WHERE loginname = N'vtfoms\NVelikanova')
CREATE LOGIN [vtfoms\NVelikanova] FROM WINDOWS
GO
CREATE USER [vtfoms\nVelikanova] FOR LOGIN [vtfoms\NVelikanova]
GO
