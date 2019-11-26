IF NOT EXISTS (SELECT * FROM master.dbo.syslogins WHERE loginname = N'vtfoms\SLazareva')
CREATE LOGIN [vtfoms\SLazareva] FROM WINDOWS
GO
CREATE USER [vtfoms\SLazareva] FOR LOGIN [vtfoms\SLazareva]
GO
