IF NOT EXISTS (SELECT * FROM master.dbo.syslogins WHERE loginname = N'VTFOMS\spavlenko')
CREATE LOGIN [VTFOMS\spavlenko] FROM WINDOWS
GO
CREATE USER [vtfoms\spavlenko] FOR LOGIN [VTFOMS\spavlenko]
GO
