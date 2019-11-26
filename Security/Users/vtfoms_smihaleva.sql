IF NOT EXISTS (SELECT * FROM master.dbo.syslogins WHERE loginname = N'VTFOMS\SMihaleva')
CREATE LOGIN [VTFOMS\SMihaleva] FROM WINDOWS
GO
CREATE USER [vtfoms\smihaleva] FOR LOGIN [VTFOMS\SMihaleva]
GO
