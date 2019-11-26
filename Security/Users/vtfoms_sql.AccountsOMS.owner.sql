IF NOT EXISTS (SELECT * FROM master.dbo.syslogins WHERE loginname = N'vtfoms\sql.AccountsOMS.owner')
CREATE LOGIN [vtfoms\sql.AccountsOMS.owner] FROM WINDOWS
GO
CREATE USER [vtfoms\sql.AccountsOMS.owner] FOR LOGIN [vtfoms\sql.AccountsOMS.owner]
GO
