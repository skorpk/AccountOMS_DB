SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
/* INNER JOIN
OMS_NSI.dbo.sprV006 AS v6 ON c.rf_idV006 = v6.Id INNER JOIN
OMS_NSI.dbo.sprV008 AS v8 ON c.rf_idV008 = v8.Id INNER JOIN
OMS_NSI.dbo.sprV002 AS v2 ON c.rf_idV002 = v2.Id INNER JOIN
OMS_NSI.dbo.sprV009 AS v9 ON c.rf_idV009 = v9.Id INNER JOIN
OMS_NSI.dbo.sprV012 AS v12 ON c.rf_idV012 = v12.Id INNER JOIN
OMS_NSI.dbo.sprMedicalSpeciality AS v4 ON c.rf_idV004 = v4.Id INNER JOIN
OMS_NSI.dbo.sprV010 AS v10 ON c.rf_idV010 = v10.Id INNER JOIN
OMS_NSI.dbo.sprV005 AS v5 ON rp.rf_idV005 = v5.Id INNER JOIN
dbo.t_RegisterPatientDocument AS rpd ON rpd.rf_idRegisterPatient = rp.id INNER JOIN
OMS_NSI.dbo.sprDocumentType AS dt ON rpd.rf_idDocumentType = dt.ID LEFT OUTER JOIN
dbo.vw_МОДляСлучаев AS dmo ON c.rf_idDirectMO = LEFT(dmo.tfomsCode, 6) LEFT OUTER JOIN
dbo.t_RegisterPatientAttendant AS rpa ON rpa.rf_idRegisterPatient = rp.id LEFT OUTER JOIN
dbo.vw_ОКАТОДляСлучаев AS okato1 ON okato1.ter + okato1.kod1 + okato1.kod2 + okato1.kod3 = rpd.OKATO LEFT OUTER JOIN
dbo.vw_ОКАТОДляСлучаев AS okato2 ON okato2.ter + okato2.kod1 + okato2.kod2 + okato2.kod3 = rpd.OKATO_Place*/
CREATE VIEW dbo.vw_Случаи
AS
SELECT c.id, rp.Fam + ' ' + rp.Im + ' ' + ISNULL(rp.Ot, '') AS Пациент, f.DateRegistration AS ДатаРегистрации, f.CodeM AS CodeMO, mo.FilialId AS CodeFilial
FROM  dbo.t_Case AS c INNER JOIN
               dbo.t_RecordCasePatient AS rcp ON c.rf_idRecordCasePatient = rcp.id INNER JOIN
               dbo.vw_СчетаДляСвязиСлучаев AS ra ON rcp.rf_idRegistersAccounts = ra.id INNER JOIN
               dbo.vw_ФайлыДляСлучаев AS f ON ra.rf_idFiles = f.id INNER JOIN
               dbo.vw_МОДляСлучаев AS mo ON f.CodeM = mo.CodeM INNER JOIN
               dbo.t_RegisterPatient AS rp ON rp.rf_idRecordCase = rcp.id
GO
GRANT SELECT ON  [dbo].[vw_Случаи] TO [db_AccountOMS]
GO
EXEC sp_addextendedproperty N'MS_DiagramPane1', N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[34] 4[4] 2[47] 3) )"
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
         Begin Table = "c"
            Begin Extent = 
               Top = 7
               Left = 48
               Bottom = 148
               Right = 276
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "rcp"
            Begin Extent = 
               Top = 7
               Left = 324
               Bottom = 148
               Right = 549
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ra"
            Begin Extent = 
               Top = 7
               Left = 597
               Bottom = 112
               Right = 781
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "f"
            Begin Extent = 
               Top = 7
               Left = 829
               Bottom = 130
               Right = 1018
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "mo"
            Begin Extent = 
               Top = 448
               Left = 512
               Bottom = 553
               Right = 696
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "rp"
            Begin Extent = 
               Top = 133
               Left = 1117
               Bottom = 274
               Right = 1306
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
         Table = 1176
 ', 'SCHEMA', N'dbo', 'VIEW', N'vw_Случаи', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_DiagramPane2', N'        Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1356
         SortOrder = 1416
         GroupBy = 1350
         Filter = 1356
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
', 'SCHEMA', N'dbo', 'VIEW', N'vw_Случаи', NULL, NULL
GO
DECLARE @xp int
SELECT @xp=2
EXEC sp_addextendedproperty N'MS_DiagramPaneCount', @xp, 'SCHEMA', N'dbo', 'VIEW', N'vw_Случаи', NULL, NULL
GO
