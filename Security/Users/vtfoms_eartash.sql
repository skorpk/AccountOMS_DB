IF NOT EXISTS (SELECT * FROM master.dbo.syslogins WHERE loginname = N'vtfoms\eartash')
CREATE LOGIN [vtfoms\eartash] FROM WINDOWS
GO
CREATE USER [vtfoms\eartash] FOR LOGIN [vtfoms\eartash]
GO
