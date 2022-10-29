DECLARE 
	@intToken INT,
	
	@vchEndereco VARCHAR(MAX),
	@vchURL AS VARCHAR(MAX),
	@vchJSON VARCHAR(8000),
	@vchStatus AS VARCHAR(MAX),
	@intQtdeResultados AS INT,
	--Mapear JSON
	@vchJSONResults AS VARCHAR(MAX),
	@vchJSONResultsGeometry AS VARCHAR(MAX),
	@vchJSONResultsLocation AS VARCHAR(MAX),
	@fltLatitude FLOAT,
	@fltLongitude FLOAT,
	@status nvarchar(32),
    @statusText nvarchar(32);

DECLARE @responseText table(content nvarchar(max));
DECLARE @vchJSON2 VARCHAR(8000);
DECLARE @data VARCHAR(8000);
DECLARE @countChs INT;

DECLARE @responseTable table(
    id INT IDENTITY(1, 1) PRIMARY KEY,
    name VARCHAR(100),
    films VARCHAR(max),
    vehicles VARCHAR(max)
);

SET @vchEndereco = 'Av. Alan Kardec, 1451 - Centro, Bebedouro - SP';
SET @vchURL = 'https://swapi.dev/api/people/';

--OLE Automation é mecanismo para a comunicação entre processos baseado em Component Object Model (COM)
--Is the returned object token, and must be a local variable of data type int. This object token identifies the created OLE object and is used in calls to the other OLE Automation stored procedures.
EXEC sp_OACreate 'MSXML2.XMLHTTP', @intToken OUT;
--Chamada para método OPEN
EXEC sp_OAMethod @intToken, 'open', NULL, 'get', @vchURL, 'false';
--Chamada para método SEND
EXEC sp_OAMethod @intToken, 'send';
--Chamada para método RESPONSE TEXT
EXEC sp_OAGetProperty @intToken, 'status', @status out;
EXEC sp_OAGetProperty @intToken, 'statusText', @statusText out;
EXEC sp_OAMethod @intToken, 'responseText', @vchJSON out;
INSERT INTO @responseText EXEC sp_OAMethod @intToken, 'responseText';

--Site para visualizar JSON http://jsonviewer.stack.hu/
--SELECT @vchJSON;
--SELECT * FROM @responseText;
--SELECT * FROM OPENJSON((Select * FROM @responseText));

SET @vchJSON2 = (SELECT * FROM @responseText);
SET @data = (SELECT * FROM @responseText);
SET @countChs = (SELECT [value] FROM OPENJSON(@data) WHERE [key] = 'count');

PRINT 'Status: ' + @status + ' statusText: ' + @statusText + ' count: ' + (CAST((@countChs) AS nvarchar(32)));
PRINT ISJSON((@vchJSON2));
--Mapear o JSON.

DECLARE @cnt1 INT = 0;

WHILE @cnt1 <= @countChs
	BEGIN
    SET @cnt1 = @cnt1 + 1;
    -- PRINT @vchURL + (CAST((@cnt1) AS nvarchar));

    DECLARE @newUrl VARCHAR(MAX) = @vchURL + (CAST((@cnt1) AS nvarchar));
    --PRINT @newUrl;

    EXEC sp_OAMethod @intToken, 'open', NULL, 'get', @newUrl, 'false';
    --Chamada para método SEND
    EXEC sp_OAMethod @intToken, 'send';
    --Chamada para método RESPONSE TEXT
    EXEC sp_OAGetProperty @intToken, 'status', @status out;
    EXEC sp_OAGetProperty @intToken, 'statusText', @statusText out;
    EXEC sp_OAMethod @intToken, 'responseText', @vchJSON out;
    --INSERT INTO @responseText EXEC sp_OAMethod @intToken, 'responseText';

    --SELECT @vchJSON;

    --PRINT ISJSON(@vchJSON);
    --PRINT '#' + CAST(@cnt1 AS VARCHAR) + ' Status: ' + @status + ' statusText: ' + @statusText;

    IF (ISJSON(@vchJSON) = 1)
    BEGIN

        --Verificar se o status é OK (sucesso), ou seja, se a chamada foi realizada com sucesso
        --SET @vchStatus = (SELECT TOP 1 [value] FROM OPENJSON(@vchJSON) WHERE [key] = 'status');

        IF (@statusText = 'OK')
        BEGIN

            --Verificar a quantidade de resultados dentro do JSON.
            SET @intQtdeResultados = (SELECT COUNT([key]) FROM OPENJSON(@vchJSON));
            -- SELECT ([key]) FROM OPENJSON(@vchJSON2, '$.results')
            --SELECT COUNT([key]) FROM OPENJSON(@vchJSON);

            IF (@intQtdeResultados >= 1)
            BEGIN

                DECLARE @name VARCHAR(MAX) = (SELECT TOP 1 [value] FROM OPENJSON(@vchJSON) WHERE [key] = 'name');
                DECLARE @films VARCHAR(MAX) = (SELECT TOP 1 [value] FROM OPENJSON(@vchJSON) WHERE [key] = 'films');
                DECLARE @vehicles VARCHAR(MAX) = (SELECT TOP 1 [value] FROM OPENJSON(@vchJSON) WHERE [key] = 'vehicles');

				-- PRINT LEN(@vehicles);
                -- Insert rows into table 'responseTable'

                IF @vehicles = '[]'
                BEGIN

                    INSERT INTO @responseTable VALUES (@name, @films, NULL);

                END
                ELSE
                BEGIN
                    
                    INSERT INTO @responseTable VALUES (@name, @films, @vehicles);

                END
                
            -- SET @vchJSONResults = (SELECT TOP 1 [value] FROM OPENJSON(@vchJSON, '$.results'));

            END

        END

    END
END;

--Checar se é um JSON válido

SELECT * FROM @responseTable;

EXEC sp_OADestroy @intToken;	