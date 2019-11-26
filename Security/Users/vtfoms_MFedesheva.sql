IF NOT EXISTS (SELECT * FROM master.dbo.syslogins WHERE loginname = N'VTFOMS\MFedesheva')
CREATE LOGIN [VTFOMS\MFedesheva] FROM WINDOWS
GO
CREATE USER [vtfoms\MFedesheva] FOR LOGIN [VTFOMS\MFedesheva]
GO
