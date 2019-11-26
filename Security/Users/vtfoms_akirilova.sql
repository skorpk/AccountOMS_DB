IF NOT EXISTS (SELECT * FROM master.dbo.syslogins WHERE loginname = N'VTFOMS\AKirilova')
CREATE LOGIN [VTFOMS\AKirilova] FROM WINDOWS
GO
CREATE USER [vtfoms\akirilova] FOR LOGIN [VTFOMS\AKirilova]
GO
