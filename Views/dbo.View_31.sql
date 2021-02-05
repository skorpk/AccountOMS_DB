SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE VIEW [dbo].[View_3]
AS
SELECT  dbo.t_PatientSMO.ENP, dbo.t_MES.MES, dbo.форма$.CodeSh, dbo.форма$.MNN, dbo.форма$.NAMESH, dbo.форма$.Sh, dbo.форма$.DateSH, dbo.форма$.SL, dbo.форма$.Cart, 
               dbo.форма$.DateB, dbo.форма$.DateE, dbo.форма$.St, dbo.t_RegistersAccounts.rf_idMO, dbo.t_RegistersAccounts.ReportYear, oms_nsi.dbo.View_6.name
FROM     dbo.t_Case INNER JOIN
               dbo.t_MES ON dbo.t_Case.id = dbo.t_MES.rf_idCase INNER JOIN
               dbo.t_RecordCasePatient ON dbo.t_Case.rf_idRecordCasePatient = dbo.t_RecordCasePatient.id INNER JOIN
               dbo.t_RegistersAccounts ON dbo.t_RecordCasePatient.rf_idRegistersAccounts = dbo.t_RegistersAccounts.id INNER JOIN
               dbo.t_PatientSMO ON dbo.t_RecordCasePatient.id = dbo.t_PatientSMO.rf_idRecordCasePatient INNER JOIN
               dbo.форма$ ON dbo.t_RegistersAccounts.Account = dbo.форма$.Sh AND dbo.t_RecordCasePatient.idRecord = dbo.форма$.SL INNER JOIN
               oms_nsi.dbo.View_6 ON dbo.t_MES.MES = oms_nsi.dbo.View_6.code
WHERE  (dbo.t_RegistersAccounts.rf_idMO = '340017') AND (dbo.t_RegistersAccounts.ReportYear = 2020)
GO
EXEC sp_addextendedproperty N'MS_DiagramPane1', N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
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
               Top = 6
               Left = 42
               Bottom = 121
               Right = 255
            End
            DisplayFlags = 280
            TopColumn = 1
         End
         Begin Table = "t_MES"
            Begin Extent = 
               Top = 164
               Left = 313
               Bottom = 279
               Right = 487
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "t_RecordCasePatient"
            Begin Extent = 
               Top = 6
               Left = 513
               Bottom = 121
               Right = 719
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "t_RegistersAccounts"
            Begin Extent = 
               Top = 6
               Left = 761
               Bottom = 121
               Right = 977
            End
            DisplayFlags = 280
            TopColumn = 3
         End
         Begin Table = "t_PatientSMO"
            Begin Extent = 
               Top = 126
               Left = 42
               Bottom = 241
               Right = 250
            End
            DisplayFlags = 280
            TopColumn = 2
         End
         Begin Table = "форма$"
            Begin Extent = 
               Top = 168
               Left = 862
               Bottom = 283
               Right = 1036
            End
            DisplayFlags = 280
            TopColumn = 10
         End
         Begin Table = "View_6 (oms_nsi.dbo)"
            Begin Extent = 
               Top = 177
               Left = 583
               Bottom = 276
               Right = 757
         ', 'SCHEMA', N'dbo', 'VIEW', N'View_3', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_DiagramPane2', N'   End
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
      Begin ColumnWidths = 14
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
', 'SCHEMA', N'dbo', 'VIEW', N'View_3', NULL, NULL
GO
DECLARE @xp int
SELECT @xp=2
EXEC sp_addextendedproperty N'MS_DiagramPaneCount', @xp, 'SCHEMA', N'dbo', 'VIEW', N'View_3', NULL, NULL
GO
