
CREATE PROCEDURE sp_GetData @url VARCHAR(MAX), @result VARCHAR(MAX) OUTPUT
AS
BEGIN

	DECLARE 
		@intToken INT,
		@resJSON VARCHAR(8000),
		@status NVARCHAR(32),
		@statusText NVARCHAR(32);

	DECLARE @responseText table(content NVARCHAR(max));
	DECLARE @data VARCHAR(8000);
	DECLARE @countChs INT;

	EXEC sp_OACreate 'MSXML2.XMLHTTP', @intToken OUT;

	EXEC sp_OAMethod @intToken, 'open', NULL, 'get', @url, 'false';
    EXEC sp_OAMethod @intToken, 'send';
    EXEC sp_OAGetProperty @intToken, 'status', @status OUT;
    EXEC sp_OAGetProperty @intToken, 'statusText', @statusText OUT;
    EXEC sp_OAMethod @intToken, 'responseText', @resJSON OUT;
	INSERT INTO @responseText EXEC sp_OAMethod @intToken, 'responseText';

	SET @data = (SELECT * FROM @responseText);
	SET @countChs = (SELECT [value] FROM OPENJSON(@data) WHERE [key] = 'count');

	-- PRINT @url;
	
	EXEC sp_OADestroy @intToken;

	IF (@url LIKE '%films/6')
	BEGIN
		SET @result = (SELECT * FROM @responseText);
		RETURN;
	END

	IF (@url NOT LIKE '%[a-zA-Z]/[0-9]%')
	BEGIN
		SET @result = @countChs;
		RETURN;
	END

	IF (ISJSON(@resJSON) <> 1 OR @statusText <> 'OK')
	BEGIN
		RETURN;
	END

	-- PRINT @statusText;
	-- PRINT @countChs;

	SET @result = @resJSON;
	RETURN;

END

DECLARE @output VARCHAR(MAX);
EXEC sp_GetData N'https://swapi.dev/api/films/6', @output OUT;
PRINT @output;