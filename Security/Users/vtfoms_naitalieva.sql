IF NOT EXISTS (SELECT * FROM master.dbo.syslogins WHERE loginname = N'VTFOMS\NAitalieva')
CREATE LOGIN [VTFOMS\NAitalieva] FROM WINDOWS
GO
CREATE USER [vtfoms\naitalieva] FOR LOGIN [VTFOMS\NAitalieva]
GO
