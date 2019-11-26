IF NOT EXISTS (SELECT * FROM master.dbo.syslogins WHERE loginname = N'vtfoms\lkovaleva')
CREATE LOGIN [vtfoms\lkovaleva] FROM WINDOWS
GO
CREATE USER [vtfoms\lkovaleva] FOR LOGIN [vtfoms\lkovaleva]
GO
