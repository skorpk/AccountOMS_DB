SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
/****** Script for SelectTopNRows command from SSMS  ******/
CREATE VIEW dbo.vw_testAccounts
AS
SELECT TOP (10) f.id, f.DateRegistration AS ДатаРегистрации, f.CodeM AS КодМО, mo.Наименование AS МО, ra.ReportYear AS ОтчетныйГод, 
               ra.ReportMonth AS ОтчетныйМесяц, ra.DateRegister AS ДатаСчета, ra.AmountPayment AS Выставлено, ra.PrefixNumberRegister + '-' + CONVERT(varchar, 
               ra.NumberRegister) + '-' + CONVERT(varchar, ra.NumberRegister) + ISNULL(ra.Letter, '') AS НомерСчета, ra.rf_idSMO AS КодСМО, 
               smo.[Наименование краткое] AS СМО
FROM  dbo.t_File AS f INNER JOIN
               dbo.t_RegistersAccounts AS ra ON ra.rf_idFiles = f.id INNER JOIN
               OMS_NSI.dbo.V_sprMO AS mo ON f.CodeM = mo.Код INNER JOIN
               OMS_NSI.dbo.V_SMO AS smo ON ra.rf_idSMO = smo.[Код СМО]
GO
GRANT SELECT ON  [dbo].[vw_testAccounts] TO [db_AccountOMS]
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
         Begin Table = "f"
            Begin Extent = 
               Top = 7
               Left = 48
               Bottom = 148
               Right = 237
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ra"
            Begin Extent = 
               Top = 7
               Left = 285
               Bottom = 148
               Right = 520
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "mo"
            Begin Extent = 
               Top = 7
               Left = 568
               Bottom = 130
               Right = 752
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "smo"
            Begin Extent = 
               Top = 7
               Left = 800
               Bottom = 148
               Right = 1031
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
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
', 'SCHEMA', N'dbo', 'VIEW', N'vw_testAccounts', NULL, NULL
GO
DECLARE @xp int
SELECT @xp=1
EXEC sp_addextendedproperty N'MS_DiagramPaneCount', @xp, 'SCHEMA', N'dbo', 'VIEW', N'vw_testAccounts', NULL, NULL
GO
