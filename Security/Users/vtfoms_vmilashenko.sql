IF NOT EXISTS (SELECT * FROM master.dbo.syslogins WHERE loginname = N'vtfoms\vmilashenko')
CREATE LOGIN [vtfoms\vmilashenko] FROM WINDOWS
GO
CREATE USER [vtfoms\vmilashenko] FOR LOGIN [vtfoms\vmilashenko]
GO
