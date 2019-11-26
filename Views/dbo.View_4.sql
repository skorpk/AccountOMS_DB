SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE VIEW dbo.View_4
AS
SELECT  dbo.t_Case.id, dbo.t_PatientSMO.ENP, dbo.t_Meduslugi.MUGroupCode, SUM(dbo.t_Meduslugi.Quantity) AS Expr2, dbo.t_Case.AmountPayment - ISNULL(dbo.View_1.Eks, 0) AS Expr1, 
               dbo.t_Meduslugi.MUUnGroupCode
FROM     dbo.t_File INNER JOIN
               dbo.t_RegistersAccounts ON dbo.t_File.id = dbo.t_RegistersAccounts.rf_idFiles INNER JOIN
               dbo.t_RecordCasePatient ON dbo.t_RegistersAccounts.id = dbo.t_RecordCasePatient.rf_idRegistersAccounts INNER JOIN
               dbo.t_Case ON dbo.t_RecordCasePatient.id = dbo.t_Case.rf_idRecordCasePatient INNER JOIN
               dbo.t_Meduslugi ON dbo.t_Case.id = dbo.t_Meduslugi.rf_idCase INNER JOIN
               dbo.t_PatientSMO ON dbo.t_RecordCasePatient.id = dbo.t_PatientSMO.rf_idRecordCasePatient LEFT OUTER JOIN
               dbo.View_1 ON dbo.t_Case.id = dbo.View_1.rf_idCase
WHERE  (dbo.t_File.DateRegistration BETWEEN CONVERT(DATETIME, '2019-01-01 00:00:00', 102) AND CONVERT(DATETIME, '2019-08-02 00:00:00', 102)) AND 
               (dbo.t_RegistersAccounts.ReportYear = 2019) AND (dbo.t_RegistersAccounts.rf_idSMO <> '34') AND (dbo.t_RegistersAccounts.Letter = 'F') AND (dbo.t_Meduslugi.MUGroupCode = 2)
GROUP BY dbo.t_PatientSMO.ENP, dbo.t_Meduslugi.MUGroupCode, dbo.t_Case.AmountPayment - ISNULL(dbo.View_1.Eks, 0), dbo.t_Case.id, dbo.t_Meduslugi.MUUnGroupCode
HAVING  (dbo.t_Case.AmountPayment - ISNULL(dbo.View_1.Eks, 0) > 0) AND (dbo.t_Meduslugi.MUUnGroupCode = 85 OR
               dbo.t_Meduslugi.MUUnGroupCode = 91)
GO
EXEC sp_addextendedproperty N'MS_DiagramPane1', N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[48] 4[4] 2[28] 3) )"
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
         Begin Table = "t_File"
            Begin Extent = 
               Top = 6
               Left = 42
               Bottom = 269
               Right = 216
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "t_RegistersAccounts"
            Begin Extent = 
               Top = 1
               Left = 236
               Bottom = 320
               Right = 452
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "t_RecordCasePatient"
            Begin Extent = 
               Top = 5
               Left = 485
               Bottom = 314
               Right = 691
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "t_Case"
            Begin Extent = 
               Top = 11
               Left = 722
               Bottom = 321
               Right = 935
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "t_Meduslugi"
            Begin Extent = 
               Top = 12
               Left = 1072
               Bottom = 127
               Right = 1236
            End
            DisplayFlags = 280
            TopColumn = 12
         End
         Begin Table = "t_PatientSMO"
            Begin Extent = 
               Top = 162
               Left = 1054
               Bottom = 277
               Right = 1262
            End
            DisplayFlags = 280
            TopColumn = 2
         End
         Begin Table = "View_1"
            Begin Extent = 
               Top = 328
               Left = 1094
               Bottom = 411
               Right = 1268
            En', 'SCHEMA', N'dbo', 'VIEW', N'View_4', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_DiagramPane2', N'd
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
      Begin ColumnWidths = 9
         Width = 284
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
      Begin ColumnWidths = 12
         Column = 5122
         Alias = 897
         Table = 1168
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1345
         SortOrder = 1413
         GroupBy = 1350
         Filter = 1345
         Or = 3369
         Or = 1350
         Or = 1350
      End
   End
End
', 'SCHEMA', N'dbo', 'VIEW', N'View_4', NULL, NULL
GO
DECLARE @xp int
SELECT @xp=2
EXEC sp_addextendedproperty N'MS_DiagramPaneCount', @xp, 'SCHEMA', N'dbo', 'VIEW', N'View_4', NULL, NULL
GO
