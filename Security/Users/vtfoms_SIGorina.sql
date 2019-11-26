IF NOT EXISTS (SELECT * FROM master.dbo.syslogins WHERE loginname = N'vtfoms\SIGorina')
CREATE LOGIN [vtfoms\SIGorina] FROM WINDOWS
GO
CREATE USER [vtfoms\SIGorina] FOR LOGIN [vtfoms\SIGorina]
GO
