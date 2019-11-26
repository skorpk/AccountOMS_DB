IF NOT EXISTS (SELECT * FROM master.dbo.syslogins WHERE loginname = N'vtfoms\GDyachenko')
CREATE LOGIN [vtfoms\GDyachenko] FROM WINDOWS
GO
CREATE USER [vtfoms\GDyachenko] FOR LOGIN [vtfoms\GDyachenko]
GO
