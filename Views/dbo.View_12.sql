SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE VIEW [dbo].[View_12]
AS
SELECT  SUM(dbo.t_Case.AmountPayment) AS Expr2, dbo.t_RegistersAccounts.rf_idSMO, dbo.t_RecordCasePatient.id, dbo.t_Case.rf_idV006, 
               CASE WHEN DiagnosisCode LIKE 'I%' THEN 'БСК' ELSE (CASE WHEN DiagnosisCode LIKE 'J%' THEN 'ОД' ELSE (CASE WHEN DiagnosisCode LIKE 'k%' THEN 'пищеварен' ELSE (CASE
                WHEN DiagnosisCode LIKE 'E%' THEN 'эндокрин' ELSE (CASE WHEN DiagnosisCode LIKE 'c%' OR
               DiagnosisCode LIKE 'D0[0-9]%' THEN 'ЗНО' ELSE 'др' END) END) END) END) END AS diag, dbo.t_PatientSMO.ENP, 
               CASE WHEN Age < 18 THEN 'Дети' ELSE 'Взрослые' END AS Vzrst
FROM     dbo.t_Case INNER JOIN
               dbo.t_RecordCasePatient ON dbo.t_Case.rf_idRecordCasePatient = dbo.t_RecordCasePatient.id INNER JOIN
               dbo.t_RegistersAccounts ON dbo.t_RecordCasePatient.rf_idRegistersAccounts = dbo.t_RegistersAccounts.id INNER JOIN
               dbo.t_File ON dbo.t_RegistersAccounts.rf_idFiles = dbo.t_File.id INNER JOIN
               dbo.t_Diagnosis ON dbo.t_Case.id = dbo.t_Diagnosis.rf_idCase INNER JOIN
               dbo.t_PatientSMO ON dbo.t_RecordCasePatient.id = dbo.t_PatientSMO.rf_idRecordCasePatient
WHERE  (dbo.t_RegistersAccounts.ReportYear = 2020) AND (dbo.t_File.DateRegistration BETWEEN CONVERT(DATETIME, '2020-03-01 00:00:00', 102) AND CONVERT(DATETIME, 
               '2020-05-08 00:00:00', 102)) AND (dbo.t_RegistersAccounts.ReportMonth > 2) AND (dbo.t_Diagnosis.TypeDiagnosis = 1)
GROUP BY dbo.t_RegistersAccounts.rf_idSMO, dbo.t_RecordCasePatient.id, dbo.t_Case.rf_idV006, 
               CASE WHEN DiagnosisCode LIKE 'I%' THEN 'БСК' ELSE (CASE WHEN DiagnosisCode LIKE 'J%' THEN 'ОД' ELSE (CASE WHEN DiagnosisCode LIKE 'k%' THEN 'пищеварен' ELSE (CASE
                WHEN DiagnosisCode LIKE 'E%' THEN 'эндокрин' ELSE (CASE WHEN DiagnosisCode LIKE 'c%' OR
               DiagnosisCode LIKE 'D0[0-9]%' THEN 'ЗНО' ELSE 'др' END) END) END) END) END, dbo.t_PatientSMO.ENP, CASE WHEN Age < 18 THEN 'Дети' ELSE 'Взрослые' END
HAVING  (dbo.t_RegistersAccounts.rf_idSMO <> '34') AND (dbo.t_Case.rf_idV006 = 1 OR
               dbo.t_Case.rf_idV006 = 3)
GO
EXEC sp_addextendedproperty N'MS_DiagramPane1', N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[23] 4[38] 2[20] 3) )"
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
               Top = 0
               Left = 818
               Bottom = 259
               Right = 1047
            End
            DisplayFlags = 280
            TopColumn = 13
         End
         Begin Table = "t_RecordCasePatient"
            Begin Extent = 
               Top = 20
               Left = 525
               Bottom = 236
               Right = 749
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "t_RegistersAccounts"
            Begin Extent = 
               Top = 4
               Left = 229
               Bottom = 272
               Right = 461
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "t_File"
            Begin Extent = 
               Top = 4
               Left = 3
               Bottom = 258
               Right = 193
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "t_Diagnosis"
            Begin Extent = 
               Top = 4
               Left = 1070
               Bottom = 186
               Right = 1260
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "t_PatientSMO"
            Begin Extent = 
               Top = 261
               Left = 696
               Bottom = 376
               Right = 920
            End
            DisplayFlags = 280
            TopColumn = 2
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
         Width = 1358', 'SCHEMA', N'dbo', 'VIEW', N'View_12', NULL, NULL
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
         Column = 7703
         Alias = 897
         Table = 2472
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1345
         SortOrder = 1413
         GroupBy = 1350
         Filter = 5583
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
', 'SCHEMA', N'dbo', 'VIEW', N'View_12', NULL, NULL
GO
DECLARE @xp int
SELECT @xp=2
EXEC sp_addextendedproperty N'MS_DiagramPaneCount', @xp, 'SCHEMA', N'dbo', 'VIEW', N'View_12', NULL, NULL
GO
