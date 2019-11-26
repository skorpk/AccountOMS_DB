IF NOT EXISTS (SELECT * FROM master.dbo.syslogins WHERE loginname = N'VTFOMS\sql.test')
CREATE LOGIN [VTFOMS\sql.test] FROM WINDOWS
GO
CREATE USER [vtfoms\sql.test] FOR LOGIN [VTFOMS\sql.test]
GO
