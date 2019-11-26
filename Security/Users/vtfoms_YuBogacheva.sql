IF NOT EXISTS (SELECT * FROM master.dbo.syslogins WHERE loginname = N'vtfoms\YuBogacheva')
CREATE LOGIN [vtfoms\YuBogacheva] FROM WINDOWS
GO
CREATE USER [vtfoms\YuBogacheva] FOR LOGIN [vtfoms\YuBogacheva]
GO
