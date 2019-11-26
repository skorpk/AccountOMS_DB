SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE VIEW dbo.View_EKSNEW
AS
SELECT  SUM(ISNULL(dbo.t_PaymentAcceptedCase2.AmountMEK, 0) + ISNULL(dbo.t_PaymentAcceptedCase2.AmountMEE, 0) + ISNULL(dbo.t_PaymentAcceptedCase2.AmountEKMP, 0)) AS Eks, 
               dbo.t_Case.id
FROM     dbo.t_PaymentAcceptedCase2 RIGHT OUTER JOIN
               dbo.t_Case ON dbo.t_PaymentAcceptedCase2.rf_idCase = dbo.t_Case.id
WHERE  (dbo.t_PaymentAcceptedCase2.DateRegistration BETWEEN CONVERT(DATETIME, '2018-06-01 00:00:00', 102) AND CONVERT(DATETIME, '2018-07-11 00:00:00', 102)) AND 
               (dbo.t_Case.DateEnd BETWEEN CONVERT(DATETIME, '2018-06-01 00:00:00', 102) AND CONVERT(DATETIME, '2018-06-30 00:00:00', 102))
GROUP BY dbo.t_Case.id, dbo.t_Case.AmountPayment
GO
EXEC sp_addextendedproperty N'MS_DiagramPane1', N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[34] 4[27] 2[20] 3) )"
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
         Begin Table = "t_PaymentAcceptedCase2"
            Begin Extent = 
               Top = 14
               Left = 119
               Bottom = 222
               Right = 287
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "t_Case"
            Begin Extent = 
               Top = 21
               Left = 391
               Bottom = 213
               Right = 603
            End
            DisplayFlags = 280
            TopColumn = 14
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
         Width = 1494
         Width = 1494
         Width = 1494
         Width = 1494
         Width = 1494
         Width = 1494
         Width = 1494
         Width = 1494
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 12
         Column = 3342
         Alias = 3369
         Table = 1168
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1345
         SortOrder = 1413
         GroupBy = 1350
         Filter = 3369
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
', 'SCHEMA', N'dbo', 'VIEW', N'View_EKSNEW', NULL, NULL
GO
DECLARE @xp int
SELECT @xp=1
EXEC sp_addextendedproperty N'MS_DiagramPaneCount', @xp, 'SCHEMA', N'dbo', 'VIEW', N'View_EKSNEW', NULL, NULL
GO
