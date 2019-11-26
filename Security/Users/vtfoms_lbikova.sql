IF NOT EXISTS (SELECT * FROM master.dbo.syslogins WHERE loginname = N'vtfoms\lbikova')
CREATE LOGIN [vtfoms\lbikova] FROM WINDOWS
GO
CREATE USER [vtfoms\lbikova] FOR LOGIN [vtfoms\lbikova]
GO
