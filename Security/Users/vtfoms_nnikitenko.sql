IF NOT EXISTS (SELECT * FROM master.dbo.syslogins WHERE loginname = N'vtfoms\nnikitenko')
CREATE LOGIN [vtfoms\nnikitenko] FROM WINDOWS
GO
CREATE USER [vtfoms\nnikitenko] FOR LOGIN [vtfoms\nnikitenko]
GO
