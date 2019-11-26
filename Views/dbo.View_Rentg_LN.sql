SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE VIEW dbo.View_Rentg_LN
AS
SELECT  dbo.t_File.DateRegistration, dbo.t_RegistersAccounts.ReportMonth, dbo.t_RegistersAccounts.ReportYear, dbo.t_RegistersAccounts.rf_idSMO, dbo.t_Case.rf_idDirectMO, 
               dbo.t_Case.rf_idV006, dbo.t_Meduslugi.MUGroupCode, dbo.t_Meduslugi.MUUnGroupCode, dbo.t_Meduslugi.MUCode, dbo.t_Meduslugi.Quantity, dbo.t_Case.rf_idMO, 
               dbo.t_Meduslugi.MU, dbo.t_Case.AmountPayment, dbo.t_RecordCasePatient.idRecord, dbo.t_RegistersAccounts.Account, dbo.t_RegistersAccounts.DateRegister, 
               dbo.t_RecordCasePatient.NumberPolis, dbo.t_PatientSMO.ENP, dbo.t_Case.id
FROM     dbo.t_File INNER JOIN
               dbo.t_RegistersAccounts ON dbo.t_File.id = dbo.t_RegistersAccounts.rf_idFiles INNER JOIN
               dbo.t_RecordCasePatient ON dbo.t_RegistersAccounts.id = dbo.t_RecordCasePatient.rf_idRegistersAccounts INNER JOIN
               dbo.t_Case ON dbo.t_RecordCasePatient.id = dbo.t_Case.rf_idRecordCasePatient INNER JOIN
               dbo.t_Meduslugi ON dbo.t_Case.id = dbo.t_Meduslugi.rf_idCase INNER JOIN
               dbo.t_PatientSMO ON dbo.t_RecordCasePatient.id = dbo.t_PatientSMO.rf_idRecordCasePatient
WHERE  (dbo.t_File.DateRegistration BETWEEN CONVERT(DATETIME, '2019-01-01 00:00:00', 102) AND CONVERT(DATETIME, '2019-07-03 00:00:00', 102)) AND 
               (dbo.t_RegistersAccounts.ReportYear = 2019) AND (dbo.t_RegistersAccounts.ReportMonth BETWEEN 1 AND 6) AND (dbo.t_RegistersAccounts.rf_idSMO <> '34') AND 
               (dbo.t_Meduslugi.MUGroupCode = 60) AND (dbo.t_Meduslugi.MUUnGroupCode = 5) AND (dbo.t_Case.rf_idMO = '805957') AND (dbo.t_Case.rf_idV006 = 3) AND 
               (dbo.t_Meduslugi.MUCode = 24 OR
               dbo.t_Meduslugi.MUCode = 4)
GO
EXEC sp_addextendedproperty N'MS_DiagramPane1', N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[22] 4[17] 2[31] 3) )"
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
               Bottom = 303
               Right = 216
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "t_RegistersAccounts"
            Begin Extent = 
               Top = 6
               Left = 258
               Bottom = 283
               Right = 474
            End
            DisplayFlags = 280
            TopColumn = 2
         End
         Begin Table = "t_RecordCasePatient"
            Begin Extent = 
               Top = 11
               Left = 517
               Bottom = 126
               Right = 723
            End
            DisplayFlags = 280
            TopColumn = 7
         End
         Begin Table = "t_Case"
            Begin Extent = 
               Top = 0
               Left = 776
               Bottom = 285
               Right = 989
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "t_Meduslugi"
            Begin Extent = 
               Top = 0
               Left = 1053
               Bottom = 233
               Right = 1243
            End
            DisplayFlags = 280
            TopColumn = 13
         End
         Begin Table = "t_PatientSMO"
            Begin Extent = 
               Top = 180
               Left = 505
               Bottom = 295
               Right = 713
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
      Begin ColumnWidths = 18
         Width = 284
         Width = 135', 'SCHEMA', N'dbo', 'VIEW', N'View_Rentg_LN', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_DiagramPane2', N'8
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
         Alias = 897
         Table = 4388
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1345
         SortOrder = 1413
         GroupBy = 1350
         Filter = 5746
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
', 'SCHEMA', N'dbo', 'VIEW', N'View_Rentg_LN', NULL, NULL
GO
DECLARE @xp int
SELECT @xp=2
EXEC sp_addextendedproperty N'MS_DiagramPaneCount', @xp, 'SCHEMA', N'dbo', 'VIEW', N'View_Rentg_LN', NULL, NULL
GO
