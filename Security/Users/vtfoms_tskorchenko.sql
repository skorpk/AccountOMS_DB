IF NOT EXISTS (SELECT * FROM master.dbo.syslogins WHERE loginname = N'VTFOMS\TSkorchenko')
CREATE LOGIN [VTFOMS\TSkorchenko] FROM WINDOWS
GO
CREATE USER [vtfoms\tskorchenko] FOR LOGIN [VTFOMS\TSkorchenko]
GO
