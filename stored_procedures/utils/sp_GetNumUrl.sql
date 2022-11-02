
CREATE PROCEDURE sp_GetNumUrl @url VARCHAR(MAX), @id INT OUT
AS
BEGIN

    IF (@url LIKE '%[a-zA-Z]/[0-9]%')
    BEGIN

        DECLARE @pat VARCHAR(MAX) = (SUBSTRING(@url, PATINDEX('%[0-9]%', @url), LEN(@url)));

        IF (@pat LIKE '%/')
        BEGIN
            SET @id = CAST((REPLACE(@pat, '/', '')) AS INT);
            RETURN;
        END

        SET @id = CAST(@pat AS INT);

        RETURN;

    END

    RETURN;

END

DECLARE @idUrl INT;
EXEC sp_GetNumUrl N'https://swapi.dev/api/starships/12/', @idUrl OUT
PRINT @idUrl;