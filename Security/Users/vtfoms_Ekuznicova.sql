IF NOT EXISTS (SELECT * FROM master.dbo.syslogins WHERE loginname = N'vtfoms\Ekuznicova')
CREATE LOGIN [vtfoms\Ekuznicova] FROM WINDOWS
GO
CREATE USER [vtfoms\Ekuznicova] FOR LOGIN [vtfoms\Ekuznicova]
GO
