IF NOT EXISTS (SELECT * FROM master.dbo.syslogins WHERE loginname = N'vtfoms\vzarya')
CREATE LOGIN [vtfoms\vzarya] FROM WINDOWS
GO
CREATE USER [VTFOMS\VZarya] FOR LOGIN [vtfoms\vzarya]
GO
