IF NOT EXISTS (SELECT * FROM master.dbo.syslogins WHERE loginname = N'vtfoms\IKazmina')
CREATE LOGIN [vtfoms\IKazmina] FROM WINDOWS
GO
CREATE USER [vtfoms\IKazmina] FOR LOGIN [vtfoms\IKazmina]
GO
