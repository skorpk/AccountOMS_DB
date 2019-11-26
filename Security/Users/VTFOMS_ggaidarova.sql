IF NOT EXISTS (SELECT * FROM master.dbo.syslogins WHERE loginname = N'VTFOMS\ggaidarova')
CREATE LOGIN [VTFOMS\ggaidarova] FROM WINDOWS
GO
CREATE USER [VTFOMS\ggaidarova] FOR LOGIN [VTFOMS\ggaidarova]
GO
