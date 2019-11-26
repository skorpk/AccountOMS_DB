IF NOT EXISTS (SELECT * FROM master.dbo.syslogins WHERE loginname = N'vtfoms\NShuvaeva')
CREATE LOGIN [vtfoms\NShuvaeva] FROM WINDOWS
GO
CREATE USER [vtfoms\NShuvaeva] FOR LOGIN [vtfoms\NShuvaeva]
GO
