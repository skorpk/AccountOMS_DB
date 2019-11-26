SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE VIEW dbo.View_OKS
AS
SELECT  dbo.t_RecordCasePatient.NumberPolis, dbo.t_RecordCasePatient.SeriaPolis, dbo.t_PatientSMO.ENP, dbo.t_Case.rf_idV008, dbo.t_Diagnosis.DiagnosisCode, dbo.t_Case.DateBegin, 
               dbo.t_Case.DateEnd, dbo.t_Case.AmountPayment, dbo.t_MES.MES, dbo.t_RegisterPatient.Fam, dbo.t_RegisterPatient.Im, dbo.t_RegisterPatient.Ot, dbo.t_RegisterPatient.BirthDay, 
               dbo.t_RegisterPatient.rf_idV005, dbo.t_Case.id, dbo.t_Case.rf_idMO
FROM     dbo.t_RegistersAccounts INNER JOIN
               dbo.t_File ON dbo.t_RegistersAccounts.rf_idFiles = dbo.t_File.id INNER JOIN
               dbo.t_Case INNER JOIN
               dbo.t_Diagnosis ON dbo.t_Case.id = dbo.t_Diagnosis.rf_idCase INNER JOIN
               dbo.t_MES ON dbo.t_Case.id = dbo.t_MES.rf_idCase INNER JOIN
               dbo.t_RecordCasePatient ON dbo.t_Case.rf_idRecordCasePatient = dbo.t_RecordCasePatient.id ON 
               dbo.t_RegistersAccounts.id = dbo.t_RecordCasePatient.rf_idRegistersAccounts INNER JOIN
               dbo.t_PatientSMO ON dbo.t_RecordCasePatient.id = dbo.t_PatientSMO.rf_idRecordCasePatient INNER JOIN
               dbo.t_RegisterPatient ON dbo.t_File.id = dbo.t_RegisterPatient.rf_idFiles AND dbo.t_RecordCasePatient.id = dbo.t_RegisterPatient.rf_idRecordCase
WHERE  (dbo.t_File.DateRegistration BETWEEN CONVERT(DATETIME, '2018-01-01 00:00:00', 102) AND CONVERT(DATETIME, '2019-01-22 00:00:00', 102)) AND 
               (dbo.t_RegistersAccounts.ReportYear = 2018) AND (dbo.t_RegistersAccounts.rf_idSMO <> '34') AND (dbo.t_Case.rf_idV006 = 1) AND (dbo.t_Diagnosis.TypeDiagnosis = 1) AND 
               (dbo.t_Diagnosis.DiagnosisCode = 'i20.0' OR
               dbo.t_Diagnosis.DiagnosisCode = 'i20.1' OR
               dbo.t_Diagnosis.DiagnosisCode = 'i21.0' OR
               dbo.t_Diagnosis.DiagnosisCode = 'i21.1' OR
               dbo.t_Diagnosis.DiagnosisCode = 'i21.2' OR
               dbo.t_Diagnosis.DiagnosisCode = 'i21.3' OR
               dbo.t_Diagnosis.DiagnosisCode = 'i21.4' OR
               dbo.t_Diagnosis.DiagnosisCode = 'i21.9' OR
               dbo.t_Diagnosis.DiagnosisCode = 'i22.0' OR
               dbo.t_Diagnosis.DiagnosisCode = 'i22.1' OR
               dbo.t_Diagnosis.DiagnosisCode = 'i22.8' OR
               dbo.t_Diagnosis.DiagnosisCode = 'i22.9')
GO
EXEC sp_addextendedproperty N'MS_DiagramPane1', N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[25] 4[21] 2[13] 3) )"
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
               Left = 695
               Bottom = 315
               Right = 908
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "t_Diagnosis"
            Begin Extent = 
               Top = 0
               Left = 1051
               Bottom = 93
               Right = 1215
            End
            DisplayFlags = 280
            TopColumn = 1
         End
         Begin Table = "t_File"
            Begin Extent = 
               Top = 6
               Left = 8
               Bottom = 274
               Right = 182
            End
            DisplayFlags = 280
            TopColumn = 1
         End
         Begin Table = "t_MES"
            Begin Extent = 
               Top = 128
               Left = 1067
               Bottom = 243
               Right = 1241
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "t_RecordCasePatient"
            Begin Extent = 
               Top = 0
               Left = 445
               Bottom = 75
               Right = 651
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "t_RegistersAccounts"
            Begin Extent = 
               Top = 10
               Left = 206
               Bottom = 319
               Right = 422
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "t_PatientSMO"
            Begin Extent = 
               Top = 86
               Left = 456
               Bottom = 156
               Right = 664
            End
     ', 'SCHEMA', N'dbo', 'VIEW', N'View_OKS', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_DiagramPane2', N'       DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "t_RegisterPatient"
            Begin Extent = 
               Top = 198
               Left = 482
               Bottom = 459
               Right = 656
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
      Begin ColumnWidths = 20
         Width = 284
         Width = 1358
         Width = 1358
         Width = 1358
         Width = 1358
         Width = 1358
         Width = 1358
         Width = 1358
         Width = 1358
         Width = 1358
         Width = 1358
         Width = 1358
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
         Filter = 8545
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
', 'SCHEMA', N'dbo', 'VIEW', N'View_OKS', NULL, NULL
GO
DECLARE @xp int
SELECT @xp=2
EXEC sp_addextendedproperty N'MS_DiagramPaneCount', @xp, 'SCHEMA', N'dbo', 'VIEW', N'View_OKS', NULL, NULL
GO
