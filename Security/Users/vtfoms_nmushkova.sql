IF NOT EXISTS (SELECT * FROM master.dbo.syslogins WHERE loginname = N'VTFOMS\nmushkova')
CREATE LOGIN [VTFOMS\nmushkova] FROM WINDOWS
GO
CREATE USER [vtfoms\nmushkova] FOR LOGIN [VTFOMS\nmushkova]
GO
