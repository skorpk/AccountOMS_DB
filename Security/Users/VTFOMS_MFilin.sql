IF NOT EXISTS (SELECT * FROM master.dbo.syslogins WHERE loginname = N'vtfoms\mfilin')
CREATE LOGIN [vtfoms\mfilin] FROM WINDOWS
GO
CREATE USER [VTFOMS\MFilin] FOR LOGIN [vtfoms\mfilin]
GO
