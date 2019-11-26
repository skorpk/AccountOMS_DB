IF NOT EXISTS (SELECT * FROM master.dbo.syslogins WHERE loginname = N'VTFOMS\ISkryabina')
CREATE LOGIN [VTFOMS\ISkryabina] FROM WINDOWS
GO
CREATE USER [vtfoms\iskryabina] FOR LOGIN [VTFOMS\ISkryabina]
GO
