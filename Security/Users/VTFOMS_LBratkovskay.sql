IF NOT EXISTS (SELECT * FROM master.dbo.syslogins WHERE loginname = N'VTFOMS\LBratkovskay')
CREATE LOGIN [VTFOMS\LBratkovskay] FROM WINDOWS
GO
CREATE USER [VTFOMS\LBratkovskay] FOR LOGIN [VTFOMS\LBratkovskay]
GO
