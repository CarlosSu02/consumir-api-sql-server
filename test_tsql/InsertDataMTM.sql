
DECLARE @planets_people TABLE(
    planet_id INT NOT NULL,
    person_id INT NOT NULL,
    PRIMARY KEY (planet_id, person_id)
);

DECLARE @films_planets TABLE(
    film_id INT NOT NULL,
    planet_id INT NOT NULL,
    PRIMARY KEY (film_id, planet_id)
);

DECLARE @count INT = 0;
DECLARE @countPlanets INT;
EXEC sp_GetData N'https://swapi.dev/api/planets/', @countPlanets OUT;
PRINT @countPlanets; 

WHILE @count < @countPlanets
BEGIN

    SET @count = @count + 1;

    DECLARE @newUrl VARCHAR(MAX) = N'https://swapi.dev/api/planets/' + CAST(@count AS VARCHAR)
    DECLARE @responseJSON VARCHAR(MAX);
    EXEC sp_GetData @newUrl, @responseJSON OUT;

    DECLARE @urlFromJSON VARCHAR(MAX) = (SELECT [value] FROM OPENJSON(@responseJSON) WHERE [key] = 'url');
    DECLARE @planet_id INT;
    EXEC sp_GetNumUrl @urlFromJSON, @planet_id OUT;

    -- Planets_People
    
    DECLARE @residents VARCHAR(MAX) = (SELECT [value] FROM OPENJSON(@responseJSON) WHERE [key] = 'residents');
    -- DECLARE @resident VARCHAR(MAX) = (SELECT [value] FROM OPENJSON(@residents));

    -- (SELECT * FROM OPENJSON(@residents) WHERE [key] = @count - 1);

    -- (SELECT COUNT(*) FROM OPENJSON(@residents))

    -- (SELECT * FROM OPENJSON(@residents))

    IF ((SELECT COUNT(*) FROM OPENJSON(@residents)) > 0)
    BEGIN

        DECLARE @count2 INT = 0;

        WHILE @count2 < (SELECT COUNT(*) FROM OPENJSON(@residents))
        BEGIN

            DECLARE @residentUrl VARCHAR(MAX) = (SELECT [value] FROM OPENJSON(@residents) WHERE [key] = @count2);
            DECLARE @people_id INT;
            EXEC sp_GetNumUrl @residentUrl, @people_id OUT;      
            
            PRINT @residentUrl;
            PRINT '@planets_people ' + CAST(@planet_id AS VARCHAR(MAX)) + ' num: ' + CAST(@people_id AS VARCHAR(MAX));

            INSERT INTO 
                @planets_people
            VALUES
                (@planet_id,
                @people_id);

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
            
            -- PRINT '@films_planets ' + CAST(@planet_id AS VARCHAR(MAX)) + ' num: ' + CAST(@film_id AS VARCHAR(MAX));

            INSERT INTO 
                @films_planets
            VALUES
                (@film_id,
                @planet_id);

            SET @count3 = @count3 + 1;

        END 
    
    END  

END

SELECT * FROM @planets_people;
SELECT * FROM @films_planets;
