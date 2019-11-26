IF NOT EXISTS (SELECT * FROM master.dbo.syslogins WHERE loginname = N'VTFOMS\OTyudina')
CREATE LOGIN [VTFOMS\OTyudina] FROM WINDOWS
GO
CREATE USER [vtfoms\otyudina] FOR LOGIN [VTFOMS\OTyudina]
GO
