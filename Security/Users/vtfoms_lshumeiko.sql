IF NOT EXISTS (SELECT * FROM master.dbo.syslogins WHERE loginname = N'VTFOMS\LShumeiko')
CREATE LOGIN [VTFOMS\LShumeiko] FROM WINDOWS
GO
CREATE USER [vtfoms\lshumeiko] FOR LOGIN [VTFOMS\LShumeiko]
GO
