SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE VIEW [dbo].[View_6]
AS
SELECT  TOP (100) PERCENT dbo.t_File.DateRegistration, dbo.t_RegistersAccounts.ReportYear, dbo.t_RegistersAccounts.rf_idSMO, dbo.t_DispInfo.TypeDisp, dbo.t_Case.rf_idV006, 
               dbo.t_RegistersAccounts.ReportMonth, dbo.t_Case.id
FROM     dbo.t_RecordCasePatient INNER JOIN
               dbo.t_Case ON dbo.t_RecordCasePatient.id = dbo.t_Case.rf_idRecordCasePatient INNER JOIN
               dbo.t_RegistersAccounts INNER JOIN
               dbo.t_File ON dbo.t_RegistersAccounts.rf_idFiles = dbo.t_File.id ON dbo.t_RecordCasePatient.rf_idRegistersAccounts = dbo.t_RegistersAccounts.id INNER JOIN
               dbo.t_DispInfo ON dbo.t_Case.id = dbo.t_DispInfo.rf_idCase
WHERE  (dbo.t_File.DateRegistration BETWEEN CONVERT(DATETIME, '2019-01-01 00:00:00', 102) AND CONVERT(DATETIME, '2019-05-09 00:00:00', 102)) AND 
               (dbo.t_RegistersAccounts.ReportYear = 2019) AND (dbo.t_RegistersAccounts.rf_idSMO <> '34') AND (dbo.t_DispInfo.TypeDisp = 'ДВ1' OR
               dbo.t_DispInfo.TypeDisp = 'ДВ3') AND (dbo.t_Case.rf_idV006 = 3) AND (dbo.t_RegistersAccounts.ReportMonth BETWEEN 1 AND 4)
GO
EXEC sp_addextendedproperty N'MS_DiagramPane1', N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[38] 4[24] 2[20] 3) )"
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
               Top = 2
               Left = 471
               Bottom = 287
               Right = 677
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "t_Case"
            Begin Extent = 
               Top = 0
               Left = 734
               Bottom = 296
               Right = 947
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "t_RegistersAccounts"
            Begin Extent = 
               Top = 0
               Left = 223
               Bottom = 243
               Right = 439
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "t_File"
            Begin Extent = 
               Top = 13
               Left = 13
               Bottom = 229
               Right = 187
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "t_DispInfo"
            Begin Extent = 
               Top = 10
               Left = 1015
               Bottom = 223
               Right = 1189
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
         Column = 1440
      ', 'SCHEMA', N'dbo', 'VIEW', N'View_6', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_DiagramPane2', N'   Alias = 897
         Table = 1168
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1345
         SortOrder = 1413
         GroupBy = 1350
         Filter = 5325
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
', 'SCHEMA', N'dbo', 'VIEW', N'View_6', NULL, NULL
GO
DECLARE @xp int
SELECT @xp=2
EXEC sp_addextendedproperty N'MS_DiagramPaneCount', @xp, 'SCHEMA', N'dbo', 'VIEW', N'View_6', NULL, NULL
GO
