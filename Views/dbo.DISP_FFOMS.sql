SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE VIEW dbo.DISP_FFOMS
AS
SELECT     dbo.t_File.DateRegistration, dbo.t_RegistersAccounts.ReportMonth, dbo.t_RegistersAccounts.ReportYear, dbo.t_RegistersAccounts.rf_idSMO, 
                      dbo.t_RegistersAccounts.Letter, dbo.t_Case.Age, dbo.t_Case.IsSpecialCase, dbo.t_RegisterPatient.Sex, dbo.t_RegisterPatient.BirthDay, 
                      dbo.t_RecordCasePatient.idRecord, dbo.t_Case.DateBegin, dbo.t_Case.DateEnd, dbo.t_Case.rf_idMO, dbo.t_RegistersAccounts.DateRegister, 
                      dbo.t_RegistersAccounts.Account, CASE WHEN (Letter = 'O') THEN 'ДВ1' ELSE 'ОПВ' END AS DISP, CASE WHEN (Letter = '”O”') 
                      THEN 4 ELSE 5 END AS C_POKL, dbo.t_Case.AmountPayment - ExchangeFinancing.dbo.View_LN_EKS.Eks AS Expr1, dbo.t_Case_PID_ENP.ENP, 
                      dbo.t_Case_PID_ENP.PID, dbo.t_Case.id, dbo.t_Case.GUID_Case, ExchangeFinancing.dbo.View_LN_EKS.Eks, dbo.t_Case.AmountPayment
FROM         ExchangeFinancing.dbo.View_LN_EKS INNER JOIN
                      dbo.t_Case INNER JOIN
                      dbo.t_RecordCasePatient ON dbo.t_Case.rf_idRecordCasePatient = dbo.t_RecordCasePatient.id INNER JOIN
                      dbo.t_RegistersAccounts ON dbo.t_RecordCasePatient.rf_idRegistersAccounts = dbo.t_RegistersAccounts.id INNER JOIN
                      dbo.t_File ON dbo.t_RegistersAccounts.rf_idFiles = dbo.t_File.id INNER JOIN
                      dbo.t_RegisterPatient ON dbo.t_RecordCasePatient.id = dbo.t_RegisterPatient.rf_idRecordCase ON 
                      ExchangeFinancing.dbo.View_LN_EKS.rf_idCase = dbo.t_Case.id LEFT OUTER JOIN
                      dbo.t_Case_PID_ENP ON dbo.t_Case.id = dbo.t_Case_PID_ENP.rf_idCase
WHERE     (dbo.t_File.DateRegistration BETWEEN CONVERT(DATETIME, '2016-01-01 00:00:00', 102) AND CONVERT(DATETIME, '2016-05-31 00:00:00', 102)) AND 
                      (dbo.t_RegistersAccounts.rf_idSMO <> '34') AND (dbo.t_RegistersAccounts.ReportMonth BETWEEN 1 AND 3) AND (dbo.t_RegistersAccounts.Letter = 'O')
                       AND (dbo.t_RegistersAccounts.ReportYear = 2016) AND (dbo.t_Case.IsSpecialCase = 3) AND 
                      (dbo.t_Case.AmountPayment - ExchangeFinancing.dbo.View_LN_EKS.Eks > 0) OR
                      (dbo.t_File.DateRegistration BETWEEN CONVERT(DATETIME, '2016-01-01 00:00:00', 102) AND CONVERT(DATETIME, '2016-05-31 00:00:00', 102)) AND 
                      (dbo.t_RegistersAccounts.rf_idSMO <> '34') AND (dbo.t_RegistersAccounts.ReportMonth BETWEEN 1 AND 3) AND (dbo.t_RegistersAccounts.Letter = 'R')
                       AND (dbo.t_RegistersAccounts.ReportYear = 2016) AND (dbo.t_Case.AmountPayment - ExchangeFinancing.dbo.View_LN_EKS.Eks > 0)
GO
GRANT SELECT ON  [dbo].[DISP_FFOMS] TO [db_AccountOMS]
GO
EXEC sp_addextendedproperty N'MS_DiagramPane1', N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[35] 4[4] 2[41] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1[50] 4[25] 3) )"
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
               Top = 9
               Left = 696
               Bottom = 117
               Right = 892
            End
            DisplayFlags = 280
            TopColumn = 18
         End
         Begin Table = "t_RecordCasePatient"
            Begin Extent = 
               Top = 4
               Left = 345
               Bottom = 112
               Right = 538
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "t_RegistersAccounts"
            Begin Extent = 
               Top = 133
               Left = 161
               Bottom = 241
               Right = 362
            End
            DisplayFlags = 280
            TopColumn = 17
         End
         Begin Table = "t_File"
            Begin Extent = 
               Top = 11
               Left = 5
               Bottom = 119
               Right = 168
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "t_RegisterPatient"
            Begin Extent = 
               Top = 136
               Left = 612
               Bottom = 244
               Right = 774
            End
            DisplayFlags = 280
            TopColumn = 7
         End
         Begin Table = "t_Case_PID_ENP"
            Begin Extent = 
               Top = 6
               Left = 930
               Bottom = 114
               Right = 1105
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "View_LN_EKS (ExchangeFinancing.dbo)"
            Begin Extent = 
               Top = 154
               Left = 885
               Bottom = 232
          ', 'SCHEMA', N'dbo', 'VIEW', N'DISP_FFOMS', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_DiagramPane2', N'     Right = 1152
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
         Column = 8175
         Alias = 900
         Table = 2895
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 570
         GroupBy = 1350
         Filter = 3180
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
', 'SCHEMA', N'dbo', 'VIEW', N'DISP_FFOMS', NULL, NULL
GO
DECLARE @xp int
SELECT @xp=2
EXEC sp_addextendedproperty N'MS_DiagramPaneCount', @xp, 'SCHEMA', N'dbo', 'VIEW', N'DISP_FFOMS', NULL, NULL
GO
