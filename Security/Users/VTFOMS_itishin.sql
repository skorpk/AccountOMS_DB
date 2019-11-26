IF NOT EXISTS (SELECT * FROM master.dbo.syslogins WHERE loginname = N'VTFOMS\itishin')
CREATE LOGIN [VTFOMS\itishin] FROM WINDOWS
GO
CREATE USER [VTFOMS\itishin] FOR LOGIN [VTFOMS\itishin]
GO
