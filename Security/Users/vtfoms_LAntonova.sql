IF NOT EXISTS (SELECT * FROM master.dbo.syslogins WHERE loginname = N'VTFOMS\LAntonova')
CREATE LOGIN [VTFOMS\LAntonova] FROM WINDOWS
GO
CREATE USER [vtfoms\LAntonova] FOR LOGIN [VTFOMS\LAntonova]
GO
GRANT CONNECT REPLICATION TO [vtfoms\LAntonova]
