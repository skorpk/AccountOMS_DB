SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE VIEW [dbo].[View_cov-2-2-1-1]
AS
SELECT DISTINCT COUNT(DISTINCT dbo.t_RecordCasePatient.id) AS Expr1
FROM     dbo.t_Case INNER JOIN
               dbo.t_RecordCasePatient ON dbo.t_Case.rf_idRecordCasePatient = dbo.t_RecordCasePatient.id INNER JOIN
               dbo.t_RegistersAccounts ON dbo.t_RecordCasePatient.rf_idRegistersAccounts = dbo.t_RegistersAccounts.id INNER JOIN
               dbo.t_File ON dbo.t_RegistersAccounts.rf_idFiles = dbo.t_File.id INNER JOIN
               dbo.t_Diagnosis ON dbo.t_Case.id = dbo.t_Diagnosis.rf_idCase INNER JOIN
               dbo.vw_sprT001_Report ON dbo.t_RegistersAccounts.rf_idMO = dbo.vw_sprT001_Report.mcod INNER JOIN
               dbo.t_MES ON dbo.t_Case.id = dbo.t_MES.rf_idCase
WHERE  (CASE WHEN pfa = 1 OR
               pfs = 1 THEN 1 ELSE 0 END = 0) AND (dbo.t_Case.rf_idV006 = 3) AND (dbo.t_RegistersAccounts.rf_idSMO = '34') AND (dbo.t_RegistersAccounts.ReportMonth IN (3, 4)) AND 
               (dbo.t_RegistersAccounts.ReportYear = 2020) AND (dbo.t_File.DateRegistration BETWEEN CONVERT(DATETIME, '2020-04-09 00:00:00', 102) AND CONVERT(DATETIME, 
               '2020-05-16 00:00:00', 102)) AND (CASE WHEN (t_diagnosis.TypeDiagnosis = 1 AND t_diagnosis.Diagnosiscode NOT IN ('U07.1 . U07.2 . Z03.8 . Z22.8 . Z20.8 . Z11.5 . B34.2 . B33.8') 
               AND t_diagnosis.Diagnosiscode NOT LIKE 'J1[2-8]%') THEN CASE WHEN (t_diagnosis.TypeDiagnosis = 3 AND t_diagnosis.Diagnosiscode NOT IN ('U07.1 . U07.2 . Z20.8 . B34.2')) 
               THEN 0 ELSE 1 END ELSE 1 END = 1) AND (dbo.t_MES.MES LIKE '2.78%') OR
               (CASE WHEN pfa = 1 OR
               pfs = 1 THEN 1 ELSE 0 END = 1) AND (dbo.t_Case.rf_idV006 = 3) AND (dbo.t_RegistersAccounts.rf_idSMO = '34') AND (dbo.t_RegistersAccounts.ReportMonth IN (3, 4)) AND 
               (dbo.t_RegistersAccounts.ReportYear = 2020) AND (dbo.t_File.DateRegistration BETWEEN CONVERT(DATETIME, '2020-04-09 00:00:00', 102) AND CONVERT(DATETIME, 
               '2020-05-16 00:00:00', 102)) AND (CASE WHEN (t_diagnosis.TypeDiagnosis = 1 AND t_diagnosis.Diagnosiscode NOT IN ('U07.1 . U07.2 . Z03.8 . Z22.8 . Z20.8 . Z11.5 . B34.2 . B33.8') 
               AND t_diagnosis.Diagnosiscode NOT LIKE 'J1[2-8]%') THEN CASE WHEN (t_diagnosis.TypeDiagnosis = 3 AND t_diagnosis.Diagnosiscode NOT IN ('U07.1 . U07.2 . Z20.8 . B34.2')) 
               THEN 0 ELSE 1 END ELSE 1 END = 1) AND (dbo.t_MES.MES LIKE '2.78%')
GO
EXEC sp_addextendedproperty N'MS_DiagramPane1', N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[36] 4[7] 2[39] 3) )"
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
               Top = 2
               Left = 531
               Bottom = 117
               Right = 760
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "t_RecordCasePatient"
            Begin Extent = 
               Top = 125
               Left = 234
               Bottom = 240
               Right = 456
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "t_RegistersAccounts"
            Begin Extent = 
               Top = 0
               Left = 225
               Bottom = 115
               Right = 457
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "t_File"
            Begin Extent = 
               Top = 119
               Left = 0
               Bottom = 234
               Right = 190
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "t_Diagnosis"
            Begin Extent = 
               Top = 130
               Left = 537
               Bottom = 229
               Right = 727
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "vw_sprT001_Report"
            Begin Extent = 
               Top = 0
               Left = 2
               Bottom = 115
               Right = 192
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "t_MES"
            Begin Extent = 
               Top = 0
               Left = 827
               Bottom = 115
               Right = 1017
            End
  ', 'SCHEMA', N'dbo', 'VIEW', N'View_cov-2-2-1-1', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_DiagramPane2', N'          DisplayFlags = 280
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
         Column = 829
         Alias = 897
         Table = 1168
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1345
         SortOrder = 1413
         GroupBy = 1350
         Filter = 3600
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
', 'SCHEMA', N'dbo', 'VIEW', N'View_cov-2-2-1-1', NULL, NULL
GO
DECLARE @xp int
SELECT @xp=2
EXEC sp_addextendedproperty N'MS_DiagramPaneCount', @xp, 'SCHEMA', N'dbo', 'VIEW', N'View_cov-2-2-1-1', NULL, NULL
GO
