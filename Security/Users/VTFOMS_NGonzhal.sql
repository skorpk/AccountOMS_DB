IF NOT EXISTS (SELECT * FROM master.dbo.syslogins WHERE loginname = N'VTFOMS\ngonzhal')
CREATE LOGIN [VTFOMS\ngonzhal] FROM WINDOWS
GO
CREATE USER [VTFOMS\NGonzhal] FOR LOGIN [VTFOMS\ngonzhal]
GO
