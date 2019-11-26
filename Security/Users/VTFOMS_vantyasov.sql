IF NOT EXISTS (SELECT * FROM master.dbo.syslogins WHERE loginname = N'VTFOMS\vantyasov')
CREATE LOGIN [VTFOMS\vantyasov] FROM WINDOWS
GO
CREATE USER [VTFOMS\vantyasov] FOR LOGIN [VTFOMS\vantyasov]
GO
