
CREATE PROCEDURE sp_species_insert 
AS
BEGIN

    DECLARE @url VARCHAR(MAX) = 'https://swapi.dev/api/species/';
    DECLARE @count INT = 0;
    DECLARE @countSpecies INT;
    EXEC sp_GetData @url, @countSpecies OUT;

    DECLARE @responseJSON VARCHAR(MAX);

    WHILE (SELECT COUNT(*) FROM dbo.species) < @countSpecies
    BEGIN

		SET @count = @count + 1;

        DECLARE @newUrl VARCHAR(MAX) = @url + CAST(@count AS VARCHAR);
        EXEC sp_GetData @newUrl, @responseJSON OUT;
       
        IF (@responseJSON <> 'NOT FOUND')
		BEGIN
       
            DECLARE @name VARCHAR(MAX) = (SELECT [value] FROM OPENJSON(@responseJSON) WHERE [key] = 'name');
            DECLARE @classification VARCHAR(MAX) = (SELECT [value] FROM OPENJSON(@responseJSON) WHERE [key] = 'classification');
            DECLARE @designation VARCHAR(MAX) = (SELECT [value] FROM OPENJSON(@responseJSON) WHERE [key] = 'designation');
            DECLARE @average_height VARCHAR(MAX) = (SELECT [value] FROM OPENJSON(@responseJSON) WHERE [key] = 'average_height');
            DECLARE @skin_colors VARCHAR(MAX) = (SELECT [value] FROM OPENJSON(@responseJSON) WHERE [key] = 'skin_colors');
            DECLARE @hair_colors VARCHAR(MAX) = (SELECT [value] FROM OPENJSON(@responseJSON) WHERE [key] = 'hair_colors');
            DECLARE @eye_colors VARCHAR(MAX) = (SELECT [value] FROM OPENJSON(@responseJSON) WHERE [key] = 'eye_colors');
            DECLARE @average_lifespan VARCHAR(MAX) = (SELECT [value] FROM OPENJSON(@responseJSON) WHERE [key] = 'average_lifespan');
            DECLARE @homeworldUrl VARCHAR(MAX) = (SELECT [value] FROM OPENJSON(@responseJSON) WHERE [key] = 'homeworld');
            DECLARE @homeworldId INT;
            EXEC sp_GetNumUrl @homeworldUrl, @homeworldId OUT;

            DECLARE @language VARCHAR(MAX) = (SELECT [value] FROM OPENJSON(@responseJSON) WHERE [key] = 'language');
            DECLARE @created VARCHAR(MAX) = (SELECT [value] FROM OPENJSON(@responseJSON) WHERE [key] = 'created');
            DECLARE @edited VARCHAR(MAX) = (SELECT [value] FROM OPENJSON(@responseJSON) WHERE [key] = 'edited');
            DECLARE @urlFromJSON VARCHAR(MAX) = (SELECT [value] FROM OPENJSON(@responseJSON) WHERE [key] = 'url');
            DECLARE @id INT;
            EXEC sp_GetNumUrl @urlFromJSON, @id OUT;

            INSERT INTO 
                dbo.species
                (id,
                name,
                classification,
                designation,
                average_height,
                skin_colors,
                hair_colors,
                eye_colors,
                average_lifespan,
                homeworld,
                language,
                created,
                edited,
                url)
            VALUES
                (@id,
                @name,
                @classification,
                @designation,
                @average_height,
                @skin_colors,
                @hair_colors,
                @eye_colors,
                @average_lifespan,
                @homeworldId,
                @language,
                @created,
                @edited,
                @urlFromJSON);

            -- Species_People
            DECLARE @people VARCHAR(MAX) = (SELECT [value] FROM OPENJSON(@responseJSON) WHERE [key] = 'people');

            IF ((SELECT COUNT(*) FROM OPENJSON(@people)) > 0)
            BEGIN

                DECLARE @count2 INT = 0;

                WHILE @count2 < (SELECT COUNT(*) FROM OPENJSON(@people))
                BEGIN

                    DECLARE @peopleUrl VARCHAR(MAX) = (SELECT [value] FROM OPENJSON(@people) WHERE [key] = @count2);
                    DECLARE @person_id INT;
                    EXEC sp_GetNumUrl @peopleUrl, @person_id OUT;      
                    
                    -- PRINT '@species_people ' + CAST(@id AS VARCHAR(MAX)) + ' num: ' + CAST(@person_id AS VARCHAR(MAX));

                    INSERT INTO 
                        dbo.species_people
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
                    
                    -- PRINT '@films_species ' + CAST(@id AS VARCHAR(MAX)) + ' num: ' + CAST(@film_id AS VARCHAR(MAX));

                    INSERT INTO 
                        dbo.films_species
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

EXEC sp_species_insert;
