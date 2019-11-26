SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE VIEW dbo.View_Child_U
AS
SELECT     dbo.t_RegistersAccounts.ReportYear, dbo.t_Case.rf_idMO, dbo.t_Case.rf_idV006, dbo.t_Case.id, dbo.t_Case.AmountPayment, 
                      dbo.t_Diagnosis.DiagnosisCode, dbo.t_Case.Age
FROM         dbo.t_RecordCasePatient INNER JOIN
                      dbo.t_RegistersAccounts ON dbo.t_RecordCasePatient.rf_idRegistersAccounts = dbo.t_RegistersAccounts.id INNER JOIN
                      dbo.t_Diagnosis INNER JOIN
                      dbo.t_Case ON dbo.t_Diagnosis.rf_idCase = dbo.t_Case.id ON dbo.t_RecordCasePatient.id = dbo.t_Case.rf_idRecordCasePatient
WHERE     (dbo.t_RegistersAccounts.ReportYear = 2011) AND (dbo.t_Diagnosis.TypeDiagnosis = 1) AND (dbo.t_Diagnosis.DiagnosisCode LIKE 'A02%' OR
                      dbo.t_Diagnosis.DiagnosisCode LIKE 'A03%' OR
                      dbo.t_Diagnosis.DiagnosisCode LIKE 'A04%') AND (dbo.t_Case.Age < 1) OR
                      (dbo.t_RegistersAccounts.ReportYear = 2011) AND (dbo.t_Diagnosis.TypeDiagnosis = 1) AND (dbo.t_Diagnosis.DiagnosisCode LIKE 'J04%' OR
                      dbo.t_Diagnosis.DiagnosisCode LIKE 'J05%' OR
                      dbo.t_Diagnosis.DiagnosisCode LIKE 'J06%' OR
                      dbo.t_Diagnosis.DiagnosisCode LIKE 'J13%' OR
                      dbo.t_Diagnosis.DiagnosisCode LIKE 'J14%' OR
                      dbo.t_Diagnosis.DiagnosisCode LIKE 'J15%' OR
                      dbo.t_Diagnosis.DiagnosisCode LIKE 'J16%' OR
                      dbo.t_Diagnosis.DiagnosisCode LIKE 'J17%' OR
                      dbo.t_Diagnosis.DiagnosisCode LIKE '45%' OR
                      dbo.t_Diagnosis.DiagnosisCode LIKE 'H%') AND (dbo.t_Case.Age < 1)
GO
GRANT SELECT ON  [dbo].[View_Child_U] TO [db_AccountOMS]
GO
EXEC sp_addextendedproperty N'MS_DiagramPane1', N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[41] 4[35] 2[6] 3) )"
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
         Begin Table = "t_RecordCasePatient"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 114
               Right = 229
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "t_RegistersAccounts"
            Begin Extent = 
               Top = 6
               Left = 267
               Bottom = 114
               Right = 466
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "t_Diagnosis"
            Begin Extent = 
               Top = 6
               Left = 504
               Bottom = 99
               Right = 655
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "t_Case"
            Begin Extent = 
               Top = 6
               Left = 693
               Bottom = 114
               Right = 887
            End
            DisplayFlags = 280
            TopColumn = 23
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
         Or = 11235
         Or = 1350
         ', 'SCHEMA', N'dbo', 'VIEW', N'View_Child_U', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_DiagramPane2', N'Or = 1350
      End
   End
End
', 'SCHEMA', N'dbo', 'VIEW', N'View_Child_U', NULL, NULL
GO
DECLARE @xp int
SELECT @xp=2
EXEC sp_addextendedproperty N'MS_DiagramPaneCount', @xp, 'SCHEMA', N'dbo', 'VIEW', N'View_Child_U', NULL, NULL
GO
