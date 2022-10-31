
CREATE PROCEDURE sp_people_insert 
AS
BEGIN

    DECLARE @url VARCHAR(MAX) = 'https://swapi.dev/api/people/';
    DECLARE @count INT = 0;
    DECLARE @countPeople INT;
    EXEC sp_GetData @url, @countPeople OUT;

    DECLARE @responseJSON VARCHAR(MAX);

    WHILE @count <= @countPeople
    BEGIN

		SET @count = @count + 1;

        DECLARE @newUrl VARCHAR(MAX) = @url + CAST(@count AS VARCHAR);
        EXEC sp_GetData @newUrl, @responseJSON OUT;

        IF (@responseJSON <> 'NOT FOUND')
		BEGIN

            DECLARE @name VARCHAR(MAX) = (SELECT [value] FROM OPENJSON(@responseJSON) WHERE [key] = 'name');
            DECLARE @height VARCHAR(MAX) = (SELECT [value] FROM OPENJSON(@responseJSON) WHERE [key] = 'height');
            DECLARE @mass VARCHAR(MAX) = (SELECT [value] FROM OPENJSON(@responseJSON) WHERE [key] = 'mass');
            DECLARE @hair_color VARCHAR(MAX) = (SELECT [value] FROM OPENJSON(@responseJSON) WHERE [key] = 'hair_color');
            DECLARE @skin_color VARCHAR(MAX) = (SELECT [value] FROM OPENJSON(@responseJSON) WHERE [key] = 'skin_color');
            DECLARE @eye_color VARCHAR(MAX) = (SELECT [value] FROM OPENJSON(@responseJSON) WHERE [key] = 'eye_color');
            DECLARE @birth_year VARCHAR(MAX) = (SELECT [value] FROM OPENJSON(@responseJSON) WHERE [key] = 'birth_year');
            DECLARE @gender VARCHAR(MAX) = (SELECT [value] FROM OPENJSON(@responseJSON) WHERE [key] = 'gender');
            DECLARE @created VARCHAR(MAX) = (SELECT [value] FROM OPENJSON(@responseJSON) WHERE [key] = 'created');
            DECLARE @edited VARCHAR(MAX) = (SELECT [value] FROM OPENJSON(@responseJSON) WHERE [key] = 'edited');
            DECLARE @urlFromJSON VARCHAR(MAX) = (SELECT [value] FROM OPENJSON(@responseJSON) WHERE [key] = 'url');
            DECLARE @id INT;
            EXEC sp_GetNumUrl @urlFromJSON, @id OUT;

            INSERT INTO 
                dbo.people 
                (id,
                name, 
                height, 
                mass, 
                hair_color,
                skin_color,
                eye_color,
                birth_year,
                gender,
                created,
                edited,
                url)
            VALUES
                (@id,
                @name,
                @height,
                @mass,
                @hair_color,
                @skin_color,
                @eye_color,
                @birth_year,
                @gender,
                @created,
                @edited,
                @urlFromJSON);
            
            -- PRINT '@people ' + CAST(@id AS VARCHAR(MAX));

            -- Films_People
            DECLARE @films VARCHAR(MAX) = (SELECT [value] FROM OPENJSON(@responseJSON) WHERE [key] = 'films');

            IF ((SELECT COUNT(*) FROM OPENJSON(@films)) > 0)
            BEGIN

                DECLARE @count2 INT = 0;

                WHILE @count2 < (SELECT COUNT(*) FROM OPENJSON(@films))
                BEGIN

                    DECLARE @filmUrl VARCHAR(MAX) = (SELECT [value] FROM OPENJSON(@films) WHERE [key] = @count2);
                    DECLARE @film_id INT;
                    EXEC sp_GetNumUrl @filmUrl, @film_id OUT;      
                    
                    -- PRINT '@films_people ' + CAST(@film_id AS VARCHAR(MAX)) + ' num: ' + CAST(@id AS VARCHAR(MAX));

                    INSERT INTO 
                        dbo.films_people
                    VALUES
                        (@film_id,
                        @id);

                    SET @count2 = @count2 + 1;

                END 
            
            END 

        END 

    END

    RETURN;
    
END

EXEC sp_people_insert;
