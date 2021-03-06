USE [Data_Services]
GO
/****** Object:  UserDefinedFunction [dbo].[UrlDecodeUTF8]    Script Date: 12/1/2016 8:57:27 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[UrlDecodeUTF8](@URL varchar(3072))
RETURNS varchar(3072)
AS
BEGIN 
    DECLARE @Position INT,
        @Base CHAR(16),
        @Code INT,
        @Pattern CHAR(21)

    SELECT @URL = REPLACE(@URL, '%c3', '')

    SELECT  @Base = '0123456789abcdef',
        @Pattern = '%[%][0-9a-f][0-9a-f]%',
        @Position = PATINDEX(@Pattern, @URL)

    WHILE @Position > 0
        SELECT @Code = Cast(CONVERT(varbinary(4), '0x' + SUBSTRING(@URL, @Position + 1, 2), 1) As int),
            @URL = STUFF(@URL, @Position, 3, NCHAR(@Code + 64)),
            @Position = PATINDEX(@Pattern, @URL)

    RETURN REPLACE(@URL, '+', ' ')

END

GO
