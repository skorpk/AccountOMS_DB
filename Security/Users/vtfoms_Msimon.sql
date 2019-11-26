IF NOT EXISTS (SELECT * FROM master.dbo.syslogins WHERE loginname = N'vtfoms\Msimon')
CREATE LOGIN [vtfoms\Msimon] FROM WINDOWS
GO
CREATE USER [vtfoms\Msimon] FOR LOGIN [vtfoms\Msimon]
GO
