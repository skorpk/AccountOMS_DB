SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE VIEW dbo.View_XPNL
AS
SELECT     dbo.t_File.DateRegistration, dbo.t_RegistersAccounts.rf_idSMO, dbo.View_CaseEks.Stoim, dbo.t_RegistersAccounts.ReportYear, 
                      dbo.t_RegistersAccounts.ReportMonth, dbo.t_MES.MES, dbo.View_CaseEks.rf_idV006, dbo.t_Case_PID_ENP.ENP, dbo.t_Case_PID_ENP.PID, 
                      dbo.t_RegisterPatient.Fam, dbo.t_RegisterPatient.Im, dbo.t_RegisterPatient.Ot, dbo.t_RegisterPatient.BirthDay
FROM         dbo.t_Case_PID_ENP INNER JOIN
                      dbo.View_CaseEks ON dbo.t_Case_PID_ENP.rf_idCase = dbo.View_CaseEks.id INNER JOIN
                      dbo.t_MES ON dbo.View_CaseEks.id = dbo.t_MES.rf_idCase INNER JOIN
                      dbo.t_File INNER JOIN
                      dbo.t_RegistersAccounts ON dbo.t_File.id = dbo.t_RegistersAccounts.rf_idFiles INNER JOIN
                      dbo.t_RecordCasePatient ON dbo.t_RegistersAccounts.id = dbo.t_RecordCasePatient.rf_idRegistersAccounts ON 
                      dbo.View_CaseEks.rf_idRecordCasePatient = dbo.t_RecordCasePatient.id INNER JOIN
                      dbo.t_RegisterPatient ON dbo.t_File.id = dbo.t_RegisterPatient.rf_idFiles AND 
                      dbo.t_RecordCasePatient.id = dbo.t_RegisterPatient.rf_idRecordCase
WHERE     (dbo.t_File.DateRegistration BETWEEN CONVERT(DATETIME, '2016-01-01 00:00:00', 102) AND CONVERT(DATETIME, '2017-01-20 00:00:00', 102)) AND 
                      (dbo.t_RegistersAccounts.rf_idSMO <> '34') AND (dbo.View_CaseEks.Stoim > 0) AND (dbo.t_RegistersAccounts.ReportYear = 2016) AND 
                      (dbo.View_CaseEks.rf_idV006 = 1 OR
                      dbo.View_CaseEks.rf_idV006 = 2) AND (dbo.t_MES.MES LIKE '%916' OR
                      dbo.t_MES.MES LIKE '%917' OR
                      dbo.t_MES.MES LIKE '%918' OR
                      dbo.t_MES.MES LIKE '%901' OR
                      dbo.t_MES.MES LIKE '%902' OR
                      dbo.t_MES.MES LIKE '%905') OR
                      (dbo.t_File.DateRegistration BETWEEN CONVERT(DATETIME, '2017-01-01 00:00:00', 102) AND CONVERT(DATETIME, '2017-06-23 00:00:00', 102)) AND 
                      (dbo.t_RegistersAccounts.rf_idSMO <> '34') AND (dbo.View_CaseEks.Stoim > 0) AND (dbo.t_RegistersAccounts.ReportYear = 2017) AND 
                      (dbo.t_RegistersAccounts.ReportMonth IN (1, 2, 3)) AND (dbo.View_CaseEks.rf_idV006 = 1 OR
                      dbo.View_CaseEks.rf_idV006 = 2) AND (dbo.t_MES.MES LIKE '%916' OR
                      dbo.t_MES.MES LIKE '%917' OR
                      dbo.t_MES.MES LIKE '%918' OR
                      dbo.t_MES.MES LIKE '%901' OR
                      dbo.t_MES.MES LIKE '%902' OR
                      dbo.t_MES.MES LIKE '%905')
GO
EXEC sp_addextendedproperty N'MS_DiagramPane1', N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[22] 4[27] 2[36] 3) )"
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
         Left = -192
      End
      Begin Tables = 
         Begin Table = "t_File"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 196
               Right = 201
            End
            DisplayFlags = 280
            TopColumn = 2
         End
         Begin Table = "t_RegistersAccounts"
            Begin Extent = 
               Top = 6
               Left = 239
               Bottom = 215
               Right = 440
            End
            DisplayFlags = 280
            TopColumn = 4
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
         Begin Table = "t_MES"
            Begin Extent = 
               Top = 161
               Left = 533
               Bottom = 269
               Right = 686
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "t_Case_PID_ENP"
            Begin Extent = 
               Top = 85
               Left = 1132
               Bottom = 193
               Right = 1285
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "t_RegisterPatient"
            Begin Extent = 
               Top = 266
               Left = 215
               Bottom = 374
               Right = 377
            End
            DisplayFlags = 280
            TopColumn = 6
         End
         Begin Table = "View_CaseEks"
            Begin Extent = 
               Top = 14
               Left = 809
               Bottom = 263
               Right = 1005
 ', 'SCHEMA', N'dbo', 'VIEW', N'View_XPNL', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_DiagramPane2', N'           End
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
         Filter = 3435
         Or = 6435
         Or = 1350
         Or = 1350
      End
   End
End
', 'SCHEMA', N'dbo', 'VIEW', N'View_XPNL', NULL, NULL
GO
DECLARE @xp int
SELECT @xp=2
EXEC sp_addextendedproperty N'MS_DiagramPaneCount', @xp, 'SCHEMA', N'dbo', 'VIEW', N'View_XPNL', NULL, NULL
GO
