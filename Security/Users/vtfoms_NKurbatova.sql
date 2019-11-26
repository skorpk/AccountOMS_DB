IF NOT EXISTS (SELECT * FROM master.dbo.syslogins WHERE loginname = N'vtfoms\NKurbatova')
CREATE LOGIN [vtfoms\NKurbatova] FROM WINDOWS
GO
CREATE USER [vtfoms\NKurbatova] FOR LOGIN [vtfoms\NKurbatova]
GO
