SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE VIEW dbo.View_146
AS
SELECT     dbo.t_RegistersAccounts.ReportMonth, dbo.t_RegistersAccounts.ReportYear, dbo.t_File.DateRegistration, dbo.t_RegisterPatient.Fam, 
                      dbo.t_RegisterPatient.Im, dbo.t_RegisterPatient.Ot, dbo.t_RegisterPatient.BirthDay, dbo.View_146_3.MUGroupCode, dbo.View_146_3.MUUnGroupCode,
                       dbo.View_146_3.MUCode, CASE WHEN (dbo.t_Case.rf_idv006 = 1 OR
                      dbo.t_Case.rf_idv006 = 2) AND (dbo.View_146_3.MUGROUPCODE = 0) THEN 0 ELSE dbo.View_146_3.Quantity END AS Quantity, dbo.View_146_3.Price, 
                      dbo.t_RegistersAccounts.rf_idSMO, dbo.t_Case.rf_idMO, dbo.t_Case.id, dbo.t_Case.Age, dbo.t_RecordCasePatient.NewBorn, 
                      dbo.t_Case.AmountPayment, dbo.t_RegisterPatientAttendant.Fam AS F_s, dbo.t_RegisterPatientAttendant.Im AS I_s, 
                      dbo.t_RegisterPatientAttendant.Ot AS O_s, dbo.t_RegisterPatientAttendant.BirthDay AS DR_s, dbo.View_146_3.MUInt, dbo.t_Case.rf_idV008, 
                      dbo.t_Case.rf_idV006, CASE WHEN ((dbo.View_146_3.MUGROUPCODE = 2 AND rf_IdV008 IN (1, 11, 12)) OR
                      (MUInt = 5501003) OR
                      (dbo.View_146_3.MUGROUPCODE = 57)) THEN '1' ELSE CASE WHEN (rf_idV006 = 4) THEN '2' ELSE '3' END END AS VMP_K, dbo.View_146_1.Tariff, 
                      dbo.t_RegistersAccounts.Letter, dbo.View_146_3.MUSurgery, CASE WHEN (dbo.View_146_3.MUGROUPCODE = 57) 
                      THEN 'УЕТ' ELSE CASE WHEN (dbo.View_146_3.MUGROUPCODE = 71) 
                      THEN 'вызов СМП' ELSE CASE WHEN ((dbo.View_146_3.MUGROUPCODE = 60 OR
                      dbo.View_146_3.MUGROUPCODE = 4) AND (dbo.t_RegistersAccounts.Letter = 'K')) 
                      THEN 'отдельные услуги ' ELSE CASE WHEN (dbo.View_146_3.MUGROUPCODE = 2 AND dbo.View_146_3.MUUNGROUPCODE <> 90 AND 
                      dbo.View_146_3.MUUNGROUPCODE <> 4 AND dbo.t_RegistersAccounts.Letter <> 'T') 
                      THEN 'врачебные приемы' ELSE CASE WHEN (dbo.t_Case.rf_idv006 = 1 AND (dbo.View_146_3.MUGROUPCODE = 1 OR
                      dbo.View_146_3.MUGROUPCODE = 0)) THEN 'койко-день ' ELSE CASE WHEN (dbo.t_Case.rf_idv006 = 2 AND 
                      (dbo.View_146_3.MUGROUPCODE = 55 OR
                      dbo.View_146_3.MUGROUPCODE = 0)) THEN 'пациенто-день' ELSE 'остатки ' END END END END END END AS UE, dbo.View_146_1.MES, 
                      dbo.View_146_3.ADULTUET, dbo.View_146_3.ChildUET
FROM         dbo.View_146_3 INNER JOIN
                      dbo.t_RegistersAccounts INNER JOIN
                      dbo.t_RecordCasePatient ON dbo.t_RegistersAccounts.id = dbo.t_RecordCasePatient.rf_idRegistersAccounts INNER JOIN
                      dbo.t_Case ON dbo.t_RecordCasePatient.id = dbo.t_Case.rf_idRecordCasePatient INNER JOIN
                      dbo.t_RegisterPatient ON dbo.t_RecordCasePatient.id = dbo.t_RegisterPatient.rf_idRecordCase INNER JOIN
                      dbo.t_File ON dbo.t_RegistersAccounts.rf_idFiles = dbo.t_File.id ON dbo.View_146_3.rf_idCase = dbo.t_Case.id LEFT OUTER JOIN
                      dbo.View_146_1 ON dbo.t_Case.id = dbo.View_146_1.rf_idCase LEFT OUTER JOIN
                      dbo.t_RegisterPatientAttendant ON dbo.t_RegisterPatient.id = dbo.t_RegisterPatientAttendant.rf_idRegisterPatient
