IF NOT EXISTS (SELECT * FROM master.dbo.syslogins WHERE loginname = N'vtfoms\OKocarev')
CREATE LOGIN [vtfoms\OKocarev] FROM WINDOWS
GO
CREATE USER [vtfoms\OKocarev] FOR LOGIN [vtfoms\OKocarev]
GO
