SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE VIEW dbo.vw_146Second
AS
SELECT     a.rf_idMO, a.rf_idSMO, t .name AS [Вид МП], a.id, a.Fam, a.Im, a.Ot, a.BirthDay, a.NewBorn, a.F_s, a.I_s, a.O_s, a.DR_s, 
                      SUM(CASE WHEN Age < 18 THEN ChildUET * Quantity ELSE AdultUET * Quantity END) AS [Количество], Sum(a.Quantity * a.Price) AS Стоимость, 
                      a.AmountPayment, a.Tariff, a.UE
FROM         t_146 a INNER JOIN
                      (VALUES (1, 'Первичная медико-санитарная'), (11, 'Первичная медико-санитарная'), (12, 'Первичная медико-санитарная'), (3, 
                      'Специализированная, в том числе высокотехнологичная'), (31, 'Специализированная, в том числе высокотехнологичная'), (32, 
                      'Специализированная, в том числе высокотехнологичная'), (13, 'Специализированная, в том числе высокотехнологичная'), (2, 
                      'Скорая, в том числе специализированная (санитарно-авиационная), медицинская помощь')) t (id, name) ON a.VMP_K = t .id
GROUP BY a.rf_idMO, a.rf_idSMO, t .name, a.id, a.Fam, a.Im, a.Ot, a.BirthDay, a.NewBorn, a.F_s, a.I_s, a.O_s, a.DR_s, a.AmountPayment, a.Tariff, a.UE
GO
GRANT SELECT ON  [dbo].[vw_146Second] TO [db_AccountOMS]
GO
EXEC sp_addextendedproperty N'MS_DiagramPane1', N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[42] 4[12] 2[37] 3) )"
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
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
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
', 'SCHEMA', N'dbo', 'VIEW', N'vw_146Second', NULL, NULL
GO
DECLARE @xp int
SELECT @xp=1
EXEC sp_addextendedproperty N'MS_DiagramPaneCount', @xp, 'SCHEMA', N'dbo', 'VIEW', N'vw_146Second', NULL, NULL
GO
