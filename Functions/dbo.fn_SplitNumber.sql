CREATE FUNCTION [dbo].[fn_SplitNumber] (@s [nvarchar] (4000))
RETURNS [nvarchar] (4000)
WITH EXECUTE AS CALLER
EXTERNAL NAME [Function].[UserDefinedFunctions].[fn_SplitNumber]
GO
GRANT EXECUTE ON  [dbo].[fn_SplitNumber] TO [db_AccountOMS]
GO
EXEC sp_addextendedproperty N'SqlAssemblyFile', N'SplitNumber.cs', 'SCHEMA', N'dbo', 'FUNCTION', N'fn_SplitNumber', NULL, NULL
GO
EXEC sp_addextendedproperty N'SqlAssemblyFileLine', N'13', 'SCHEMA', N'dbo', 'FUNCTION', N'fn_SplitNumber', NULL, NULL
GO
