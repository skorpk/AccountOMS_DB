IF NOT EXISTS (SELECT * FROM master.dbo.syslogins WHERE loginname = N'vtfoms\ndorofeychuk')
CREATE LOGIN [vtfoms\ndorofeychuk] FROM WINDOWS
GO
CREATE USER [vtfoms\ndorofeychuk] FOR LOGIN [vtfoms\ndorofeychuk]
GO
