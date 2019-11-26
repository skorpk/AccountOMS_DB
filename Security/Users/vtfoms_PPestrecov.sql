IF NOT EXISTS (SELECT * FROM master.dbo.syslogins WHERE loginname = N'vtfoms\PPestrecov')
CREATE LOGIN [vtfoms\PPestrecov] FROM WINDOWS
GO
CREATE USER [vtfoms\PPestrecov] FOR LOGIN [vtfoms\PPestrecov]
GO
