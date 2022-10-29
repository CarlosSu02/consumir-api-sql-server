
DECLARE @url VARCHAR(MAX) = 'https://swapi.dev/api/starships/1233333/';

IF(@url LIKE '%[a-zA-Z]/[0-9]%')
BEGIN
    -- SELECT position = PATINDEX('%ter%', @url); 
    -- PRINT LEN(@url);
    -- PRINT (PATINDEX('%https://swapi.dev/api/%', @url));
    -- PRINT (SUBSTRING(@url, PATINDEX('%[a-z][0-9]/', @url), LEN(@url)));
    -- PRINT (CHARINDEX('people', @url));
    -- PRINT (REPLACE(@url, pat, ''));
    PRINT (SUBSTRING(@url, PATINDEX('%[0-9]%', @url), LEN(@url)));
    DECLARE @pat VARCHAR(MAX) = (SUBSTRING(@url, PATINDEX('%[0-9]%', @url), LEN(@url)));
    DECLARE @num INT;

    IF (@pat LIKE '%/')
    BEGIN
        SET @num = CAST((REPLACE(@pat, '/', '')) AS INT);
        PRINT @num;
        RETURN;
    END
    
    SET @num = CAST(@pat AS INT);
    PRINT @num;
    RETURN;
END
ELSE
BEGIN
    PRINT 'Not found';
END
