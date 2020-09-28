IF NOT EXISTS (SELECT * FROM master.dbo.syslogins WHERE loginname = N'VTFOMS\omishina')
CREATE LOGIN [VTFOMS\omishina] FROM WINDOWS
GO
CREATE USER [VTFOMS\omishina] FOR LOGIN [VTFOMS\omishina]
GO
