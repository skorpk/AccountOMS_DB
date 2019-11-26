IF NOT EXISTS (SELECT * FROM master.dbo.syslogins WHERE loginname = N'MED\ELoktionova')
CREATE LOGIN [MED\ELoktionova] FROM WINDOWS
GO
CREATE USER [MED\ELoktionova] FOR LOGIN [MED\ELoktionova]
GO
