IF NOT EXISTS (SELECT * FROM master.dbo.syslogins WHERE loginname = N'VTFOMS\LGalishnikova')
CREATE LOGIN [VTFOMS\LGalishnikova] FROM WINDOWS
GO
CREATE USER [VTFOMS\LGalishnikova] FOR LOGIN [VTFOMS\LGalishnikova]
GO
