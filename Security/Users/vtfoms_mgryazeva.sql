IF NOT EXISTS (SELECT * FROM master.dbo.syslogins WHERE loginname = N'vtfoms\mgryazeva')
CREATE LOGIN [vtfoms\mgryazeva] FROM WINDOWS
GO
CREATE USER [vtfoms\mgryazeva] FOR LOGIN [vtfoms\mgryazeva]
GO
