IF NOT EXISTS (SELECT * FROM master.dbo.syslogins WHERE loginname = N'VTFOMS\etelesheva')
CREATE LOGIN [VTFOMS\etelesheva] FROM WINDOWS
GO
CREATE USER [VTFOMS\etelesheva] FOR LOGIN [VTFOMS\etelesheva]
GO
