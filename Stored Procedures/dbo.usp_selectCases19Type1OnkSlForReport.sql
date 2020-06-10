SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[usp_selectCases19Type1OnkSlForReport]

@rf_idCase nvarchar(max)--='19258589'
as

--declare @query varchar(max)=
--'select [rf_idCase] OSL_rf_idCase
--    ,[DS1_T] OSL_DS1_T
--    ,n2.[DS_St]+'' (''+n2.[KOD_St]+'')'' OSL_STAD
--    ,n3.[KOD_T] OSL_ONK_T
--    ,n4.[KOD_N] OSL_ONK_N
--    ,n5.[KOD_M] OSL_ONK_M
--    ,case when osl.[IsMetastasis]=1 then ''Выявлены'' else ''Не выявлены'' end OSL_MTSTZ
--    ,[TotalDose] OSL_SOD
--    ,[K_FR] OSL_K_FR
--    ,[WEI] OSL_WEI
--    ,[HEI] OSL_HEI
--    ,[BSA] OSL_BSA
--FROM [AccountOMS].[dbo].[t_ONK_SL] osl
--inner join dbo.t_Case c on c.id=osl.rf_idCase
--left JOIN [oms_nsi].[dbo].[sprN002] n2 on n2.[ID_St]=osl.[rf_idN002] and c.DateEnd between n2.DateBeg and n2.DateEnd
--left JOIN [oms_nsi].[dbo].[sprN003] n3 on n3.[ID_T]=osl.[rf_idN003] and c.DateEnd between n3.DateBeg and n3.DateEnd
--left JOIN [oms_nsi].[dbo].[sprN004] n4 on n4.[ID_N]=osl.[rf_idN004] and c.DateEnd between n4.DateBeg and n4.DateEnd
--left JOIN [oms_nsi].[dbo].[sprN005] n5 on n5.[ID_M]=osl.[rf_idN005] and c.DateEnd between n5.DateBeg and n5.DateEnd

--where c.id in ('+@rf_idCase+')'

--print(@query)
--exec(@query)

SELECT * INTO #rf_idCases FROM fn_iter_intlist_to_table(@rf_idCase) 

select [rf_idCase] OSL_rf_idCase
    ,[DS1_T] OSL_DS1_T
    ,n2.[DS_St]+' ('+n2.[KOD_St]+')' OSL_STAD
    ,n3.[KOD_T] OSL_ONK_T
    ,n4.[KOD_N] OSL_ONK_N
    ,n5.[KOD_M] OSL_ONK_M
    ,case when osl.[IsMetastasis]=1 then 'Выявлены' else 'Не выявлены' end OSL_MTSTZ
    ,[TotalDose] OSL_SOD
    ,[K_FR] OSL_K_FR
    ,cast([WEI] as varchar(7)) + ' кг' OSL_WEI
    ,cast([HEI] as varchar(3)) + ' см' OSL_HEI
    ,cast([BSA] as varchar(5)) + ' м кв.' OSL_BSA
FROM [AccountOMS].[dbo].[t_ONK_SL] osl
inner join dbo.t_Case c on c.id=osl.rf_idCase
inner join #rf_idCases c1 on c1.number=c.id
left JOIN [oms_nsi].[dbo].[sprN002] n2 on n2.[ID_St]=osl.[rf_idN002] and c.DateEnd between n2.DateBeg and n2.DateEnd
left JOIN [oms_nsi].[dbo].[sprN003] n3 on n3.[ID_T]=osl.[rf_idN003] and c.DateEnd between n3.DateBeg and n3.DateEnd
left JOIN [oms_nsi].[dbo].[sprN004] n4 on n4.[ID_N]=osl.[rf_idN004] and c.DateEnd between n4.DateBeg and n4.DateEnd
left JOIN [oms_nsi].[dbo].[sprN005] n5 on n5.[ID_M]=osl.[rf_idN005] and c.DateEnd between n5.DateBeg and n5.DateEnd

--where [rf_idCase]=@rf_idCase





GO
GRANT EXECUTE ON  [dbo].[usp_selectCases19Type1OnkSlForReport] TO [AccountsOMS]
GO
GRANT EXECUTE ON  [dbo].[usp_selectCases19Type1OnkSlForReport] TO [db_AccountOMS]
GO
