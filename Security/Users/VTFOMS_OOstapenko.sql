IF NOT EXISTS (SELECT * FROM master.dbo.syslogins WHERE loginname = N'VTFOMS\OOstapenko')
CREATE LOGIN [VTFOMS\OOstapenko] FROM WINDOWS
GO
CREATE USER [VTFOMS\OOstapenko] FOR LOGIN [VTFOMS\OOstapenko]
GO
