IF NOT EXISTS (SELECT * FROM master.dbo.syslogins WHERE loginname = N'vtfoms\ebabenko')
CREATE LOGIN [vtfoms\ebabenko] FROM WINDOWS
GO
CREATE USER [vtfoms\ebabenko] FOR LOGIN [vtfoms\ebabenko]
GO
