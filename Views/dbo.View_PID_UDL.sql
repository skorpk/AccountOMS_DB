SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE VIEW dbo.View_PID_UDL
AS
SELECT     dbo.t_Case_PID_ENP.PID, dbo.t_Case_PID_ENP.ENP, dbo.t_RegisterPatientDocument.rf_idDocumentType, 
                      dbo.t_RegisterPatientDocument.SeriaDocument, dbo.t_RegisterPatientDocument.NumberDocument, dbo.t_RegisterPatientDocument.SNILS, 
                      dbo.t_Case.DateEnd, dbo.t_Case.Age
FROM         dbo.t_Case INNER JOIN
                      dbo.t_RecordCasePatient ON dbo.t_Case.rf_idRecordCasePatient = dbo.t_RecordCasePatient.id INNER JOIN
                      dbo.t_RegisterPatientDocument INNER JOIN
                      dbo.t_RegisterPatient ON dbo.t_RegisterPatientDocument.rf_idRegisterPatient = dbo.t_RegisterPatient.id ON 
                      dbo.t_RecordCasePatient.id = dbo.t_RegisterPatient.rf_idRecordCase INNER JOIN
                      dbo.t_Case_PID_ENP ON dbo.t_Case.id = dbo.t_Case_PID_ENP.rf_idCase
WHERE     (NOT (dbo.t_Case_PID_ENP.PID IS NULL))
GO
GRANT SELECT ON  [dbo].[View_PID_UDL] TO [db_AccountOMS]
GO
EXEC sp_addextendedproperty N'MS_DiagramPane1', N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
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
         Begin Table = "t_Case"
            Begin Extent = 
               Top = 39
               Left = 71
               Bottom = 147
               Right = 265
            End
            DisplayFlags = 280
            TopColumn = 25
         End
         Begin Table = "t_RegisterPatient"
            Begin Extent = 
               Top = 29
               Left = 575
               Bottom = 137
               Right = 735
            End
            DisplayFlags = 280
            TopColumn = 7
         End
         Begin Table = "t_RegisterPatientDocument"
            Begin Extent = 
               Top = 23
               Left = 789
               Bottom = 131
               Right = 965
            End
            DisplayFlags = 280
            TopColumn = 2
         End
         Begin Table = "t_RecordCasePatient"
            Begin Extent = 
               Top = 9
               Left = 328
               Bottom = 117
               Right = 519
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "t_Case_PID_ENP"
            Begin Extent = 
               Top = 132
               Left = 303
               Bottom = 240
               Right = 454
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
         O', 'SCHEMA', N'dbo', 'VIEW', N'View_PID_UDL', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_DiagramPane2', N'r = 1350
         Or = 1350
         Or = 1350
      End
   End
End
', 'SCHEMA', N'dbo', 'VIEW', N'View_PID_UDL', NULL, NULL
GO
DECLARE @xp int
SELECT @xp=2
EXEC sp_addextendedproperty N'MS_DiagramPaneCount', @xp, 'SCHEMA', N'dbo', 'VIEW', N'View_PID_UDL', NULL, NULL
GO
