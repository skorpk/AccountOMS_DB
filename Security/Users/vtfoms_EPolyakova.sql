IF NOT EXISTS (SELECT * FROM master.dbo.syslogins WHERE loginname = N'VTFOMS\EPolyakova')
CREATE LOGIN [VTFOMS\EPolyakova] FROM WINDOWS
GO
CREATE USER [vtfoms\EPolyakova] FOR LOGIN [VTFOMS\EPolyakova]
GO
