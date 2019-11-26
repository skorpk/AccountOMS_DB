IF NOT EXISTS (SELECT * FROM master.dbo.syslogins WHERE loginname = N'VTFOMS\LParovatkina')
CREATE LOGIN [VTFOMS\LParovatkina] FROM WINDOWS
GO
CREATE USER [VTFOMS\LParovatkina] FOR LOGIN [VTFOMS\LParovatkina]
GO
