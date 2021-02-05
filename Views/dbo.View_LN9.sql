SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE VIEW [dbo].[View_LN9]
AS
SELECT  dbo.t_CompletedCase.id, dbo.t_CompletedCase.AmountPayment
FROM     dbo.t_RegistersAccounts INNER JOIN
               dbo.t_File ON dbo.t_RegistersAccounts.rf_idFiles = dbo.t_File.id INNER JOIN
               dbo.t_Case INNER JOIN
               dbo.t_Diagnosis ON dbo.t_Case.id = dbo.t_Diagnosis.rf_idCase INNER JOIN
               dbo.t_RecordCasePatient ON dbo.t_Case.rf_idRecordCasePatient = dbo.t_RecordCasePatient.id ON 
               dbo.t_RegistersAccounts.id = dbo.t_RecordCasePatient.rf_idRegistersAccounts INNER JOIN
               dbo.t_CompletedCase ON dbo.t_RecordCasePatient.id = dbo.t_CompletedCase.rf_idRecordCasePatient
WHERE  (dbo.t_File.DateRegistration BETWEEN CONVERT(DATETIME, '2020-12-01 00:00:00', 102) AND CONVERT(DATETIME, '2021-01-15 00:00:00', 102)) AND 
               (dbo.t_RegistersAccounts.ReportYear = 2020) AND (dbo.t_RegistersAccounts.ReportMonth = 12) AND (dbo.t_RegistersAccounts.rf_idSMO <> '34') AND (dbo.t_Case.rf_idV006 <> 4) AND 
               (dbo.t_Diagnosis.DiagnosisCode IN ('B33.8', 'B34.2', 'U07.1', 'U07.2')) AND (dbo.t_Diagnosis.TypeDiagnosis = 1 OR
               dbo.t_Diagnosis.TypeDiagnosis = 3)
GROUP BY dbo.t_CompletedCase.id, dbo.t_CompletedCase.AmountPayment
GO
EXEC sp_addextendedproperty N'MS_DiagramPane1', N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[31] 4[28] 2[25] 3) )"
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
         Begin Table = "t_RegistersAccounts"
            Begin Extent = 
               Top = 128
               Left = 24
               Bottom = 296
               Right = 240
            End
            DisplayFlags = 280
            TopColumn = 4
         End
         Begin Table = "t_File"
            Begin Extent = 
               Top = 2
               Left = 0
               Bottom = 117
               Right = 174
            End
            DisplayFlags = 280
            TopColumn = 8
         End
         Begin Table = "t_Case"
            Begin Extent = 
               Top = 0
               Left = 671
               Bottom = 140
               Right = 884
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "t_Diagnosis"
            Begin Extent = 
               Top = 0
               Left = 892
               Bottom = 176
               Right = 1066
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "t_RecordCasePatient"
            Begin Extent = 
               Top = 4
               Left = 293
               Bottom = 119
               Right = 499
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "t_CompletedCase"
            Begin Extent = 
               Top = 131
               Left = 423
               Bottom = 246
               Right = 631
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
         Width = 1358', 'SCHEMA', N'dbo', 'VIEW', N'View_LN9', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_DiagramPane2', N'
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
         Column = 1440
         Alias = 897
         Table = 1168
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1345
         SortOrder = 1413
         GroupBy = 1350
         Filter = 5108
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
', 'SCHEMA', N'dbo', 'VIEW', N'View_LN9', NULL, NULL
GO
DECLARE @xp int
SELECT @xp=2
EXEC sp_addextendedproperty N'MS_DiagramPaneCount', @xp, 'SCHEMA', N'dbo', 'VIEW', N'View_LN9', NULL, NULL
GO