WHERE     (dbo.t_RegistersAccounts.ReportYear = 2016) AND (dbo.t_File.DateRegistration BETWEEN CONVERT(DATETIME, '2016-01-01 00:00:00', 102) AND 
                      CONVERT(DATETIME, '2017-01-20 00:00:00', 102)) AND (dbo.t_RegistersAccounts.ReportMonth BETWEEN 1 AND 12) AND 
                      (dbo.View_146_3.MUGroupCode = 57) OR
                      (dbo.t_RegistersAccounts.ReportYear = 2016) AND (dbo.t_File.DateRegistration BETWEEN CONVERT(DATETIME, '2016-01-01 00:00:00', 102) AND 
                      CONVERT(DATETIME, '2017-01-20 00:00:00', 102)) AND (dbo.t_RegistersAccounts.ReportMonth BETWEEN 1 AND 12) AND 
                      (dbo.View_146_3.MUGroupCode = 2) AND (dbo.t_RegistersAccounts.Letter <> 'T') AND (dbo.t_RegistersAccounts.Letter <> 'K') AND 
                      (dbo.View_146_3.MUUnGroupCode <> 90) AND (dbo.View_146_3.MUInt <> 204001) OR
                      (dbo.t_RegistersAccounts.ReportYear = 2016) AND (dbo.t_File.DateRegistration BETWEEN CONVERT(DATETIME, '2016-01-01 00:00:00', 102) AND 
                      CONVERT(DATETIME, '2017-01-20 00:00:00', 102)) AND (dbo.t_RegistersAccounts.ReportMonth BETWEEN 1 AND 12) AND (dbo.t_Case.rf_idV006 = 1) OR
                      (dbo.t_RegistersAccounts.ReportYear = 2016) AND (dbo.t_File.DateRegistration BETWEEN CONVERT(DATETIME, '2016-01-01 00:00:00', 102) AND 
                      CONVERT(DATETIME, '2017-01-20 00:00:00', 102)) AND (dbo.t_RegistersAccounts.ReportMonth BETWEEN 1 AND 12) AND 
                      (dbo.View_146_3.MUGroupCode = 60 OR
                      dbo.View_146_3.MUGroupCode = 4) AND (dbo.t_RegistersAccounts.Letter = 'K') OR
                      (dbo.t_RegistersAccounts.ReportYear = 2016) AND (dbo.t_File.DateRegistration BETWEEN CONVERT(DATETIME, '2016-01-01 00:00:00', 102) AND 
                      CONVERT(DATETIME, '2017-01-20 00:00:00', 102)) AND (dbo.t_RegistersAccounts.ReportMonth BETWEEN 1 AND 12) AND 
                      (dbo.View_146_3.MUGroupCode = 71) OR
                      (dbo.t_RegistersAccounts.ReportYear = 2016) AND (dbo.t_File.DateRegistration BETWEEN CONVERT(DATETIME, '2016-01-01 00:00:00', 102) AND 
                      CONVERT(DATETIME, '2017-01-20 00:00:00', 102)) AND (dbo.t_RegistersAccounts.ReportMonth BETWEEN 1 AND 12) AND (dbo.t_Case.rf_idV006 = 2)
GO
GRANT SELECT ON  [dbo].[View_146] TO [db_AccountOMS]
GO
EXEC sp_addextendedproperty N'MS_DiagramPane1', N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[21] 4[26] 2[53] 3) )"
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
         Left = -84
      End
      Begin Tables = 
         Begin Table = "View_146_3"
            Begin Extent = 
               Top = 56
               Left = 1024
               Bottom = 164
               Right = 1188
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "t_RegistersAccounts"
            Begin Extent = 
               Top = 24
               Left = 301
               Bottom = 132
               Right = 500
            End
            DisplayFlags = 280
            TopColumn = 17
         End
         Begin Table = "t_RecordCasePatient"
            Begin Extent = 
               Top = 152
               Left = 88
               Bottom = 260
               Right = 279
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "t_Case"
            Begin Extent = 
               Top = 44
               Left = 561
               Bottom = 152
               Right = 755
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "t_RegisterPatient"
            Begin Extent = 
               Top = 226
               Left = 359
               Bottom = 334
               Right = 519
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "t_File"
            Begin Extent = 
               Top = 24
               Left = 112
               Bottom = 132
               Right = 273
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "View_146_1"
            Begin Extent = 
               Top = 253
               Left = 1060
               Bottom = 361
               Right = 1213
 ', 'SCHEMA', N'dbo', 'VIEW', N'View_146', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_DiagramPane2', N'           End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "t_RegisterPatientAttendant"
            Begin Extent = 
               Top = 214
               Left = 599
               Bottom = 322
               Right = 775
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
      Begin ColumnWidths = 34
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
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
      Begin ColumnWidths = 14
         Column = 2115
         Alias = 900
         Table = 1725
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1695
         SortOrder = 1200
         GroupBy = 1350
         Filter = 3945
         Or = 6315
         Or = 4680
         Or = 3180
         Or = 3180
         Or = 3165
         Or = 3480
         Or = 1350
      End
   End
End
', 'SCHEMA', N'dbo', 'VIEW', N'View_146', NULL, NULL
GO
DECLARE @xp int
SELECT @xp=2
EXEC sp_addextendedproperty N'MS_DiagramPaneCount', @xp, 'SCHEMA', N'dbo', 'VIEW', N'View_146', NULL, NULL
GO
