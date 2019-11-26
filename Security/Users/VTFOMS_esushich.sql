IF NOT EXISTS (SELECT * FROM master.dbo.syslogins WHERE loginname = N'VTFOMS\esushich')
CREATE LOGIN [VTFOMS\esushich] FROM WINDOWS
GO
CREATE USER [VTFOMS\esushich] FOR LOGIN [VTFOMS\esushich]
GO
