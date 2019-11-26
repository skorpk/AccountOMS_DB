IF NOT EXISTS (SELECT * FROM master.dbo.syslogins WHERE loginname = N'VTFOMS\APeskovatskova')
CREATE LOGIN [VTFOMS\APeskovatskova] FROM WINDOWS
GO
CREATE USER [VTFOMS\APeskovatskova] FOR LOGIN [VTFOMS\APeskovatskova]
GO
