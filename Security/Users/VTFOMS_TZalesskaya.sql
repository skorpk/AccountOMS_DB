IF NOT EXISTS (SELECT * FROM master.dbo.syslogins WHERE loginname = N'VTFOMS\TZalesskaya')
CREATE LOGIN [VTFOMS\TZalesskaya] FROM WINDOWS
GO
CREATE USER [VTFOMS\TZalesskaya] FOR LOGIN [VTFOMS\TZalesskaya]
GO
