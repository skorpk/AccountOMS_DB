IF NOT EXISTS (SELECT * FROM master.dbo.syslogins WHERE loginname = N'vtfoms\sysdba')
CREATE LOGIN [vtfoms\sysdba] FROM WINDOWS
GO
CREATE USER [vtfoms\sysdba] FOR LOGIN [vtfoms\sysdba] WITH DEFAULT_SCHEMA=[vtfoms\sysdba]
GO
REVOKE CONNECT TO [vtfoms\sysdba]
