SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE VIEW dbo.View_VBR
AS
SELECT     dbo.t_File.CodeM, dbo.vw_sprT001_Report.NameS, dbo.t_RegistersAccounts.rf_idSMO, dbo.t_Case.id, dbo.t_PatientSMO.ENP, 
                      dbo.t_DispInfo.TypeDisp, dbo.t_Case.AmountPayment
FROM         dbo.t_File INNER JOIN
                      dbo.t_RegistersAccounts ON dbo.t_File.id = dbo.t_RegistersAccounts.rf_idFiles INNER JOIN
                      dbo.t_RecordCasePatient ON dbo.t_RegistersAccounts.id = dbo.t_RecordCasePatient.rf_idRegistersAccounts INNER JOIN
                      dbo.t_Case ON dbo.t_RecordCasePatient.id = dbo.t_Case.rf_idRecordCasePatient INNER JOIN
                      dbo.t_DispInfo ON dbo.t_Case.id = dbo.t_DispInfo.rf_idCase INNER JOIN
                      dbo.t_PatientSMO ON dbo.t_RecordCasePatient.id = dbo.t_PatientSMO.rf_idRecordCasePatient INNER JOIN
                      dbo.vw_sprT001_Report ON dbo.t_File.CodeM = dbo.vw_sprT001_Report.CodeM
WHERE     (dbo.t_File.DateRegistration BETWEEN CONVERT(DATETIME, '2017-01-01 00:00:00', 102) AND CONVERT(DATETIME, '2017-09-15 00:00:00', 102)) AND 
                      (dbo.t_RegistersAccounts.rf_idSMO <> '34') AND (dbo.t_RegistersAccounts.ReportYear = 2017) AND (dbo.t_RegistersAccounts.ReportMonth BETWEEN 
                      1 AND 8) AND (dbo.t_RegistersAccounts.Letter = 'O' OR
                      dbo.t_RegistersAccounts.Letter = 'R') AND (dbo.t_DispInfo.IsMobileTeam = 1)
GO
EXEC sp_addextendedproperty N'MS_DiagramPane1', N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[17] 4[47] 2[8] 3) )"
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
               Left = 38
               Bottom = 224
               Right = 201
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "t_RegistersAccounts"
            Begin Extent = 
               Top = 6
               Left = 239
               Bottom = 209
               Right = 440
            End
            DisplayFlags = 280
            TopColumn = 11
         End
         Begin Table = "t_RecordCasePatient"
            Begin Extent = 
               Top = 6
               Left = 478
               Bottom = 114
               Right = 671
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "t_Case"
            Begin Extent = 
               Top = 6
               Left = 709
               Bottom = 200
               Right = 905
            End
            DisplayFlags = 280
            TopColumn = 12
         End
         Begin Table = "t_DispInfo"
            Begin Extent = 
               Top = 0
               Left = 1064
               Bottom = 108
               Right = 1217
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "t_PatientSMO"
            Begin Extent = 
               Top = 124
               Left = 512
               Bottom = 232
               Right = 708
            End
            DisplayFlags = 280
            TopColumn = 3
         End
         Begin Table = "vw_sprT001_Report"
            Begin Extent = 
               Top = 241
               Left = 23
               Bottom = 349
               Right = 176
          ', 'SCHEMA', N'dbo', 'VIEW', N'View_VBR', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_DiagramPane2', N'  End
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
      Begin ColumnWidths = 11
         Width = 284
         Width = 1890
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1725
         Width = 1620
         Width = 1500
         Width = 1500
         Width = 1560
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 4095
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 3960
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
', 'SCHEMA', N'dbo', 'VIEW', N'View_VBR', NULL, NULL
GO
DECLARE @xp int
SELECT @xp=2
EXEC sp_addextendedproperty N'MS_DiagramPaneCount', @xp, 'SCHEMA', N'dbo', 'VIEW', N'View_VBR', NULL, NULL
GO
