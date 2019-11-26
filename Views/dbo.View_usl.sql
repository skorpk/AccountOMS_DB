SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE VIEW dbo.View_usl
AS
SELECT     dbo.t_RegistersAccounts.ReportYear, dbo.t_Meduslugi.MUGroupCode, dbo.t_Meduslugi.MUUnGroupCode, dbo.t_Meduslugi.MUCode, 
                      dbo.t_Meduslugi.Quantity, dbo.t_Meduslugi.Price, dbo.t_File.DateRegistration, dbo.t_Case.rf_idMO, dbo.t_RegistersAccounts.ReportMonth
FROM         dbo.t_Case INNER JOIN
                      dbo.t_RecordCasePatient ON dbo.t_Case.rf_idRecordCasePatient = dbo.t_RecordCasePatient.id INNER JOIN
                      dbo.t_RegistersAccounts ON dbo.t_RecordCasePatient.rf_idRegistersAccounts = dbo.t_RegistersAccounts.id INNER JOIN
                      dbo.t_Meduslugi ON dbo.t_Case.id = dbo.t_Meduslugi.rf_idCase INNER JOIN
                      dbo.t_File ON dbo.t_RegistersAccounts.rf_idFiles = dbo.t_File.id
WHERE     (dbo.t_RegistersAccounts.ReportYear = 2012) AND (dbo.t_RegistersAccounts.ReportMonth = 1 OR
                      dbo.t_RegistersAccounts.ReportMonth = 2 OR
                      dbo.t_RegistersAccounts.ReportMonth = 3) AND (dbo.t_Meduslugi.MUGroupCode = 2 OR
                      dbo.t_Meduslugi.MUGroupCode = 57) AND (dbo.t_File.DateRegistration BETWEEN CONVERT(DATETIME, '2012-04-20 00:00:00', 102) AND 
                      CONVERT(DATETIME, '2012-05-20 00:00:00', 102)) OR
                      (dbo.t_RegistersAccounts.ReportYear = 2012) AND (dbo.t_RegistersAccounts.ReportMonth = 3) AND (dbo.t_Meduslugi.MUGroupCode = 2) AND 
                      (dbo.t_File.DateRegistration BETWEEN CONVERT(DATETIME, '2012-03-01 00:00:00', 102) AND CONVERT(DATETIME, '2012-04-20 00:00:00', 102)) AND 
                      (dbo.t_Meduslugi.MUUnGroupCode = 76) AND (dbo.t_Meduslugi.MUCode = 5) OR
                      (dbo.t_RegistersAccounts.ReportYear = 2012) AND (dbo.t_RegistersAccounts.ReportMonth = 4) AND (dbo.t_Meduslugi.MUGroupCode = 2 OR
                      dbo.t_Meduslugi.MUGroupCode = 57) AND (dbo.t_File.DateRegistration BETWEEN CONVERT(DATETIME, '2012-04-01 00:00:00', 102) AND 
                      CONVERT(DATETIME, '2012-05-20 00:00:00', 102))
GO
GRANT SELECT ON  [dbo].[View_usl] TO [db_AccountOMS]
GO
EXEC sp_addextendedproperty N'MS_DiagramPane1', N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[19] 4[43] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = -31
      End
      Begin Tables = 
         Begin Table = "t_Case"
            Begin Extent = 
               Top = 27
               Left = 556
               Bottom = 135
               Right = 750
            End
            DisplayFlags = 280
            TopColumn = 9
         End
         Begin Table = "t_RecordCasePatient"
            Begin Extent = 
               Top = 0
               Left = 330
               Bottom = 108
               Right = 521
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "t_RegistersAccounts"
            Begin Extent = 
               Top = 121
               Left = 180
               Bottom = 229
               Right = 379
            End
            DisplayFlags = 280
            TopColumn = 3
         End
         Begin Table = "t_Meduslugi"
            Begin Extent = 
               Top = 45
               Left = 820
               Bottom = 153
               Right = 995
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "t_File"
            Begin Extent = 
               Top = 0
               Left = 45
               Bottom = 108
               Right = 206
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 10
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
   ', 'SCHEMA', N'dbo', 'VIEW', N'View_usl', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_DiagramPane2', N'      Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 3180
         Or = 3180
         Or = 1350
         Or = 1350
      End
   End
End
', 'SCHEMA', N'dbo', 'VIEW', N'View_usl', NULL, NULL
GO
DECLARE @xp int
SELECT @xp=2
EXEC sp_addextendedproperty N'MS_DiagramPaneCount', @xp, 'SCHEMA', N'dbo', 'VIEW', N'View_usl', NULL, NULL
GO
