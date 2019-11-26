IF NOT EXISTS (SELECT * FROM master.dbo.syslogins WHERE loginname = N'vtfoms\eagafonova')
CREATE LOGIN [vtfoms\eagafonova] FROM WINDOWS
GO
CREATE USER [VTFOMS\EAgafonova] FOR LOGIN [vtfoms\eagafonova]
GO
