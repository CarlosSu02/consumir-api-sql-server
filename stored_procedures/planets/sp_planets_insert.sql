
CREATE PROCEDURE sp_planets_insert 
AS
BEGIN

    DECLARE @url VARCHAR(MAX) = 'https://swapi.dev/api/planets/';
    DECLARE @count INT = 0;
    DECLARE @countPlanets INT;
    EXEC sp_GetData @url, @countPlanets OUT;

    DECLARE @responseJSON VARCHAR(MAX);

    WHILE (SELECT COUNT(*) FROM dbo.planets) < @countPlanets
    BEGIN

		SET @count = @count + 1;

        DECLARE @newUrl VARCHAR(MAX) = @url + CAST(@count AS VARCHAR);
        EXEC sp_GetData @newUrl, @responseJSON OUT;

        IF (@responseJSON <> 'NOT FOUND')
		BEGIN

            DECLARE @name VARCHAR(MAX) = (SELECT [value] FROM OPENJSON(@responseJSON) WHERE [key] = 'name');
            DECLARE @rotation_period VARCHAR(MAX) = (SELECT [value] FROM OPENJSON(@responseJSON) WHERE [key] = 'rotation_period');
            DECLARE @orbital_period VARCHAR(MAX) = (SELECT [value] FROM OPENJSON(@responseJSON) WHERE [key] = 'orbital_period');
            DECLARE @diameter VARCHAR(MAX) = (SELECT [value] FROM OPENJSON(@responseJSON) WHERE [key] = 'diameter');
            DECLARE @climate VARCHAR(MAX) = (SELECT [value] FROM OPENJSON(@responseJSON) WHERE [key] = 'climate');
            DECLARE @gravity VARCHAR(MAX) = (SELECT [value] FROM OPENJSON(@responseJSON) WHERE [key] = 'gravity');
            DECLARE @terrain VARCHAR(MAX) = (SELECT [value] FROM OPENJSON(@responseJSON) WHERE [key] = 'terrain');
            DECLARE @surface_water VARCHAR(MAX) = (SELECT [value] FROM OPENJSON(@responseJSON) WHERE [key] = 'surface_water');
            DECLARE @population VARCHAR(MAX) = (SELECT [value] FROM OPENJSON(@responseJSON) WHERE [key] = 'population');
            DECLARE @created VARCHAR(MAX) = (SELECT [value] FROM OPENJSON(@responseJSON) WHERE [key] = 'created');
            DECLARE @edited VARCHAR(MAX) = (SELECT [value] FROM OPENJSON(@responseJSON) WHERE [key] = 'edited');
            DECLARE @urlFromJSON VARCHAR(MAX) = (SELECT [value] FROM OPENJSON(@responseJSON) WHERE [key] = 'url');
            DECLARE @id INT;
            EXEC sp_GetNumUrl @urlFromJSON, @id OUT;

            INSERT INTO 
                dbo.planets 
                (id,
                name, 
                rotation_period, 
                orbital_period, 
                diameter, 
                climate, 
                gravity, 
                terrain, 
                surface_water, 
                population, 
                created, 
                edited, 
                url)
            VALUES
                (@id,
                @name,
                @rotation_period,
                @orbital_period,
                @diameter,
                @climate,
                @gravity,
                @terrain,
                @surface_water,
                @population,
                @created,
                @edited,
                @urlFromJSON);

            -- Planets_People
            DECLARE @residents VARCHAR(MAX) = (SELECT [value] FROM OPENJSON(@responseJSON) WHERE [key] = 'residents');

            IF ((SELECT COUNT(*) FROM OPENJSON(@residents)) > 0)
            BEGIN

                DECLARE @count2 INT = 0;

                WHILE @count2 < (SELECT COUNT(*) FROM OPENJSON(@residents))
                BEGIN

                    DECLARE @residentUrl VARCHAR(MAX) = (SELECT [value] FROM OPENJSON(@residents) WHERE [key] = @count2);
                    DECLARE @person_id INT;
                    EXEC sp_GetNumUrl @residentUrl, @person_id OUT;      
                    
                    INSERT INTO 
                        dbo.planets_people
                    VALUES
                        (@id,
                        @person_id);

                    SET @count2 = @count2 + 1;

                END
            
            END

            -- Films_Planets
            DECLARE @films VARCHAR(MAX) = (SELECT [value] FROM OPENJSON(@responseJSON) WHERE [key] = 'films');

            IF ((SELECT COUNT(*) FROM OPENJSON(@films)) > 0)
            BEGIN

                DECLARE @count3 INT = 0;

                WHILE @count3 < (SELECT COUNT(*) FROM OPENJSON(@films))
                BEGIN

                    DECLARE @filmUrl VARCHAR(MAX) = (SELECT [value] FROM OPENJSON(@films) WHERE [key] = @count3);
                    DECLARE @film_id INT;
                    EXEC sp_GetNumUrl @filmUrl, @film_id OUT;      
                    
                    INSERT INTO 
                        dbo.films_planets
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

EXEC sp_planets_insert;
