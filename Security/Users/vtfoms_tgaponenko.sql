IF NOT EXISTS (SELECT * FROM master.dbo.syslogins WHERE loginname = N'vtfoms\tgaponenko')
CREATE LOGIN [vtfoms\tgaponenko] FROM WINDOWS
GO
CREATE USER [vtfoms\tgaponenko] FOR LOGIN [vtfoms\tgaponenko]
GO
