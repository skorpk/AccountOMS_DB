IF NOT EXISTS (SELECT * FROM master.dbo.syslogins WHERE loginname = N'VTFOMS\oabramova')
CREATE LOGIN [VTFOMS\oabramova] FROM WINDOWS
GO
CREATE USER [VTFOMS\oabramova] FOR LOGIN [VTFOMS\oabramova]
GO
