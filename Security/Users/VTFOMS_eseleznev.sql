IF NOT EXISTS (SELECT * FROM master.dbo.syslogins WHERE loginname = N'VTFOMS\eseleznev')
CREATE LOGIN [VTFOMS\eseleznev] FROM WINDOWS
GO
CREATE USER [VTFOMS\eseleznev] FOR LOGIN [VTFOMS\eseleznev]
GO
