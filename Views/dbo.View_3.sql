SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE VIEW dbo.View_3
AS
SELECT  dbo.t_260order_ONK.USL_OK, dbo.t_260order_ONK.DATE_Z_1, dbo.t_260order_ONK.Date_Z_2, dbo.t_260order_ONK.NHISTORY, dbo.t_RegisterPatient.Fam, 
               dbo.t_RegisterPatient.Im, dbo.t_RegisterPatient.Ot, dbo.t_RegisterPatient.rf_idV005, dbo.t_RegisterPatient.BirthDay, dbo.t_Case.id, dbo.t_ONK_USL.rf_idN013, 
               dbo.t_ONK_USL.TypeSurgery, dbo.t_Case.rf_idMO, dbo.vw_sprT001_Report.NameS, dbo.vw_sprT001_Report.Namef, dbo.t_RegistersAccounts.ReportYear, 
               dbo.t_RegistersAccounts.ReportMonth, dbo.t_RegistersAccounts.DateRegister, dbo.t_RegistersAccounts.rf_idSMO, dbo.t_RegistersAccounts.Account, 
               dbo.t_RecordCasePatient.idRecord, oms_nsi.dbo.sprN014.THir_NAME, dbo.t_ONK_SL.DS1_T
FROM     dbo.t_RegisterPatient INNER JOIN
               dbo.t_RecordCasePatient ON dbo.t_RegisterPatient.rf_idRecordCase = dbo.t_RecordCasePatient.id INNER JOIN
               dbo.t_RegistersAccounts ON dbo.t_RecordCasePatient.rf_idRegistersAccounts = dbo.t_RegistersAccounts.id INNER JOIN
               dbo.t_Case ON dbo.t_RecordCasePatient.id = dbo.t_Case.rf_idRecordCasePatient INNER JOIN
               dbo.t_File ON dbo.t_RegisterPatient.rf_idFiles = dbo.t_File.id AND dbo.t_RegistersAccounts.rf_idFiles = dbo.t_File.id INNER JOIN
               dbo.t_260order_ONK ON dbo.t_Case.id = dbo.t_260order_ONK.rf_idCase INNER JOIN
               dbo.t_ONK_SL ON dbo.t_Case.id = dbo.t_ONK_SL.rf_idCase INNER JOIN
               dbo.t_ONK_USL ON dbo.t_Case.id = dbo.t_ONK_USL.rf_idCase INNER JOIN
               dbo.vw_sprT001_Report ON dbo.t_Case.rf_idMO = dbo.vw_sprT001_Report.CodeM INNER JOIN
               oms_nsi.dbo.sprN014 ON dbo.t_ONK_USL.TypeSurgery = oms_nsi.dbo.sprN014.sprN014Id
WHERE  (dbo.t_260order_ONK.USL_OK = 1)
GO
EXEC sp_addextendedproperty N'MS_DiagramPane1', N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[8] 4[44] 2[22] 3) )"
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
         Begin Table = "t_260order_ONK"
            Begin Extent = 
               Top = 0
               Left = 986
               Bottom = 190
               Right = 1194
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "t_RecordCasePatient"
            Begin Extent = 
               Top = 133
               Left = 543
               Bottom = 385
               Right = 749
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "t_RegisterPatient"
            Begin Extent = 
               Top = 140
               Left = 273
               Bottom = 401
               Right = 447
            End
            DisplayFlags = 280
            TopColumn = 5
         End
         Begin Table = "t_RegistersAccounts"
            Begin Extent = 
               Top = 0
               Left = 296
               Bottom = 115
               Right = 512
            End
            DisplayFlags = 280
            TopColumn = 16
         End
         Begin Table = "t_Case"
            Begin Extent = 
               Top = 0
               Left = 712
               Bottom = 115
               Right = 925
            End
            DisplayFlags = 280
            TopColumn = 7
         End
         Begin Table = "t_File"
            Begin Extent = 
               Top = 0
               Left = 74
               Bottom = 115
               Right = 248
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "t_ONK_SL"
            Begin Extent = 
               Top = 117
               Left = 19
               Bottom = 232
               Right = 194
          ', 'SCHEMA', N'dbo', 'VIEW', N'View_3', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_DiagramPane2', N'  End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "t_ONK_USL"
            Begin Extent = 
               Top = 244
               Left = 17
               Bottom = 359
               Right = 221
            End
            DisplayFlags = 280
            TopColumn = 4
         End
         Begin Table = "vw_sprT001_Report"
            Begin Extent = 
               Top = 202
               Left = 1004
               Bottom = 317
               Right = 1178
            End
            DisplayFlags = 280
            TopColumn = 1
         End
         Begin Table = "sprN014 (oms_nsi.dbo)"
            Begin Extent = 
               Top = 243
               Left = 811
               Bottom = 358
               Right = 985
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
      Begin ColumnWidths = 24
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
         Width = 937
         Width = 1358
         Width = 571
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
