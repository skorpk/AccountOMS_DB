SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE VIEW dbo.View_Patient
AS
SELECT     dbo.t_RegisterPatient.Fam, dbo.t_RegisterPatient.Im, dbo.t_RegisterPatient.Ot, dbo.t_RegisterPatient.BirthDay, dbo.t_Case.rf_idMO, 
                      dbo.t_Case.rf_idV006, dbo.t_Case.rf_idV008, dbo.t_Case.NumberHistoryCase, dbo.t_Case.DateBegin, dbo.t_Case.DateEnd, 
                      dbo.t_RegistersAccounts.ReportYear, dbo.t_RegistersAccounts.ReportMonth, dbo.t_RegistersAccounts.NumberRegister, 
                      dbo.t_RegistersAccounts.PrefixNumberRegister, dbo.t_RegistersAccounts.PropertyNumberRegister, dbo.t_RegistersAccounts.DateRegister, 
                      dbo.t_RecordCasePatient.IsNew, dbo.t_Diagnosis.TypeDiagnosis, dbo.t_Diagnosis.DiagnosisCode, dbo.t_Meduslugi.MUGroupCode, 
                      dbo.t_Meduslugi.MUUnGroupCode, dbo.t_Meduslugi.MUCode, dbo.t_Meduslugi.Quantity, dbo.t_Case.idRecordCase, dbo.t_Case.AmountPayment, 
                      dbo.t_RecordCasePatient.idRecord, dbo.t_Meduslugi.Price, dbo.t_RegistersAccounts.Letter, dbo.t_RegistersAccounts.rf_idSMO, 
                      dbo.t_RegisterPatientDocument.rf_idDocumentType, dbo.t_RegisterPatientDocument.SeriaDocument, 
                      dbo.t_RegisterPatientDocument.NumberDocument, dbo.t_RegisterPatientDocument.SNILS, dbo.t_RegisterPatientDocument.OKATO
FROM         dbo.t_Case INNER JOIN
                      dbo.t_RecordCasePatient ON dbo.t_Case.rf_idRecordCasePatient = dbo.t_RecordCasePatient.id INNER JOIN
                      dbo.t_PatientSMO ON dbo.t_RecordCasePatient.id = dbo.t_PatientSMO.rf_idRecordCasePatient INNER JOIN
                      dbo.t_RegistersAccounts ON dbo.t_RecordCasePatient.rf_idRegistersAccounts = dbo.t_RegistersAccounts.id INNER JOIN
                      dbo.t_Diagnosis ON dbo.t_Case.id = dbo.t_Diagnosis.rf_idCase INNER JOIN
                      dbo.t_Meduslugi ON dbo.t_Case.id = dbo.t_Meduslugi.rf_idCase INNER JOIN
                      dbo.t_RegisterPatient ON dbo.t_RecordCasePatient.id = dbo.t_RegisterPatient.rf_idRecordCase INNER JOIN
                      dbo.t_RegisterPatientDocument ON dbo.t_RegisterPatient.id = dbo.t_RegisterPatientDocument.rf_idRegisterPatient
WHERE     (dbo.t_Diagnosis.TypeDiagnosis = 1)
GO
GRANT SELECT ON  [dbo].[View_Patient] TO [db_AccountOMS]
GO
EXEC sp_addextendedproperty N'MS_DiagramPane1', N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[21] 4[42] 2[3] 3) )"
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
               Top = 18
               Left = 371
               Bottom = 126
               Right = 565
            End
            DisplayFlags = 280
            TopColumn = 2
         End
         Begin Table = "t_RecordCasePatient"
            Begin Extent = 
               Top = 189
               Left = 235
               Bottom = 381
               Right = 426
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "t_PatientSMO"
            Begin Extent = 
               Top = 308
               Left = 704
               Bottom = 416
               Right = 898
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "t_RegistersAccounts"
            Begin Extent = 
               Top = 210
               Left = 18
               Bottom = 422
               Right = 217
            End
            DisplayFlags = 280
            TopColumn = 8
         End
         Begin Table = "t_Diagnosis"
            Begin Extent = 
               Top = 68
               Left = 178
               Bottom = 161
               Right = 329
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "t_Meduslugi"
            Begin Extent = 
               Top = 4
               Left = 2
               Bottom = 112
               Right = 177
            End
            DisplayFlags = 280
            TopColumn = 13
         End
         Begin Table = "t_RegisterPatient"
            Begin Extent = 
               Top = 18
               Left = 626
               Bottom = 242
               Right = 786
   ', 'SCHEMA', N'dbo', 'VIEW', N'View_Patient', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_DiagramPane2', N'         End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "t_RegisterPatientDocument"
            Begin Extent = 
               Top = 55
               Left = 920
               Bottom = 163
               Right = 1025
            End
            DisplayFlags = 280
            TopColumn = 3
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 35
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
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
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
', 'SCHEMA', N'dbo', 'VIEW', N'View_Patient', NULL, NULL
GO
DECLARE @xp int
SELECT @xp=2
EXEC sp_addextendedproperty N'MS_DiagramPaneCount', @xp, 'SCHEMA', N'dbo', 'VIEW', N'View_Patient', NULL, NULL
GO
