
CREATE PROCEDURE sp_starships_insert 
AS
BEGIN

    DECLARE @url VARCHAR(MAX) = 'https://swapi.dev/api/starships/';
    DECLARE @count INT = 0;
    DECLARE @countStarships INT;
    EXEC sp_GetData @url, @countStarships OUTPUT;

    DECLARE @responseJSON VARCHAR(MAX);

    WHILE @count < @countStarships
    BEGIN

		SET @count = @count + 1;

        DECLARE @newUrl VARCHAR(MAX) = @url + CAST(@count AS VARCHAR);
        EXEC sp_GetData @newUrl, @responseJSON OUT;

        IF ((SELECT COUNT(*) FROM OPENJSON(@responseJSON)) <> 0 AND @responseJSON <> 'NOT FOUND')
		BEGIN

            DECLARE @name VARCHAR(MAX) = (SELECT [value] FROM OPENJSON(@responseJSON) WHERE [key] = 'name');
            DECLARE @model VARCHAR(MAX) = (SELECT [value] FROM OPENJSON(@responseJSON) WHERE [key] = 'model');
            DECLARE @manufacturer VARCHAR(MAX) = (SELECT [value] FROM OPENJSON(@responseJSON) WHERE [key] = 'manufacturer');
            DECLARE @cost_in_credits VARCHAR(MAX) = (SELECT [value] FROM OPENJSON(@responseJSON) WHERE [key] = 'cost_in_credits');
            DECLARE @length VARCHAR(MAX) = (SELECT [value] FROM OPENJSON(@responseJSON) WHERE [key] = 'length');
            DECLARE @max_atmosphering_speed VARCHAR(MAX) = (SELECT [value] FROM OPENJSON(@responseJSON) WHERE [key] = 'max_atmosphering_speed');
            DECLARE @crew VARCHAR(MAX) = (SELECT [value] FROM OPENJSON(@responseJSON) WHERE [key] = 'crew');
            DECLARE @passengers VARCHAR(MAX) = (SELECT [value] FROM OPENJSON(@responseJSON) WHERE [key] = 'passengers');
            DECLARE @cargo_capacity VARCHAR(MAX) = (SELECT [value] FROM OPENJSON(@responseJSON) WHERE [key] = 'cargo_capacity');
            DECLARE @consumables VARCHAR(MAX) = (SELECT [value] FROM OPENJSON(@responseJSON) WHERE [key] = 'consumables');
            DECLARE @hyperdrive_rating VARCHAR(MAX) = (SELECT [value] FROM OPENJSON(@responseJSON) WHERE [key] = 'hyperdrive_rating');
            DECLARE @MGLT VARCHAR(MAX) = (SELECT [value] FROM OPENJSON(@responseJSON) WHERE [key] = 'MGLT');
            DECLARE @starship_class VARCHAR(MAX) = (SELECT [value] FROM OPENJSON(@responseJSON) WHERE [key] = 'starship_class');
            DECLARE @created VARCHAR(MAX) = (SELECT [value] FROM OPENJSON(@responseJSON) WHERE [key] = 'created');
            DECLARE @edited VARCHAR(MAX) = (SELECT [value] FROM OPENJSON(@responseJSON) WHERE [key] = 'edited');
            DECLARE @urlFromJSON VARCHAR(MAX) = (SELECT [value] FROM OPENJSON(@responseJSON) WHERE [key] = 'url');
            DECLARE @id INT;
            EXEC sp_GetNumUrl @urlFromJSON, @id OUT;

            INSERT INTO 
                dbo.starships
                (id,
                name,
                model,
                manufacturer,
                cost_in_credits,
                length,
                max_atmosphering_speed,
                crew,
                passengers,
                cargo_capacity,
                consumables,
                hyperdrive_rating,
                MGLT,
                starship_class,
                created,
                edited,
                url)
            VALUES
                (@id,
                @name,
                @model,
                @manufacturer,
                @cost_in_credits,
                @length,
                @max_atmosphering_speed,
                @crew,
                @passengers,
                @cargo_capacity,
                @consumables,
                @hyperdrive_rating,
                @MGLT,
                @starship_class,
                @created,
                @edited,
                @urlFromJSON);

            -- People_Starships
            DECLARE @people VARCHAR(MAX) = (SELECT [value] FROM OPENJSON(@responseJSON) WHERE [key] = 'people');

            IF ((SELECT COUNT(*) FROM OPENJSON(@people)) > 0)
            BEGIN

                DECLARE @count2 INT = 0;

                WHILE @count2 < (SELECT COUNT(*) FROM OPENJSON(@people))
                BEGIN

                    DECLARE @peopleUrl VARCHAR(MAX) = (SELECT [value] FROM OPENJSON(@people) WHERE [key] = @count2);
                    DECLARE @person_id INT;
                    EXEC sp_GetNumUrl @peopleUrl, @person_id OUT;      
                    
                    -- PRINT '@people_starships ' + CAST(@id AS VARCHAR(MAX)) + ' num: ' + CAST(@person_id AS VARCHAR(MAX));

                    INSERT INTO 
                        dbo.people_starships
                    VALUES
                        (@id,
                        @person_id);

                    SET @count2 = @count2 + 1;

                END
            
            END

            -- Films_Species
            DECLARE @films VARCHAR(MAX) = (SELECT [value] FROM OPENJSON(@responseJSON) WHERE [key] = 'films');

            IF ((SELECT COUNT(*) FROM OPENJSON(@films)) > 0)
            BEGIN

                DECLARE @count3 INT = 0;

                WHILE @count3 < (SELECT COUNT(*) FROM OPENJSON(@films))
                BEGIN

                    DECLARE @filmUrl VARCHAR(MAX) = (SELECT [value] FROM OPENJSON(@films) WHERE [key] = @count3);
                    DECLARE @film_id INT;
                    EXEC sp_GetNumUrl @filmUrl, @film_id OUT;      
                    
                    -- PRINT '@films_starships ' + CAST(@id AS VARCHAR(MAX)) + ' num: ' + CAST(@film_id AS VARCHAR(MAX));

                    INSERT INTO 
                        dbo.films_starships
                    VALUES
                        (@film_id,
                        @id);

                    SET @count3 = @count3 + 1;

                END 
            
            END 

        END  

    END

    RETURN;

END

EXEC sp_starships_insert;