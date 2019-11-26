IF NOT EXISTS (SELECT * FROM master.dbo.syslogins WHERE loginname = N'vtfoms\VSemikin')
CREATE LOGIN [vtfoms\VSemikin] FROM WINDOWS
GO
CREATE USER [vtfoms\VSemikin] FOR LOGIN [vtfoms\VSemikin]
GO
