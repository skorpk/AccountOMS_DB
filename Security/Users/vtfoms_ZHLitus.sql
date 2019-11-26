IF NOT EXISTS (SELECT * FROM master.dbo.syslogins WHERE loginname = N'vtfoms\ZHLitus')
CREATE LOGIN [vtfoms\ZHLitus] FROM WINDOWS
GO
CREATE USER [vtfoms\ZHLitus] FOR LOGIN [vtfoms\ZHLitus]
GO
