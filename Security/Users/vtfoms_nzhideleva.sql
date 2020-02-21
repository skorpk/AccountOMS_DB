IF NOT EXISTS (SELECT * FROM master.dbo.syslogins WHERE loginname = N'vtfoms\nzhideleva')
CREATE LOGIN [vtfoms\nzhideleva] FROM WINDOWS
GO
CREATE USER [vtfoms\nzhideleva] FOR LOGIN [vtfoms\nzhideleva]
GO
