
CREATE PROCEDURE sp_GetNumUrl @url VARCHAR(MAX), @id INT OUT
AS
BEGIN

    IF (@url LIKE '%[a-zA-Z]/[0-9]%')
    BEGIN

        -- PRINT (SUBSTRING(@url, PATINDEX('%[0-9]%', @url), LEN(@url)));
        DECLARE @pat VARCHAR(MAX) = (SUBSTRING(@url, PATINDEX('%[0-9]%', @url), LEN(@url)));
        -- DECLARE @num INT;

        IF (@pat LIKE '%/')
        BEGIN
            SET @id = CAST((REPLACE(@pat, '/', '')) AS INT);
            RETURN;
        END

        SET @id = CAST(@pat AS INT);
        -- PRINT @num;

        RETURN;

    END

    RETURN;

END

DECLARE @id1 INT;
EXEC sp_GetNumUrl N'https://swapi.dev/api/starships/1233333/', @id1 OUT
PRINT @id1;