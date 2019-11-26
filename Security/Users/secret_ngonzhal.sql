IF NOT EXISTS (SELECT * FROM master.dbo.syslogins WHERE loginname = N'secret\ngonzhal')
CREATE LOGIN [secret\ngonzhal] FROM WINDOWS
GO
CREATE USER [secret\ngonzhal] FOR LOGIN [secret\ngonzhal]
GO
