IF NOT EXISTS (SELECT * FROM master.dbo.syslogins WHERE loginname = N'VTFOMS\ERomanchuk')
CREATE LOGIN [VTFOMS\ERomanchuk] FROM WINDOWS
GO
CREATE USER [VTFOMS\ERomanchuk] FOR LOGIN [VTFOMS\ERomanchuk]
GO
