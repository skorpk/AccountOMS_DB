IF NOT EXISTS (SELECT * FROM master.dbo.syslogins WHERE loginname = N'vtfoms\NShankina')
CREATE LOGIN [vtfoms\NShankina] FROM WINDOWS
GO
CREATE USER [vtfoms\NShankina] FOR LOGIN [vtfoms\NShankina]
GO
