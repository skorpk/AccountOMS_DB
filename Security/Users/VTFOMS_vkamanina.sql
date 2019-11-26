IF NOT EXISTS (SELECT * FROM master.dbo.syslogins WHERE loginname = N'VTFOMS\vkamanina')
CREATE LOGIN [VTFOMS\vkamanina] FROM WINDOWS
GO
CREATE USER [VTFOMS\vkamanina] FOR LOGIN [VTFOMS\vkamanina]
GO
