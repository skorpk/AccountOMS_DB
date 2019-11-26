IF NOT EXISTS (SELECT * FROM master.dbo.syslogins WHERE loginname = N'VTFOMS\IPonomareva')
CREATE LOGIN [VTFOMS\IPonomareva] FROM WINDOWS
GO
CREATE USER [VTFOMS\IPonomareva] FOR LOGIN [VTFOMS\IPonomareva]
GO
