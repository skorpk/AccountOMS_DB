IF NOT EXISTS (SELECT * FROM master.dbo.syslogins WHERE loginname = N'VTFOMS\SRomanovskii')
CREATE LOGIN [VTFOMS\SRomanovskii] FROM WINDOWS
GO
CREATE USER [vtfoms\SRomanovskii] FOR LOGIN [VTFOMS\SRomanovskii]
GO
