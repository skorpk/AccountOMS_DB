SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE VIEW [dbo].[vw_PEOPLE]
AS
SELECT        FAM, IM, OT, W, DR, DRA, MR, DS, SS, DOCTP, DOCS, DOCN, DOCDT, DOCORG, CN, SUBJ, RN, INDX, RNNAME, CITY, NP, UL, DOM, KOR, KV, DMJ, BOMJ, PSUBJ, PRN, PINDX, PRNNAME, PCITY, PNP, PUL, PDOM, PKOR, PKV, 
                         PDMJ, RDOCTP, RDOCS, RDOCN, RDOCDT, RDOCORG, RDOCEND, EMAIL, Q, PRZ, SPOL, NPOL, ENP, OPDOC, OKATO, DHPOL, DBEG, DEND, PETITION, LPU, LPUWK, LPUST, LPUUCH, SP, KT, OKVED, KLADRS, ZFAM, ZIM, 
                         ZOT, ZT, ZDR, ZMR, ZDOCTP, ZDOCS, ZDOCN, ZDOCDT, ZDOCORG, ZADDR, ID, PID, ZID, DEDIT, DERP, UNEMP, PHONE, QOGRN, DSTOP, ZPHONE, EXTID, ZENP, DENP, ERP, ZERR, DVIZ, METH, OPSMO, OPPOL, POLPR, 
                         POLVID, POLISID, PFRSS, RSTOP, DAKT, NAKT, TAKT, DEL, DZP1, ZP1REPL, OLDENP, TENP, SENP, PHOTO, PTYPE, DRT, FIOPR, CONTACT, NORD, DORD, SIGNAT, KLADRG, KLADRP, DZ, FORCE, BID, MID, OTHER, LPUDT, 
                         LPUAUTO, LPUDX, PZ_SCAN, FAME, IME, OTE, SSOLD, DOCEND, DSTOP_CS, DOST, BIRTH_OKSM, KATEG, ISEXPORTED, EXPORTERROR, REMARK, LPUERR, LPUDSEND, SS_DOCTOR, LPU_CONF, SS_FELDSHER, 
                         LPUDT_DOC, LPUDT_FEL, ERR_M, ERR_G, LPUTYPE, FIAS_AOID, FIAS_HOUSEID, PFIAS_AOID, PFIAS_HOUSEID, FIAS_AOGUID, FIAS_HOUSEGUID, PFIAS_AOGUID, PFIAS_HOUSEGUID, TRUESS, VS_FORM
FROM            PolicyRegister.dbo.PEOPLE
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
         Begin Table = "PEOPLE (PolicyRegister.dbo)"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 227
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
', 'SCHEMA', N'dbo', 'VIEW', N'vw_PEOPLE', NULL, NULL
GO
DECLARE @xp int
SELECT @xp=1
EXEC sp_addextendedproperty N'MS_DiagramPaneCount', @xp, 'SCHEMA', N'dbo', 'VIEW', N'vw_PEOPLE', NULL, NULL
GO
