IF NOT EXISTS (SELECT * FROM master.dbo.syslogins WHERE loginname = N'vtfoms\ibogacheva')
CREATE LOGIN [vtfoms\ibogacheva] FROM WINDOWS
GO
CREATE USER [vtfoms\ibogacheva] FOR LOGIN [vtfoms\ibogacheva]
GO
