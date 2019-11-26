SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE VIEW dbo.vw_LA146_2
AS
SELECT     l.filialName, l.CodeM, l.NameS, s.smocod, s.sNameS, t_1.[Вид МП], t_1.UE, SUM(t_1.Quantity) AS Q, SUM(t_1.Price) AS P, SUM(t_1.tariff) AS T, 
                      COUNT(t_1.IDMin) AS C, SUM(t_1.AmountPayment) AS Stoim
FROM         (SELECT     rf_idMO, rf_idSMO, [Вид МП], MIN(id) AS IDMin, Fam, Im, Ot, BirthDay, NewBorn, F_s, I_s, O_s, DR_s, SUM(Количество) AS Quantity, 
                                              SUM(Стоимость) AS Price, SUM(AmountPayment) AS AmountPayment, SUM(Tariff) AS tariff, UE
                       FROM          dbo.vw_146Second AS t
                       GROUP BY rf_idMO, rf_idSMO, [Вид МП], Fam, Im, Ot, BirthDay, NewBorn, F_s, I_s, O_s, DR_s, UE) AS t_1 INNER JOIN
                      OMS_NSI.dbo.vw_sprT001_A AS l ON t_1.rf_idMO = l.CodeM INNER JOIN
                          (SELECT     smocod, sNameS
                            FROM          OMS_NSI.dbo.tSMO
                            UNION ALL
                            SELECT     '34' AS Expr1, 'Иногородние' AS Expr2) AS s ON t_1.rf_idSMO = s.smocod
GROUP BY l.filialName, l.CodeM, l.NameS, s.smocod, s.sNameS, t_1.[Вид МП], t_1.UE
GO
GRANT SELECT ON  [dbo].[vw_LA146_2] TO [db_AccountOMS]
GO
EXEC sp_addextendedproperty N'MS_DiagramPane1', N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[32] 4[28] 2[21] 3) )"
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
         Begin Table = "t_1"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 114
               Right = 215
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "l"
            Begin Extent = 
               Top = 0
               Left = 400
               Bottom = 108
               Right = 567
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "s"
            Begin Extent = 
               Top = 114
               Left = 38
               Bottom = 262
               Right = 205
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
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 12
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
', 'SCHEMA', N'dbo', 'VIEW', N'vw_LA146_2', NULL, NULL
GO
DECLARE @xp int
SELECT @xp=1
EXEC sp_addextendedproperty N'MS_DiagramPaneCount', @xp, 'SCHEMA', N'dbo', 'VIEW', N'vw_LA146_2', NULL, NULL
GO
