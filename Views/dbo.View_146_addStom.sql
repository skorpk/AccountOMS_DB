SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE VIEW dbo.View_146_addStom
AS
SELECT     dbo.t_RegistersAccounts.ReportMonth, dbo.t_RegistersAccounts.ReportYear, dbo.t_File.DateRegistration, dbo.t_RegisterPatient.Fam, 
                      dbo.t_RegisterPatient.Im, dbo.t_RegisterPatient.Ot, dbo.t_RegisterPatient.BirthDay, dbo.View_146_4.MUGroupCode, dbo.View_146_4.MUUnGroupCode,
                       dbo.View_146_4.MUCode, dbo.View_146_4.Quantity, dbo.View_146_4.Price, dbo.t_RegistersAccounts.rf_idSMO, dbo.t_Case.rf_idMO, dbo.t_Case.id, 
                      dbo.t_Case.Age, dbo.t_RecordCasePatient.NewBorn, dbo.t_Case.AmountPayment, dbo.t_RegisterPatientAttendant.Fam AS F_s, 
                      dbo.t_RegisterPatientAttendant.Im AS I_s, dbo.t_RegisterPatientAttendant.Ot AS O_s, dbo.t_RegisterPatientAttendant.BirthDay AS DR_s, 
                      dbo.View_146_4.MUInt, dbo.t_Case.rf_idV008, dbo.t_Case.rf_idV006, 1 AS VMP_K, dbo.View_146_1.Tariff, dbo.t_RegistersAccounts.Letter, 
                      dbo.View_146_4.MUSurgery, 'УЕТ' AS UE, dbo.View_146_1.MES, dbo.View_146_4.ADULTUET, dbo.View_146_4.ChildUET
FROM         dbo.t_RegistersAccounts INNER JOIN
                      dbo.t_RecordCasePatient ON dbo.t_RegistersAccounts.id = dbo.t_RecordCasePatient.rf_idRegistersAccounts INNER JOIN
                      dbo.t_Case ON dbo.t_RecordCasePatient.id = dbo.t_Case.rf_idRecordCasePatient INNER JOIN
                      dbo.t_RegisterPatient ON dbo.t_RecordCasePatient.id = dbo.t_RegisterPatient.rf_idRecordCase INNER JOIN
                      dbo.t_File ON dbo.t_RegistersAccounts.rf_idFiles = dbo.t_File.id INNER JOIN
                      dbo.View_146_4 ON dbo.t_Case.id = dbo.View_146_4.rf_idCase LEFT OUTER JOIN
                      dbo.View_146_1 ON dbo.t_Case.id = dbo.View_146_1.rf_idCase LEFT OUTER JOIN
                      dbo.t_RegisterPatientAttendant ON dbo.t_RegisterPatient.id = dbo.t_RegisterPatientAttendant.rf_idRegisterPatient
WHERE     (dbo.t_RegistersAccounts.ReportYear = 2016) AND (dbo.t_File.DateRegistration BETWEEN CONVERT(DATETIME, '2016-01-01 00:00:00', 102) AND 
                      CONVERT(DATETIME, '2017-01-20 00:00:00', 102)) AND (dbo.t_RegistersAccounts.ReportMonth > 7) AND (dbo.t_RegistersAccounts.Letter = 'T') AND 
                      (dbo.View_146_4.MUGroupCode <> 57) AND (dbo.View_146_4.MUGroupCode <> 2)
GO
GRANT SELECT ON  [dbo].[View_146_addStom] TO [db_AccountOMS]
GO
EXEC sp_addextendedproperty N'MS_DiagramPane1', N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[41] 4[29] 2[12] 3) )"
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
               Top = 6
               Left = 239
               Bottom = 121
               Right = 439
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "t_RecordCasePatient"
            Begin Extent = 
               Top = 6
               Left = 477
               Bottom = 121
               Right = 669
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "t_Case"
            Begin Extent = 
               Top = 6
               Left = 707
               Bottom = 121
               Right = 902
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "t_RegisterPatient"
            Begin Extent = 
               Top = 6
               Left = 940
               Bottom = 121
               Right = 1101
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "t_File"
            Begin Extent = 
               Top = 126
               Left = 38
               Bottom = 241
               Right = 200
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "View_146_4"
            Begin Extent = 
               Top = 112
               Left = 810
               Bottom = 227
               Right = 973
            End
            DisplayFlags = 280
            TopColumn = 1
         End
         Begin Table = "View_146_1"
            Begin Extent = 
               Top = 126
               Left = 238
               Bottom = 226
               Right = 399
           ', 'SCHEMA', N'dbo', 'VIEW', N'View_146_addStom', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_DiagramPane2', N' End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "t_RegisterPatientAttendant"
            Begin Extent = 
               Top = 126
               Left = 437
               Bottom = 241
               Right = 614
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
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 7050
         Alias = 900
         Table = 2115
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 3225
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
', 'SCHEMA', N'dbo', 'VIEW', N'View_146_addStom', NULL, NULL
GO
DECLARE @xp int
SELECT @xp=2
EXEC sp_addextendedproperty N'MS_DiagramPaneCount', @xp, 'SCHEMA', N'dbo', 'VIEW', N'View_146_addStom', NULL, NULL
GO
