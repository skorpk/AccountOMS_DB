IF NOT EXISTS (SELECT * FROM master.dbo.syslogins WHERE loginname = N'VTFOMS\TLoginova')
CREATE LOGIN [VTFOMS\TLoginova] FROM WINDOWS
GO
CREATE USER [vtfoms\TLoginova] FOR LOGIN [VTFOMS\TLoginova]
GO
