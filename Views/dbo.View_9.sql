SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE VIEW [dbo].[View_9]
AS
SELECT  TOP (100) PERCENT dbo.t_RegistersAccounts.rf_idMO, dbo.t_CompletedCase.AmountPayment AS Summ, dbo.t_CompletedCase.id AS ид, MIN(dbo.t_File.CodeM) AS Expr3
FROM     dbo.t_RecordCasePatient INNER JOIN
               dbo.t_RegistersAccounts ON dbo.t_RecordCasePatient.rf_idRegistersAccounts = dbo.t_RegistersAccounts.id INNER JOIN
               dbo.t_File ON dbo.t_RegistersAccounts.rf_idFiles = dbo.t_File.id INNER JOIN
               dbo.t_Case ON dbo.t_RecordCasePatient.id = dbo.t_Case.rf_idRecordCasePatient INNER JOIN
               dbo.t_Diagnosis ON dbo.t_Case.id = dbo.t_Diagnosis.rf_idCase INNER JOIN
               dbo.t_CompletedCase ON dbo.t_RecordCasePatient.id = dbo.t_CompletedCase.rf_idRecordCasePatient
WHERE  (dbo.t_File.DateRegistration BETWEEN CONVERT(DATETIME, '2020-03-07 00:00:00', 102) AND CONVERT(DATETIME, '2020-04-08 00:00:00', 102)) AND 
               (dbo.t_RegistersAccounts.ReportYear = 2020) AND (dbo.t_RegistersAccounts.ReportMonth = 3) AND (dbo.t_RegistersAccounts.rf_idSMO <> '34') AND 
               (dbo.t_Diagnosis.TypeDiagnosis = 1) AND (dbo.t_Diagnosis.DiagnosisCode IN ('U07.1', 'U07.2', 'Z03.8', 'Z22.8', 'Z20.8', 'Z11.5', 'B34.2', 'B33.8') OR
               dbo.t_Diagnosis.DiagnosisCode LIKE 'J1[2-8]%') OR
               (dbo.t_File.DateRegistration BETWEEN CONVERT(DATETIME, '2020-03-07 00:00:00', 102) AND CONVERT(DATETIME, '2020-04-08 00:00:00', 102)) AND 
               (dbo.t_RegistersAccounts.ReportYear = 2020) AND (dbo.t_RegistersAccounts.ReportMonth = 3) AND (dbo.t_RegistersAccounts.rf_idSMO <> '34') AND 
               (dbo.t_Diagnosis.TypeDiagnosis = 3) AND (dbo.t_Diagnosis.DiagnosisCode IN ('U07.1', 'U07.2', 'Z20.8', 'B34.2'))
GROUP BY dbo.t_RegistersAccounts.rf_idMO, dbo.t_CompletedCase.AmountPayment, dbo.t_CompletedCase.id
GO
EXEC sp_addextendedproperty N'MS_DiagramPane1', N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[32] 4[45] 2[19] 3) )"
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
               Top = 23
               Left = 558
               Bottom = 138
               Right = 764
            End
            DisplayFlags = 280
            TopColumn = 2
         End
         Begin Table = "t_RegistersAccounts"
            Begin Extent = 
               Top = 38
               Left = 239
               Bottom = 153
               Right = 455
            End
            DisplayFlags = 280
            TopColumn = 16
         End
         Begin Table = "t_File"
            Begin Extent = 
               Top = 4
               Left = 9
               Bottom = 119
               Right = 183
            End
            DisplayFlags = 280
            TopColumn = 8
         End
         Begin Table = "t_Case"
            Begin Extent = 
               Top = 9
               Left = 793
               Bottom = 295
               Right = 1006
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "t_Diagnosis"
            Begin Extent = 
               Top = 72
               Left = 1187
               Bottom = 171
               Right = 1361
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "t_CompletedCase"
            Begin Extent = 
               Top = 167
               Left = 62
               Bottom = 282
               Right = 270
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
         Width = ', 'SCHEMA', N'dbo', 'VIEW', N'View_9', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_DiagramPane2', N'1358
         Width = 3464
         Width = 1358
         Width = 1358
         Width = 1358
         Width = 1358
         Width = 1358
         Width = 1358
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 13
         Column = 1440
         Alias = 897
         Table = 3002
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1345
         SortOrder = 747
         GroupBy = 1350
         Filter = 435
         Or = 4469
         Or = 4171
         Or = 2011
         Or = 1350
      End
   End
End
', 'SCHEMA', N'dbo', 'VIEW', N'View_9', NULL, NULL
GO
DECLARE @xp int
SELECT @xp=2
EXEC sp_addextendedproperty N'MS_DiagramPaneCount', @xp, 'SCHEMA', N'dbo', 'VIEW', N'View_9', NULL, NULL
GO
