
CREATE PROCEDURE sp_GetData @url VARCHAR(MAX), @option VARCHAR(MAX) = NULL, @result VARCHAR(MAX) OUTPUT
AS
BEGIN

	DECLARE 
		@intToken INT,
		@vchJSON VARCHAR(8000),
		@status nvarchar(32),
		@statusText nvarchar(32);

	DECLARE @responseText table(content nvarchar(max));
	DECLARE @data VARCHAR(8000);
	DECLARE @countChs INT;

	EXEC sp_OACreate 'MSXML2.XMLHTTP', @intToken OUT;

	EXEC sp_OAMethod @intToken, 'open', NULL, 'get', @url, 'false';
    EXEC sp_OAMethod @intToken, 'send';
    EXEC sp_OAGetProperty @intToken, 'status', @status out;
    EXEC sp_OAGetProperty @intToken, 'statusText', @statusText out;
    EXEC sp_OAMethod @intToken, 'responseText', @vchJSON out;
	INSERT INTO @responseText EXEC sp_OAMethod @intToken, 'responseText';

	SET @data = (SELECT * FROM @responseText);
	SET @countChs = (SELECT [value] FROM OPENJSON(@data) WHERE [key] = 'count');

	-- PRINT @url;
	
	EXEC sp_OADestroy @intToken;

	IF (@option LIKE 'count' OR @url NOT LIKE '%[a-zA-Z]/[0-9]%')
	BEGIN
		SET @result = @countChs;
		RETURN 1;
	END

	IF (ISJSON(@vchJSON) <> 1 OR @statusText <> 'OK')
	BEGIN
		RETURN 0;
	END

	-- PRINT @statusText;
	-- PRINT @countChs;

	SET @result = @vchJSON;
	RETURN 1;

END

DECLARE @output VARCHAR(MAX);
EXEC sp_testing2 N'https://swapi.dev/api/people/1', null, @output OUT;
PRINT @output;