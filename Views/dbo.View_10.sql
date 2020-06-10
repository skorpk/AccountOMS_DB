SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE VIEW [dbo].[View_10]
AS
SELECT  dbo.t_RecordCasePatient.id AS Expr1, SUM(dbo.t_Case.AmountPayment) AS Expr2, dbo.t_Meduslugi.MUGroupCode
FROM     dbo.t_Case INNER JOIN
               dbo.t_RecordCasePatient ON dbo.t_Case.rf_idRecordCasePatient = dbo.t_RecordCasePatient.id INNER JOIN
               dbo.t_RegistersAccounts ON dbo.t_RecordCasePatient.rf_idRegistersAccounts = dbo.t_RegistersAccounts.id INNER JOIN
               dbo.t_File ON dbo.t_RegistersAccounts.rf_idFiles = dbo.t_File.id INNER JOIN
               dbo.vw_sprT001 ON dbo.t_File.CodeM = dbo.vw_sprT001.CodeM INNER JOIN
               dbo.t_Meduslugi ON dbo.t_Case.id = dbo.t_Meduslugi.rf_idCase
WHERE  (dbo.t_Case.rf_idV006 = 3) AND (dbo.t_RegistersAccounts.rf_idSMO <> '34') AND (dbo.t_RegistersAccounts.ReportMonth IN (3, 4)) AND (dbo.t_RegistersAccounts.ReportYear = 2020) 
               AND (dbo.t_File.DateRegistration BETWEEN CONVERT(DATETIME, '2020-04-09 00:00:00', 102) AND CONVERT(DATETIME, '2020-05-16 00:00:00', 102)) AND (CASE WHEN (pfa = 1 OR
               pfv = 1) THEN 1 ELSE 0 END = 0) AND (dbo.t_Meduslugi.MUGroupCode = 4) AND (dbo.t_Meduslugi.Price > 0)
GROUP BY dbo.t_Meduslugi.MUGroupCode, dbo.t_RecordCasePatient.id
GO
EXEC sp_addextendedproperty N'MS_DiagramPane1', N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[24] 4[36] 2[21] 3) )"
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
         Left = 0
      End
      Begin Tables = 
         Begin Table = "t_Case"
            Begin Extent = 
               Top = 6
               Left = 42
               Bottom = 121
               Right = 271
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "t_RecordCasePatient"
            Begin Extent = 
               Top = 6
               Left = 313
               Bottom = 121
               Right = 535
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "t_RegistersAccounts"
            Begin Extent = 
               Top = 6
               Left = 577
               Bottom = 121
               Right = 809
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "t_File"
            Begin Extent = 
               Top = 6
               Left = 851
               Bottom = 121
               Right = 1041
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "vw_sprT001"
            Begin Extent = 
               Top = 6
               Left = 1083
               Bottom = 121
               Right = 1273
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "t_Meduslugi"
            Begin Extent = 
               Top = 126
               Left = 301
               Bottom = 241
               Right = 507
            End
            DisplayFlags = 280
            TopColumn = 13
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1358
', 'SCHEMA', N'dbo', 'VIEW', N'View_10', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_DiagramPane2', N'         Width = 1358
         Width = 1358
         Width = 1358
         Width = 1358
         Width = 1358
         Width = 1358
         Width = 1358
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 12
         Column = 7947
         Alias = 897
         Table = 1168
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1345
         SortOrder = 1413
         GroupBy = 2051
         Filter = 5774
         Or = 638
         Or = 2785
         Or = 1350
      End
   End
End
', 'SCHEMA', N'dbo', 'VIEW', N'View_10', NULL, NULL
GO
DECLARE @xp int
SELECT @xp=2
EXEC sp_addextendedproperty N'MS_DiagramPaneCount', @xp, 'SCHEMA', N'dbo', 'VIEW', N'View_10', NULL, NULL
GO
