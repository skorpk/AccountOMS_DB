IF NOT EXISTS (SELECT * FROM master.dbo.syslogins WHERE loginname = N'VTFOMS\LKoshik')
CREATE LOGIN [VTFOMS\LKoshik] FROM WINDOWS
GO
CREATE USER [vtfoms\lkoshik] FOR LOGIN [VTFOMS\LKoshik]
GO
