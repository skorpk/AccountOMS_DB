SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE VIEW [dbo].[Vw_Osn_CC_Eks]
AS
SELECT  dbo.t_File.DateRegistration, dbo.t_RegistersAccounts.ReportYear, dbo.t_RegistersAccounts.ReportMonth, dbo.t_RecordCasePatient.id, 
               dbo.t_CompletedCase.id AS rf_idCompletedCase, dbo.t_CompletedCase.AmountPayment - ISNULL(dbo.View_EKSSUPERNEW.Eks, 0) AS Stoim, 
               dbo.t_RegistersAccounts.rf_idSMO
FROM     dbo.t_RegistersAccounts INNER JOIN
               dbo.t_File ON dbo.t_RegistersAccounts.rf_idFiles = dbo.t_File.id INNER JOIN
               dbo.t_CompletedCase INNER JOIN
               dbo.t_RecordCasePatient ON dbo.t_CompletedCase.rf_idRecordCasePatient = dbo.t_RecordCasePatient.id ON 
               dbo.t_RegistersAccounts.id = dbo.t_RecordCasePatient.rf_idRegistersAccounts LEFT OUTER JOIN
               dbo.View_EKSSUPERNEW ON dbo.t_CompletedCase.id = dbo.View_EKSSUPERNEW.rf_idComletedCaseC
WHERE  (dbo.t_File.DateRegistration BETWEEN CONVERT(DATETIME, '2020-03-01 00:00:00', 102) AND CONVERT(DATETIME, '2020-10-31 00:00:00', 102)) AND 
               (dbo.t_RegistersAccounts.ReportYear = 2020) AND (dbo.t_RegistersAccounts.ReportMonth BETWEEN 7 AND 9) AND (dbo.t_RegistersAccounts.rf_idSMO <> '34')
GO
EXEC sp_addextendedproperty N'MS_DiagramPane1', N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[34] 4[29] 2[9] 3) )"
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
         Begin Table = "t_RegistersAccounts"
            Begin Extent = 
               Top = 0
               Left = 263
               Bottom = 272
               Right = 479
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "t_File"
            Begin Extent = 
               Top = 11
               Left = 21
               Bottom = 276
               Right = 195
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "t_CompletedCase"
            Begin Extent = 
               Top = 0
               Left = 787
               Bottom = 295
               Right = 995
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "t_RecordCasePatient"
            Begin Extent = 
               Top = 0
               Left = 542
               Bottom = 261
               Right = 748
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "View_EKSSUPERNEW"
            Begin Extent = 
               Top = 118
               Left = 1097
               Bottom = 201
               Right = 1287
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
         Column', 'SCHEMA', N'dbo', 'VIEW', N'Vw_Osn_CC_Eks', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_DiagramPane2', N' = 6725
         Alias = 1454
         Table = 2866
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1345
         SortOrder = 1413
         GroupBy = 1350
         Filter = 3858
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
', 'SCHEMA', N'dbo', 'VIEW', N'Vw_Osn_CC_Eks', NULL, NULL
GO
DECLARE @xp int
SELECT @xp=2
EXEC sp_addextendedproperty N'MS_DiagramPaneCount', @xp, 'SCHEMA', N'dbo', 'VIEW', N'Vw_Osn_CC_Eks', NULL, NULL
GO
