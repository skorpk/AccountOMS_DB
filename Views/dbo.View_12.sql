SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE VIEW [dbo].[View_12]
AS
SELECT  dbo.t_RegisterPatientDocument.SNILS, dbo.t_PatientSMO.ENP, dbo.t_RegisterPatient.Fam, dbo.t_RegisterPatient.Im, dbo.t_RegisterPatient.Ot, dbo.t_RegisterPatient.BirthDay, 
               dbo.t_RegisterPatient.rf_idV005, dbo.t_Case.DateBegin, dbo.t_Case.DateEnd, dbo.t_Case.rf_idMO, dbo.t_RegistersAccounts.rf_idSMO, dbo.t_File.DateRegistration, dbo.t_Case.id, 
               dbo.t_RecordCasePatient.AttachLPU, dbo.Diagn1$.Code, dbo.Diagn1$.Name
FROM     dbo.t_RecordCasePatient INNER JOIN
               dbo.t_RegistersAccounts ON dbo.t_RecordCasePatient.rf_idRegistersAccounts = dbo.t_RegistersAccounts.id INNER JOIN
               dbo.t_File ON dbo.t_RegistersAccounts.rf_idFiles = dbo.t_File.id INNER JOIN
               dbo.t_RegisterPatient ON dbo.t_File.id = dbo.t_RegisterPatient.rf_idFiles AND dbo.t_RecordCasePatient.id = dbo.t_RegisterPatient.rf_idRecordCase INNER JOIN
               dbo.t_Case ON dbo.t_RecordCasePatient.id = dbo.t_Case.rf_idRecordCasePatient INNER JOIN
               dbo.t_PatientSMO ON dbo.t_RecordCasePatient.id = dbo.t_PatientSMO.rf_idRecordCasePatient INNER JOIN
               dbo.t_RegisterPatientDocument ON dbo.t_RegisterPatient.id = dbo.t_RegisterPatientDocument.rf_idRegisterPatient INNER JOIN
               dbo.t_Diagnosis ON dbo.t_Case.id = dbo.t_Diagnosis.rf_idCase INNER JOIN
               dbo.Diagn1$ ON dbo.t_Diagnosis.DiagnosisCode = dbo.Diagn1$.Code LEFT OUTER JOIN
               dbo.View_tmp_eks ON dbo.t_Case.id = dbo.View_tmp_eks.rf_idCase
WHERE  (dbo.t_RegistersAccounts.ReportYear = 2019) AND (dbo.t_RegistersAccounts.rf_idSMO <> '34') AND (dbo.t_File.DateRegistration BETWEEN CONVERT(DATETIME, 
               '2019-06-01 00:00:00', 102) AND CONVERT(DATETIME, '2020-07-10 00:00:00', 102)) AND (dbo.t_Case.AmountPayment - ISNULL(dbo.View_tmp_eks.Expr1, 0) > 0) AND 
               (dbo.t_Case.rf_idV006 = 1) AND (dbo.t_RegistersAccounts.ReportMonth BETWEEN 7 AND 12) AND (dbo.t_Diagnosis.TypeDiagnosis = 1) OR
               (dbo.t_RegistersAccounts.ReportYear = 2020) AND (dbo.t_RegistersAccounts.rf_idSMO <> '34') AND (dbo.t_File.DateRegistration BETWEEN CONVERT(DATETIME, 
               '2019-06-01 00:00:00', 102) AND CONVERT(DATETIME, '2020-07-10 00:00:00', 102)) AND (dbo.t_Case.AmountPayment - ISNULL(dbo.View_tmp_eks.Expr1, 0) > 0) AND 
               (dbo.t_Case.rf_idV006 = 1) AND (dbo.t_RegistersAccounts.ReportMonth BETWEEN 1 AND 6) AND (dbo.t_Diagnosis.TypeDiagnosis = 1)
GO
EXEC sp_addextendedproperty N'MS_DiagramPane1', N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[24] 4[59] 2[0] 3) )"
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
               Left = 359
               Bottom = 121
               Right = 565
            End
            DisplayFlags = 280
            TopColumn = 8
         End
         Begin Table = "t_RegistersAccounts"
            Begin Extent = 
               Top = 160
               Left = 39
               Bottom = 275
               Right = 255
            End
            DisplayFlags = 280
            TopColumn = 10
         End
         Begin Table = "t_File"
            Begin Extent = 
               Top = 1
               Left = 15
               Bottom = 116
               Right = 189
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "t_RegisterPatient"
            Begin Extent = 
               Top = 142
               Left = 962
               Bottom = 257
               Right = 1136
            End
            DisplayFlags = 280
            TopColumn = 1
         End
         Begin Table = "t_Case"
            Begin Extent = 
               Top = 270
               Left = 673
               Bottom = 385
               Right = 886
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "t_PatientSMO"
            Begin Extent = 
               Top = 13
               Left = 955
               Bottom = 128
               Right = 1163
            End
            DisplayFlags = 280
            TopColumn = 3
         End
         Begin Table = "t_RegisterPatientDocument"
            Begin Extent = 
               Top = 63
               Left = 1254
               Bottom = 237
               Righ', 'SCHEMA', N'dbo', 'VIEW', N'View_12', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_DiagramPane2', N't = 1445
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "t_Diagnosis"
            Begin Extent = 
               Top = 284
               Left = 272
               Bottom = 383
               Right = 446
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Diagn1$"
            Begin Extent = 
               Top = 279
               Left = 63
               Bottom = 362
               Right = 237
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "View_tmp_eks"
            Begin Extent = 
               Top = 193
               Left = 408
               Bottom = 276
               Right = 582
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
         Column = 3953
         Alias = 897
         Table = 1168
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1345
         SortOrder = 1413
         GroupBy = 1350
         Filter = 5217
         Or = 2527
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
