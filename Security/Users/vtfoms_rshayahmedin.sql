IF NOT EXISTS (SELECT * FROM master.dbo.syslogins WHERE loginname = N'vtfoms\shmuhitov')
CREATE LOGIN [vtfoms\shmuhitov] FROM WINDOWS
GO
CREATE USER [vtfoms\rshayahmedin] FOR LOGIN [vtfoms\shmuhitov]
GO
