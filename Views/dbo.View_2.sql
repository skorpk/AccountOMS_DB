SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE VIEW dbo.View_2
AS
SELECT  dbo.View_1.Expr1 AS Expr4, dbo.View_Rentg_LN.id, dbo.View_Rentg_LN.ENP, dbo.View_Rentg_LN.NumberPolis, dbo.View_Rentg_LN.DateRegister, dbo.View_Rentg_LN.Account, 
               dbo.View_Rentg_LN.idRecord, dbo.View_Rentg_LN.AmountPayment, dbo.View_Rentg_LN.MU, dbo.View_Rentg_LN.rf_idMO, dbo.View_Rentg_LN.Quantity, 
               dbo.View_Rentg_LN.rf_idDirectMO, dbo.View_Rentg_LN.rf_idSMO, dbo.View_Rentg_LN.ReportYear, dbo.View_Rentg_LN.ReportMonth, dbo.vw_sprMU.MUName, 
               oms_nsi.dbo.View_5.tfomsCode, oms_nsi.dbo.View_5.mNameS
FROM     dbo.vw_sprMU INNER JOIN
               dbo.View_Rentg_LN ON dbo.vw_sprMU.MU = dbo.View_Rentg_LN.MU INNER JOIN
               oms_nsi.dbo.View_5 ON dbo.View_Rentg_LN.rf_idDirectMO = oms_nsi.dbo.View_5.mcod LEFT OUTER JOIN
               dbo.View_1 ON dbo.View_Rentg_LN.id = dbo.View_1.rf_idCase
GO
EXEC sp_addextendedproperty N'MS_DiagramPane1', N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[26] 4[12] 2[26] 3) )"
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
         Left = -1488
      End
      Begin Tables = 
         Begin Table = "View_1"
            Begin Extent = 
               Top = 6
               Left = 42
               Bottom = 280
               Right = 224
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "View_Rentg_LN"
            Begin Extent = 
               Top = 6
               Left = 266
               Bottom = 328
               Right = 441
            End
            DisplayFlags = 280
            TopColumn = 2
         End
         Begin Table = "vw_sprMU"
            Begin Extent = 
               Top = 56
               Left = 623
               Bottom = 171
               Right = 798
            End
            DisplayFlags = 280
            TopColumn = 5
         End
         Begin Table = "View_5 (oms_nsi.dbo)"
            Begin Extent = 
               Top = 154
               Left = 932
               Bottom = 269
               Right = 1106
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
      Begin ColumnWidths = 17
         Width = 284
         Width = 1358
         Width = 1358
         Width = 1358
         Width = 1358
         Width = 1358
         Width = 1358
         Width = 1358
         Width = 1358
         Width = 1358
         Width = 1358
         Width = 1358
         Width = 1358
         Width = 1358
         Width = 1358
         Width = 1358
         Width = 1358
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 897
         Table = 1168
         Output = 720
         Append ', 'SCHEMA', N'dbo', 'VIEW', N'View_2', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_DiagramPane2', N'= 1400
         NewValue = 1170
         SortType = 1345
         SortOrder = 1413
         GroupBy = 1350
         Filter = 1345
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
', 'SCHEMA', N'dbo', 'VIEW', N'View_2', NULL, NULL
GO
DECLARE @xp int
SELECT @xp=2
EXEC sp_addextendedproperty N'MS_DiagramPaneCount', @xp, 'SCHEMA', N'dbo', 'VIEW', N'View_2', NULL, NULL
GO
