IF NOT EXISTS (SELECT * FROM master.dbo.syslogins WHERE loginname = N'VTFOMS\smagalyas')
CREATE LOGIN [VTFOMS\smagalyas] FROM WINDOWS
GO
CREATE USER [VTFOMS\smagalyas] FOR LOGIN [VTFOMS\smagalyas]
GO
