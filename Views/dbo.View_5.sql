SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE VIEW dbo.View_5
AS
SELECT  dbo.vw_sprT001.filialCode, dbo.vw_sprT001.filialName, dbo.t_RegistersAccounts.ReportYear, dbo.t_Case.rf_idMO, dbo.vw_sprT001.NAMES, dbo.t_Case.rf_idDoctor, 
               dbo.t_Case.rf_idV004, oms_nsi.dbo.sprV015.NAME, oms_nsi.dbo.sprV015.fullNAME
FROM     dbo.t_RegistersAccounts INNER JOIN
               dbo.t_File ON dbo.t_RegistersAccounts.rf_idFiles = dbo.t_File.id INNER JOIN
               dbo.t_Case INNER JOIN
               dbo.t_RecordCasePatient ON dbo.t_Case.rf_idRecordCasePatient = dbo.t_RecordCasePatient.id ON 
               dbo.t_RegistersAccounts.id = dbo.t_RecordCasePatient.rf_idRegistersAccounts INNER JOIN
               dbo.vw_sprT001 ON dbo.t_Case.rf_idMO = dbo.vw_sprT001.CodeM INNER JOIN
               oms_nsi.dbo.sprV015 ON dbo.t_Case.rf_idV004 = oms_nsi.dbo.sprV015.CODE
WHERE  (dbo.t_RegistersAccounts.ReportYear BETWEEN 2016 AND 2018) AND (dbo.t_Case.DateEnd BETWEEN CONVERT(DATETIME, '2016-01-01 00:00:00', 102) AND CONVERT(DATETIME, 
               '2018-12-31 00:00:00', 102)) AND (dbo.t_File.DateRegistration BETWEEN CONVERT(DATETIME, '2016-01-01 00:00:00', 102) AND CONVERT(DATETIME, '2019-01-22 00:00:00', 102))
GROUP BY dbo.t_RegistersAccounts.ReportYear, dbo.t_Case.rf_idMO, dbo.vw_sprT001.NAMES, dbo.vw_sprT001.filialCode, dbo.vw_sprT001.filialName, dbo.t_Case.rf_idDoctor, 
               dbo.t_Case.rf_idV004, oms_nsi.dbo.sprV015.NAME, oms_nsi.dbo.sprV015.fullNAME
GO
EXEC sp_addextendedproperty N'MS_DiagramPane1', N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[19] 4[42] 2[21] 3) )"
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
         Left = -712
      End
      Begin Tables = 
         Begin Table = "t_RegistersAccounts"
            Begin Extent = 
               Top = 0
               Left = 212
               Bottom = 328
               Right = 428
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "t_File"
            Begin Extent = 
               Top = 0
               Left = 3
               Bottom = 328
               Right = 177
            End
            DisplayFlags = 280
            TopColumn = 1
         End
         Begin Table = "t_Case"
            Begin Extent = 
               Top = 0
               Left = 1022
               Bottom = 295
               Right = 1235
            End
            DisplayFlags = 280
            TopColumn = 18
         End
         Begin Table = "t_RecordCasePatient"
            Begin Extent = 
               Top = 0
               Left = 475
               Bottom = 115
               Right = 681
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "vw_sprT001"
            Begin Extent = 
               Top = 307
               Left = 490
               Bottom = 422
               Right = 664
            End
            DisplayFlags = 280
            TopColumn = 2
         End
         Begin Table = "sprV015 (oms_nsi.dbo)"
            Begin Extent = 
               Top = 2
               Left = 1430
               Bottom = 117
               Right = 1628
            End
            DisplayFlags = 280
            TopColumn = 6
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
         W', 'SCHEMA', N'dbo', 'VIEW', N'View_5', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_DiagramPane2', N'idth = 1358
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
         Filter = 7118
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
', 'SCHEMA', N'dbo', 'VIEW', N'View_5', NULL, NULL
GO
DECLARE @xp int
SELECT @xp=2
EXEC sp_addextendedproperty N'MS_DiagramPaneCount', @xp, 'SCHEMA', N'dbo', 'VIEW', N'View_5', NULL, NULL
GO
