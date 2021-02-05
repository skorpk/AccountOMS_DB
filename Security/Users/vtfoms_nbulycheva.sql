IF NOT EXISTS (SELECT * FROM master.dbo.syslogins WHERE loginname = N'vtfoms\nbulycheva')
CREATE LOGIN [vtfoms\nbulycheva] FROM WINDOWS
GO
CREATE USER [vtfoms\nbulycheva] FOR LOGIN [vtfoms\nbulycheva]
GO
