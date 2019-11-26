SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE VIEW dbo.View_VA
AS
SELECT     dbo.t_RegistersAccounts.ReportYear, dbo.t_Case.id, SUM(dbo.t_Meduslugi.Quantity) AS Kol, dbo.t_Diagnosis.DiagnosisCode
FROM         dbo.t_Meduslugi INNER JOIN
                      dbo.t_Case ON dbo.t_Meduslugi.rf_idCase = dbo.t_Case.id INNER JOIN
                      dbo.t_RegistersAccounts INNER JOIN
                      dbo.t_File ON dbo.t_RegistersAccounts.rf_idFiles = dbo.t_File.id INNER JOIN
                      dbo.t_RecordCasePatient ON dbo.t_RegistersAccounts.id = dbo.t_RecordCasePatient.rf_idRegistersAccounts ON 
                      dbo.t_Case.rf_idRecordCasePatient = dbo.t_RecordCasePatient.id INNER JOIN
                      dbo.t_Diagnosis ON dbo.t_Case.id = dbo.t_Diagnosis.rf_idCase
WHERE     (dbo.t_File.DateRegistration BETWEEN CONVERT(DATETIME, '2011-12-01 00:00:00', 102) AND CONVERT(DATETIME, '2012-02-17 00:00:00', 102)) AND 
                      (dbo.t_RegistersAccounts.ReportYear = 2011) AND (dbo.t_Case.Age < 3) AND (dbo.t_Meduslugi.MUGroupCode = 2) AND 
                      (dbo.t_Diagnosis.TypeDiagnosis = 1) AND (dbo.t_RegistersAccounts.rf_idMO <> '34') OR
                      (dbo.t_File.DateRegistration BETWEEN CONVERT(DATETIME, '2012-01-01 00:00:00', 102) AND CONVERT(DATETIME, '2012-10-17 00:00:00', 102)) AND 
                      (dbo.t_RegistersAccounts.ReportYear = 2012) AND (dbo.t_Case.Age < 3) AND (dbo.t_Meduslugi.MUGroupCode = 2) AND 
                      (dbo.t_Diagnosis.TypeDiagnosis = 1) AND (dbo.t_RegistersAccounts.rf_idMO <> '34')
GROUP BY dbo.t_RegistersAccounts.ReportYear, dbo.t_Case.id, dbo.t_Diagnosis.DiagnosisCode
GO
GRANT SELECT ON  [dbo].[View_VA] TO [db_AccountOMS]
GO
EXEC sp_addextendedproperty N'MS_DiagramPane1', N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[30] 4[22] 2[30] 3) )"
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
         Begin Table = "t_Meduslugi"
            Begin Extent = 
               Top = 69
               Left = 879
               Bottom = 177
               Right = 1054
            End
            DisplayFlags = 280
            TopColumn = 12
         End
         Begin Table = "t_Case"
            Begin Extent = 
               Top = 23
               Left = 652
               Bottom = 131
               Right = 846
            End
            DisplayFlags = 280
            TopColumn = 23
         End
         Begin Table = "t_RegistersAccounts"
            Begin Extent = 
               Top = 36
               Left = 195
               Bottom = 144
               Right = 394
            End
            DisplayFlags = 280
            TopColumn = 2
         End
         Begin Table = "t_File"
            Begin Extent = 
               Top = 34
               Left = 11
               Bottom = 142
               Right = 172
            End
            DisplayFlags = 280
            TopColumn = 6
         End
         Begin Table = "t_RecordCasePatient"
            Begin Extent = 
               Top = 15
               Left = 430
               Bottom = 123
               Right = 621
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "t_Diagnosis"
            Begin Extent = 
               Top = 226
               Left = 456
               Bottom = 319
               Right = 607
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
      Begin ColumnWidths = 9
         Width = 284
         Width = 1', 'SCHEMA', N'dbo', 'VIEW', N'View_VA', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_DiagramPane2', N'500
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
         Filter = 975
         Or = 1335
         Or = 1350
         Or = 1350
      End
   End
End
', 'SCHEMA', N'dbo', 'VIEW', N'View_VA', NULL, NULL
GO
DECLARE @xp int
SELECT @xp=2
EXEC sp_addextendedproperty N'MS_DiagramPaneCount', @xp, 'SCHEMA', N'dbo', 'VIEW', N'View_VA', NULL, NULL
GO
