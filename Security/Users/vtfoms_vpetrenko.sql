IF NOT EXISTS (SELECT * FROM master.dbo.syslogins WHERE loginname = N'vtfoms\vpetrenko')
CREATE LOGIN [vtfoms\vpetrenko] FROM WINDOWS
GO
CREATE USER [vtfoms\vpetrenko] FOR LOGIN [vtfoms\vpetrenko]
GO
