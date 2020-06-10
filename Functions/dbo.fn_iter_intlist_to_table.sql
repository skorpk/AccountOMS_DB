SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
      CREATE FUNCTION [dbo].[fn_iter_intlist_to_table] (@list ntext)
      RETURNS @tbl TABLE (listpos int IDENTITY(1, 1) NOT NULL,
                          number  int NOT NULL) AS
   BEGIN
      DECLARE @pos      int,
              @textpos  int,
              @chunklen smallint,
              @str      nvarchar(max),
              @tmpstr   nvarchar(max),
              @leftover nvarchar(max)

      SET @textpos = 1
      SET @leftover = ''
      WHILE @textpos <= datalength(@list) / 2
      BEGIN
         SET @chunklen = 4000 - datalength(@leftover) / 2
         SET @tmpstr = ltrim(@leftover + substring(@list, @textpos, @chunklen))
         SET @textpos = @textpos + @chunklen

         SET @pos = charindex(' ', @tmpstr)
         WHILE @pos > 0
         BEGIN
            SET @str = substring(@tmpstr, 1, @pos - 1)
            INSERT @tbl (number) VALUES(convert(int, @str))
            SET @tmpstr = ltrim(substring(@tmpstr, @pos + 1, len(@tmpstr)))
            SET @pos = charindex(' ', @tmpstr)
         END

         SET @leftover = @tmpstr
      END

      IF ltrim(rtrim(@leftover)) <> ''
         INSERT @tbl (number) VALUES(convert(int, @leftover))

      RETURN
   END
GO
GRANT SELECT ON  [dbo].[fn_iter_intlist_to_table] TO [db_AccountOMS]
GO
