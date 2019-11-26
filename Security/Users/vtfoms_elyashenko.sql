IF NOT EXISTS (SELECT * FROM master.dbo.syslogins WHERE loginname = N'vtfoms\elyashenko')
CREATE LOGIN [vtfoms\elyashenko] FROM WINDOWS
GO
CREATE USER [vtfoms\elyashenko] FOR LOGIN [vtfoms\elyashenko]
GO
