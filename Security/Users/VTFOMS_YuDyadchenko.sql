IF NOT EXISTS (SELECT * FROM master.dbo.syslogins WHERE loginname = N'VTFOMS\YuDyadchenko')
CREATE LOGIN [VTFOMS\YuDyadchenko] FROM WINDOWS
GO
CREATE USER [VTFOMS\YuDyadchenko] FOR LOGIN [VTFOMS\YuDyadchenko]
GO
