IF NOT EXISTS (SELECT * FROM master.dbo.syslogins WHERE loginname = N'VTFOMS\WSSAdmin')
CREATE LOGIN [VTFOMS\WSSAdmin] FROM WINDOWS
GO
CREATE USER [VTFOMS\WSSAdmin] FOR LOGIN [VTFOMS\WSSAdmin]
GO
