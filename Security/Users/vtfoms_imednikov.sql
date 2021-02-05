IF NOT EXISTS (SELECT * FROM master.dbo.syslogins WHERE loginname = N'vtfoms\imednikov')
CREATE LOGIN [vtfoms\imednikov] FROM WINDOWS
GO
CREATE USER [vtfoms\imednikov] FOR LOGIN [vtfoms\imednikov]
GO
