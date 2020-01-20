SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE VIEW [dbo].[vw_PeopleAdressPolicyDB]
as
SELECT enp,REPLACE(ISNULL(INDX,'')+','+ISNULL(RNNAME,'')+','+ISNULL(CITY,'')+','+ISNULL(NP,'')+','+ISNULL(UL,'')+','+ISNULL(DOM,'')+','+ISNULL(KV,''),',,',',') AS PAdres
FROM PolicyRegister.dbo.PEOPLE
GO
