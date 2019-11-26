SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE VIEW [dbo].[view_Meduslugi]
AS
SELECT
	  --M.id
	  M.rf_idCase
	, M.rf_idV002				-- V002 Классификатор профиля
	, v002.Name as [Profile]
	, M.DateHelpBegin
	, M.DateHelpEnd
	, cast(view_sprMU.MUGroupCode as varchar(2))+'.'+cast(view_sprMU.MUUnGroupCode as varchar(2))+'.'+cast(view_sprMU.MUCode as varchar(3)) as MUCodes
	, M.MUCode
	, M.MUGroupCode
	, M.MUUnGroupCode
	, M.Quantity
	, M.Price
	, M.TotalPrice
	, view_sprMU.MUName

	, 0 as MType
FROM
  t_Meduslugi M
  INNER JOIN view_sprV002 v002
		  ON v002.Id = M.rf_idV002
  INNER JOIN view_sprMU
	    ON view_sprMU.MUGroupCode = M.MUGroupCode AND
		   view_sprMU.MUUnGroupCode = M.MUUnGroupCode AND
		   view_sprMU.MUCode = M.MUCode
WHERE
	M.MUSurgery IS NULL -- не смотрим на хирургические операции
-- законченные случаи
UNION ALL

SELECT
	  --M.id
	  M.rf_idCase
	, t_Case.rf_idV002 as rf_idV002
	, v002.Name as [Profile]
	, t_Case.DateBegin as DateHelpBegin
	, t_Case.DateEnd as DateHelpEnd	
	, M.MES as MUCodes
	, view_sprMU.MUCode
	, view_sprMU.MUGroupCode
	, view_sprMU.MUUnGroupCode
	, M.Quantity
	, M.Tariff as Price
	, t_Case.AmountPayment as TotalPrice
	, view_sprMU.MUName
	, 1 as MType
FROM
  t_Mes M
  INNER JOIN view_sprMU
		  ON M.MES = cast(view_sprMU.MUGroupCode as varchar(2))+'.'+cast(view_sprMU.MUUnGroupCode as varchar(2))+'.'+cast(view_sprMU.MUCode as varchar(3))
  INNER JOIN t_Case
		  ON t_Case.id = M.rf_idCase
  INNER JOIN view_sprV002 v002
		  ON v002.Id = t_Case.rf_idV002
GO
GRANT SELECT ON  [dbo].[view_Meduslugi] TO [db_AccountOMS]
GO
