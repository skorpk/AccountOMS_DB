IF NOT EXISTS (SELECT * FROM master.dbo.syslogins WHERE loginname = N'VTFOMS\EKolcheva')
CREATE LOGIN [VTFOMS\EKolcheva] FROM WINDOWS
GO
CREATE USER [vtfoms\ekolcheva] FOR LOGIN [VTFOMS\EKolcheva]
GO
