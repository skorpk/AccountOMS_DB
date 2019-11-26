IF NOT EXISTS (SELECT * FROM master.dbo.syslogins WHERE loginname = N'vtfoms\NSemenov')
CREATE LOGIN [vtfoms\NSemenov] FROM WINDOWS
GO
CREATE USER [vtfoms\NSemenov] FOR LOGIN [vtfoms\NSemenov]
GO
