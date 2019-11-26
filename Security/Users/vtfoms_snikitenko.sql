IF NOT EXISTS (SELECT * FROM master.dbo.syslogins WHERE loginname = N'VTFOMS\snikitenko')
CREATE LOGIN [VTFOMS\snikitenko] FROM WINDOWS
GO
CREATE USER [vtfoms\snikitenko] FOR LOGIN [VTFOMS\snikitenko]
GO
