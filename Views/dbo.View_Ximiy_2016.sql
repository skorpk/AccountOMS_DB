SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE VIEW dbo.View_Ximiy_2016
AS
SELECT     dbo.t_File.DateRegistration, dbo.t_RegistersAccounts.ReportYear, dbo.View_CaseEks.rf_idMO, dbo.vw_sprT001.NAMES, 
                      dbo.t_RegistersAccounts.rf_idSMO, dbo.View_CaseEks.rf_idV006, dbo.t_MES.MES, dbo.View_CaseEks.rf_idV008, dbo.V_OsnD_LN.DS, 
                      dbo.V_OsnD_LN.Diagnosis, dbo.View_CaseEks.DateBegin, dbo.View_CaseEks.DateEnd, dbo.View_CaseEks.id, dbo.View_CaseEks.Stoim, 
                      dbo.t_RegisterPatient.Fam, dbo.t_RegisterPatient.Im, dbo.t_RegisterPatient.Ot, dbo.t_RegisterPatient.BirthDay, dbo.t_Case_PID_ENP.PID, 
                      dbo.t_Case_PID_ENP.ENP
FROM         dbo.View_CaseEks INNER JOIN
                      dbo.t_RegistersAccounts INNER JOIN
                      dbo.t_File ON dbo.t_RegistersAccounts.rf_idFiles = dbo.t_File.id INNER JOIN
                      dbo.t_RecordCasePatient ON dbo.t_RegistersAccounts.id = dbo.t_RecordCasePatient.rf_idRegistersAccounts ON 
                      dbo.View_CaseEks.rf_idRecordCasePatient = dbo.t_RecordCasePatient.id INNER JOIN
                      dbo.t_MES ON dbo.View_CaseEks.id = dbo.t_MES.rf_idCase INNER JOIN
                      dbo.V_OsnD_LN ON dbo.View_CaseEks.id = dbo.V_OsnD_LN.rf_idCase INNER JOIN
                      dbo.vw_sprT001 ON dbo.View_CaseEks.rf_idMO = dbo.vw_sprT001.CodeM INNER JOIN
                      dbo.t_RegisterPatient ON dbo.t_File.id = dbo.t_RegisterPatient.rf_idFiles AND 
                      dbo.t_RecordCasePatient.id = dbo.t_RegisterPatient.rf_idRecordCase INNER JOIN
                      dbo.t_Case_PID_ENP ON dbo.View_CaseEks.id = dbo.t_Case_PID_ENP.rf_idCase
WHERE     (dbo.t_File.DateRegistration BETWEEN CONVERT(DATETIME, '2016-01-01 00:00:00', 102) AND CONVERT(DATETIME, '2017-06-28 00:00:00', 102)) AND 
                      (dbo.t_RegistersAccounts.ReportYear = 2016) AND (dbo.t_RegistersAccounts.rf_idSMO <> '34') AND (dbo.t_MES.MES LIKE '%141' OR
                      dbo.t_MES.MES LIKE '%142') AND (dbo.View_CaseEks.rf_idV006 = 1) AND (dbo.View_CaseEks.rf_idV008 = 31 OR
                      dbo.View_CaseEks.rf_idV008 = 3) AND (dbo.View_CaseEks.Stoim > 0) OR
                      (dbo.t_File.DateRegistration BETWEEN CONVERT(DATETIME, '2016-01-01 00:00:00', 102) AND CONVERT(DATETIME, '2017-06-28 00:00:00', 102)) AND 
                      (dbo.t_RegistersAccounts.ReportYear = 2016) AND (dbo.t_RegistersAccounts.rf_idSMO <> '34') AND (dbo.t_MES.MES LIKE '%044' OR
                      dbo.t_MES.MES LIKE '%045' OR
                      dbo.t_MES.MES LIKE '%046') AND (dbo.View_CaseEks.rf_idV006 = 2) AND (dbo.View_CaseEks.Stoim > 0)
GO
EXEC sp_addextendedproperty N'MS_DiagramPane1', N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[31] 4[42] 2[12] 3) )"
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
         Begin Table = "View_CaseEks"
            Begin Extent = 
               Top = 9
               Left = 600
               Bottom = 117
               Right = 796
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "t_RegistersAccounts"
            Begin Extent = 
               Top = 7
               Left = 198
               Bottom = 230
               Right = 340
            End
            DisplayFlags = 280
            TopColumn = 1
         End
         Begin Table = "t_File"
            Begin Extent = 
               Top = 7
               Left = 5
               Bottom = 115
               Right = 168
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "t_RecordCasePatient"
            Begin Extent = 
               Top = 8
               Left = 384
               Bottom = 163
               Right = 577
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "t_MES"
            Begin Extent = 
               Top = 12
               Left = 871
               Bottom = 120
               Right = 1024
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "V_OsnD_LN"
            Begin Extent = 
               Top = 138
               Left = 969
               Bottom = 246
               Right = 1083
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "vw_sprT001"
            Begin Extent = 
               Top = 183
               Left = 735
               Bottom = 291
               Right = 888
            End
  ', 'SCHEMA', N'dbo', 'VIEW', N'View_Ximiy_2016', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_DiagramPane2', N'          DisplayFlags = 280
            TopColumn = 1
         End
         Begin Table = "t_RegisterPatient"
            Begin Extent = 
               Top = 184
               Left = 417
               Bottom = 292
               Right = 579
            End
            DisplayFlags = 280
            TopColumn = 6
         End
         Begin Table = "t_Case_PID_ENP"
            Begin Extent = 
               Top = 188
               Left = 24
               Bottom = 296
               Right = 177
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
         Alias = 1260
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 2145
         Or = 5940
         Or = 1350
         Or = 1350
      End
   End
End
', 'SCHEMA', N'dbo', 'VIEW', N'View_Ximiy_2016', NULL, NULL
GO
DECLARE @xp int
SELECT @xp=2
EXEC sp_addextendedproperty N'MS_DiagramPaneCount', @xp, 'SCHEMA', N'dbo', 'VIEW', N'View_Ximiy_2016', NULL, NULL
GO
