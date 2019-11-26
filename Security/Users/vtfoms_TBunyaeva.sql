IF NOT EXISTS (SELECT * FROM master.dbo.syslogins WHERE loginname = N'vtfoms\TBunyaeva')
CREATE LOGIN [vtfoms\TBunyaeva] FROM WINDOWS
GO
CREATE USER [vtfoms\TBunyaeva] FOR LOGIN [vtfoms\TBunyaeva]
GO
