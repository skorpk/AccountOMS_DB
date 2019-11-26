IF NOT EXISTS (SELECT * FROM master.dbo.syslogins WHERE loginname = N'vtfoms\MFedorova')
CREATE LOGIN [vtfoms\MFedorova] FROM WINDOWS
GO
CREATE USER [vtfoms\mfedorova] FOR LOGIN [vtfoms\MFedorova]
GO
