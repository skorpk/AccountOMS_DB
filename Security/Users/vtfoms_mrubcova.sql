IF NOT EXISTS (SELECT * FROM master.dbo.syslogins WHERE loginname = N'VTFOMS\mrubcova')
CREATE LOGIN [VTFOMS\mrubcova] FROM WINDOWS
GO
CREATE USER [vtfoms\mrubcova] FOR LOGIN [VTFOMS\mrubcova]
GO
