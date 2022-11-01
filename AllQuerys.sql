
----------------------------------- OLE Automation Procedures -----------------------------------
sp_configure 'show advanced options', 1;
GO
RECONFIGURE;
GO
sp_configure 'Ole Automation Procedures', 1;
GO
RECONFIGURE;
GO

-- Create a new database called 'swapi_dev'
-- Connect to the 'master' database to run this snippet
USE master
GO
-- Create the new database if it does not exist already
IF NOT EXISTS (
    SELECT name
        FROM sys.databases
        WHERE name = N'swapi_dev'
)
CREATE DATABASE swapi_dev
GO

USE swapi_dev;

-- Create a new table called 'films' in schema 'swapi_dev'
-- Drop the table if it already exists
IF OBJECT_ID('films', 'U') IS NOT NULL
DROP TABLE films
GO
-- Create the table in the specified schema
CREATE TABLE films
(
    id INT NOT NULL PRIMARY KEY, 
    title [VARCHAR](MAX) NOT NULL,
    episode_id [INT] NOT NULL,
    opening_crawl [VARCHAR](MAX) NOT NULL,
    director [VARCHAR](MAX) NOT NULL,
    producer [VARCHAR](MAX) NOT NULL,
    release_date [VARCHAR](MAX) NOT NULL,
    created [VARCHAR](MAX) NOT NULL,
    edited [VARCHAR](MAX) NOT NULL,
    url [VARCHAR](MAX) NOT NULL
);
GO

-- Create a new table called 'planets' in schema 'swapi_dev'
-- Drop the table if it already exists
IF OBJECT_ID('planets', 'U') IS NOT NULL
DROP TABLE planets
GO
-- Create the table in the specified schema
CREATE TABLE planets
(
    id INT NOT NULL PRIMARY KEY, 
    name [VARCHAR](MAX) NOT NULL,
    rotation_period [VARCHAR](MAX) NOT NULL,
    orbital_period [VARCHAR](MAX) NOT NULL,
    diameter [VARCHAR](MAX) NOT NULL,
    climate [VARCHAR](MAX) NOT NULL,
    gravity [VARCHAR](MAX) NOT NULL,
    terrain [VARCHAR](MAX) NOT NULL,
    surface_water [VARCHAR](MAX) NOT NULL,
    population [VARCHAR](MAX) NOT NULL,
    created [VARCHAR](MAX) NOT NULL,
    edited [VARCHAR](MAX) NOT NULL,
    url [VARCHAR](MAX) NOT NULL
);
GO

-- Create a new table called 'species' in schema 'swapi_dev'
-- Drop the table if it already exists
IF OBJECT_ID('species', 'U') IS NOT NULL
DROP TABLE species
GO
-- Create the table in the specified schema
CREATE TABLE species
(
    id INT NOT NULL PRIMARY KEY, 
    name [VARCHAR](MAX) NOT NULL,
    classification [VARCHAR](MAX) NOT NULL,
    designation [VARCHAR](MAX) NOT NULL,
    average_height [VARCHAR](MAX) NOT NULL,
    skin_colors [VARCHAR](MAX) NOT NULL,
    hair_colors [VARCHAR](MAX) NOT NULL,
    eye_colors [VARCHAR](MAX) NOT NULL,
    average_lifespan [VARCHAR](MAX) NOT NULL,
    homeworld INT NULL,
    language [VARCHAR](MAX) NOT NULL,
    created [VARCHAR](MAX) NOT NULL,
    edited [VARCHAR](MAX) NOT NULL,
    url [VARCHAR](MAX) NOT NULL,
    FOREIGN KEY (homeworld) REFERENCES planets(id)
);
GO

-- Create a new table called 'people' in schema 'swapi_dev'
-- Drop the table if it already exists
IF OBJECT_ID('people', 'U') IS NOT NULL
DROP TABLE people
GO
-- Create the table in the specified schema
CREATE TABLE people
(
    id INT NOT NULL PRIMARY KEY, 
    name [VARCHAR](MAX) NOT NULL,
    height [VARCHAR](MAX) NOT NULL,
    mass [VARCHAR](MAX) NOT NULL,
    hair_color [VARCHAR](MAX) NOT NULL,
    skin_color [VARCHAR](MAX) NOT NULL,
    eye_color [VARCHAR](MAX) NOT NULL,
    birth_year [VARCHAR](MAX) NOT NULL,
    gender [VARCHAR](MAX) NOT NULL,
    created [VARCHAR](MAX) NOT NULL,
    edited [VARCHAR](MAX) NOT NULL,
    url [VARCHAR](MAX) NOT NULL
);
GO

-- Create a new table called 'vehicles' in schema 'swapi_dev'
-- Drop the table if it already exists
IF OBJECT_ID('vehicles', 'U') IS NOT NULL
DROP TABLE vehicles
GO
-- Create the table in the specified schema
CREATE TABLE vehicles
(
    id INT NOT NULL PRIMARY KEY, 
    name [VARCHAR](MAX) NOT NULL,
    model [VARCHAR](MAX) NOT NULL,
    manufacturer [VARCHAR](MAX) NOT NULL,
    cost_in_credits [VARCHAR](MAX) NOT NULL,
    length [VARCHAR](MAX) NOT NULL,
    max_atmosphering_speed [VARCHAR](MAX) NOT NULL,
    crew [VARCHAR](MAX) NOT NULL,
    passengers [VARCHAR](MAX) NOT NULL,
    cargo_capacity [VARCHAR](MAX) NOT NULL,
    consumables [VARCHAR](MAX) NOT NULL,
    vehicle_class [VARCHAR](MAX) NOT NULL,
    created [VARCHAR](MAX) NOT NULL,
    edited [VARCHAR](MAX) NOT NULL,
    url [VARCHAR](MAX) NOT NULL
);
GO

-- Create a new table called 'starships' in schema 'swapi_dev'
-- Drop the table if it already exists
IF OBJECT_ID('starships', 'U') IS NOT NULL
DROP TABLE starships
GO
-- Create the table in the specified schema
CREATE TABLE starships
(
    id INT NOT NULL PRIMARY KEY, 
    name [VARCHAR](MAX) NOT NULL,
    model [VARCHAR](MAX) NOT NULL,
    manufacturer [VARCHAR](MAX) NOT NULL,
    cost_in_credits [VARCHAR](MAX) NOT NULL,
    length [VARCHAR](MAX) NOT NULL,
    max_atmosphering_speed [VARCHAR](MAX) NOT NULL,
    crew [VARCHAR](MAX) NOT NULL,
    passengers [VARCHAR](MAX) NULL,
    cargo_capacity [VARCHAR](MAX) NOT NULL,
    consumables [VARCHAR](MAX) NOT NULL,
    hyperdrive_rating [VARCHAR](MAX) NOT NULL,
    MGLT [VARCHAR](MAX) NOT NULL,
    starship_class [VARCHAR](MAX) NOT NULL,
    created [VARCHAR](MAX) NOT NULL,
    edited [VARCHAR](MAX) NOT NULL,
    url [VARCHAR](MAX) NOT NULL
);
GO

-- Create a new table called 'films_people' in schema 'swapi_dev'
-- Drop the table if it already exists
IF OBJECT_ID('films_people', 'U') IS NOT NULL
DROP TABLE films_people
GO
-- Create the table in the specified schema
CREATE TABLE films_people
(
    film_id INT NOT NULL,
    person_id INT NOT NULL,
    PRIMARY KEY (film_id, person_id),
    FOREIGN KEY (film_id) REFERENCES films(id),
    FOREIGN KEY (person_id) REFERENCES people(id)
);
GO

-- Create a new table called 'films_planets' in schema 'swapi_dev'
-- Drop the table if it already exists
IF OBJECT_ID('films_planets', 'U') IS NOT NULL
DROP TABLE films_planets
GO
-- Create the table in the specified schema
CREATE TABLE films_planets
(
    film_id INT NOT NULL,
    planet_id INT NOT NULL,
    PRIMARY KEY (film_id, planet_id),
    FOREIGN KEY (film_id) REFERENCES films(id),
    FOREIGN KEY (planet_id) REFERENCES planets(id)
);
GO

-- Create a new table called 'films_starships' in schema 'swapi_dev'
-- Drop the table if it already exists
IF OBJECT_ID('films_starships', 'U') IS NOT NULL
DROP TABLE films_starships
GO
-- Create the table in the specified schema
CREATE TABLE films_starships
(
    film_id INT NOT NULL,
    starship_id INT NOT NULL,
    PRIMARY KEY (film_id, starship_id),
    FOREIGN KEY (film_id) REFERENCES films(id),
    FOREIGN KEY (starship_id) REFERENCES starships(id)
);
GO

-- Create a new table called 'films_vehicles' in schema 'swapi_dev'
-- Drop the table if it already exists
IF OBJECT_ID('films_vehicles', 'U') IS NOT NULL
DROP TABLE films_vehicles
GO
-- Create the table in the specified schema
CREATE TABLE films_vehicles
(
    film_id INT NOT NULL,
    vehicle_id INT NOT NULL,
    PRIMARY KEY (film_id, vehicle_id),
    FOREIGN KEY (film_id) REFERENCES films(id),
    FOREIGN KEY (vehicle_id) REFERENCES vehicles(id)
);
GO

-- Create a new table called 'films_species' in schema 'swapi_dev'
-- Drop the table if it already exists
IF OBJECT_ID('films_species', 'U') IS NOT NULL
DROP TABLE films_species
GO
-- Create the table in the specified schema
CREATE TABLE films_species
(
    film_id INT NOT NULL,
    specie_id INT NOT NULL,
    PRIMARY KEY (film_id, specie_id),
    FOREIGN KEY (film_id) REFERENCES films(id),
    FOREIGN KEY (specie_id) REFERENCES species(id)
);
GO

-- Create a new table called 'planets_people' in schema 'swapi_dev'
-- Drop the table if it already exists
IF OBJECT_ID('planets_people', 'U') IS NOT NULL
DROP TABLE planets_people
GO
-- Create the table in the specified schema
CREATE TABLE planets_people
(
    planet_id INT NOT NULL,
    person_id INT NOT NULL,
    PRIMARY KEY (planet_id, person_id),
    FOREIGN KEY (planet_id) REFERENCES planets(id),
    FOREIGN KEY (person_id) REFERENCES people(id)
);
GO

-- Create a new table called 'species_people' in schema 'swapi_dev'
-- Drop the table if it already exists
IF OBJECT_ID('species_people', 'U') IS NOT NULL
DROP TABLE species_people
GO
-- Create the table in the specified schema
CREATE TABLE species_people
(
    specie_id INT NOT NULL,
    person_id INT NOT NULL,
    PRIMARY KEY (specie_id, person_id),
    FOREIGN KEY (specie_id) REFERENCES species(id),
    FOREIGN KEY (person_id) REFERENCES people(id)
);
GO

-- Create a new table called 'people_vehicles' in schema 'swapi_dev'
-- Drop the table if it already exists
IF OBJECT_ID('people_vehicles', 'U') IS NOT NULL
DROP TABLE people_vehicles
GO
-- Create the table in the specified schema
CREATE TABLE people_vehicles
(
    person_id INT NOT NULL,
    vehicle_id INT NOT NULL,
    PRIMARY KEY (person_id, vehicle_id),
    FOREIGN KEY (person_id) REFERENCES people(id),
    FOREIGN KEY (vehicle_id) REFERENCES vehicles(id)
);
GO

-- Create a new table called 'people_starships' in schema 'swapi_dev'
-- Drop the table if it already exists
IF OBJECT_ID('people_starships', 'U') IS NOT NULL
DROP TABLE people_starships
GO
-- Create the table in the specified schema
CREATE TABLE people_starships
(
    person_id INT NOT NULL,
    starship_id INT NOT NULL,
    PRIMARY KEY (person_id, starship_id),
    FOREIGN KEY (person_id) REFERENCES people(id),
    FOREIGN KEY (starship_id) REFERENCES starships(id)
);
GO

----------------------------------- INSERT DATA IN TABLES -----------------------------------
------------------------------------- Stored Procedures -------------------------------------
-- sp_GetData
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
		SET @result = @statusText;
		RETURN;
	END

	-- PRINT @statusText;
	-- PRINT @countChs;

	SET @result = @resJSON;
	RETURN;

END
GO

-- sp_GetNumUrl
CREATE PROCEDURE sp_GetNumUrl @url VARCHAR(MAX), @id INT OUT
AS
BEGIN

    IF (@url LIKE '%[a-zA-Z]/[0-9]%')
    BEGIN

        -- PRINT (SUBSTRING(@url, PATINDEX('%[0-9]%', @url), LEN(@url)));
        DECLARE @pat VARCHAR(MAX) = (SUBSTRING(@url, PATINDEX('%[0-9]%', @url), LEN(@url)));
        -- DECLARE @num INT;

        IF (@pat LIKE '%/')
        BEGIN
            SET @id = CAST((REPLACE(@pat, '/', '')) AS INT);
            RETURN;
        END

        SET @id = CAST(@pat AS INT);
        -- PRINT @num;

        RETURN;

    END

    RETURN;

END
GO


-- sp_films_insert
CREATE PROCEDURE sp_films_insert 
AS
BEGIN

    DECLARE @url VARCHAR(MAX) = 'https://swapi.dev/api/films/';
    DECLARE @count INT = 0;
    DECLARE @countFilms INT = 6;
    DECLARE @responseJSON VARCHAR(MAX);

    WHILE (SELECT COUNT(*) FROM dbo.films) < @countFilms
    BEGIN

		SET @count = @count + 1;

        DECLARE @newUrl VARCHAR(MAX) = @url + CAST(@count AS VARCHAR);
        EXEC sp_GetData @newUrl, @responseJSON OUT;

        IF (@responseJSON <> 'NOT FOUND')
		BEGIN

            DECLARE @title VARCHAR(MAX) = (SELECT [value] FROM OPENJSON(@responseJSON) WHERE [key] = 'title');
            DECLARE @episode_id INT = (SELECT [value] FROM OPENJSON(@responseJSON) WHERE [key] = 'episode_id');
            DECLARE @opening_crawl VARCHAR(MAX) = (SELECT [value] FROM OPENJSON(@responseJSON) WHERE [key] = 'opening_crawl');
            DECLARE @director VARCHAR(MAX) = (SELECT [value] FROM OPENJSON(@responseJSON) WHERE [key] = 'director');
            DECLARE @producer VARCHAR(MAX) = (SELECT [value] FROM OPENJSON(@responseJSON) WHERE [key] = 'producer');
            DECLARE @release_date VARCHAR(MAX) = (SELECT [value] FROM OPENJSON(@responseJSON) WHERE [key] = 'release_date');
            DECLARE @created VARCHAR(MAX) = (SELECT [value] FROM OPENJSON(@responseJSON) WHERE [key] = 'created');
            DECLARE @edited VARCHAR(MAX) = (SELECT [value] FROM OPENJSON(@responseJSON) WHERE [key] = 'edited');
            DECLARE @urlFromJSON VARCHAR(MAX) = (SELECT [value] FROM OPENJSON(@responseJSON) WHERE [key] = 'url');
            DECLARE @id INT;
            EXEC sp_GetNumUrl @urlFromJSON, @id OUT;

            INSERT INTO 
                dbo.films 
                (id,
                title, 
                episode_id, 
                opening_crawl, 
                director, 
                producer, 
                release_date, 
                created, 
                edited, 
                url)
            VALUES
                (@id,
                @title,
                @episode_id,
                @opening_crawl,
                @director,
                @producer,
                @release_date,
                @created,
                @edited,
                @urlFromJSON);
            
        END

    END

    RETURN;
    
END
GO

-- sp_people_insert
CREATE PROCEDURE sp_people_insert 
AS
BEGIN

    DECLARE @url VARCHAR(MAX) = 'https://swapi.dev/api/people/';
    DECLARE @count INT = 0;
    DECLARE @countPeople INT;
    EXEC sp_GetData @url, @countPeople OUT;

    DECLARE @responseJSON VARCHAR(MAX);

    WHILE (SELECT COUNT(*) FROM dbo.people) < @countPeople
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
GO

-- sp_planets_insert
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
                    
                    -- PRINT '@planets_people ' + CAST(@id AS VARCHAR(MAX)) + ' num: ' + CAST(@person_id AS VARCHAR(MAX));

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
                    
                    -- PRINT '@films_planets ' + CAST(@id AS VARCHAR(MAX)) + ' num: ' + CAST(@film_id AS VARCHAR(MAX));

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
GO

-- sp_species_insert
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
GO

-- sp_starships_insert
CREATE PROCEDURE sp_starships_insert 
AS
BEGIN

    DECLARE @url VARCHAR(MAX) = 'https://swapi.dev/api/starships/';
    DECLARE @count INT = 0;
    DECLARE @countStarships INT;
    EXEC sp_GetData @url, @countStarships OUTPUT;

    DECLARE @responseJSON VARCHAR(MAX);

    WHILE (SELECT COUNT(*) FROM dbo.starships) < @countStarships
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
            DECLARE @people VARCHAR(MAX) = (SELECT [value] FROM OPENJSON(@responseJSON) WHERE [key] = 'pilots');

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
                        (@person_id,
                        @id);

                    SET @count2 = @count2 + 1;

                END
            
            END

            -- Films_Starships
            DECLARE @films VARCHAR(MAX) = (SELECT [value] FROM OPENJSON(@responseJSON) WHERE [key] = 'films');

            IF ((SELECT COUNT(*) FROM OPENJSON(@films)) > 0)
            BEGIN

                DECLARE @count3 INT = 0;

                WHILE @count3 < (SELECT COUNT(*) FROM OPENJSON(@films))
                BEGIN

                    DECLARE @filmUrl VARCHAR(MAX) = (SELECT [value] FROM OPENJSON(@films) WHERE [key] = @count3);
                    DECLARE @film_id INT;
                    EXEC sp_GetNumUrl @filmUrl, @film_id OUT;      
                    
                    -- PRINT '@films_starships ' + CAST(@film_id AS VARCHAR(MAX)) + ' num: ' + CAST(@id AS VARCHAR(MAX));

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
GO

-- sp_vehicles_insert
CREATE PROCEDURE sp_vehicles_insert 
AS
BEGIN

    DECLARE @url VARCHAR(MAX) = 'https://swapi.dev/api/vehicles/';
    DECLARE @count INT = 0;
    DECLARE @countVehicles INT;
    EXEC sp_GetData @url, @countVehicles OUTPUT;

    DECLARE @responseJSON VARCHAR(MAX);

    WHILE (SELECT COUNT(*) FROM dbo.vehicles) < @countVehicles
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
            DECLARE @vehicle_class VARCHAR(MAX) = (SELECT [value] FROM OPENJSON(@responseJSON) WHERE [key] = 'vehicle_class');
            DECLARE @created VARCHAR(MAX) = (SELECT [value] FROM OPENJSON(@responseJSON) WHERE [key] = 'created');
            DECLARE @edited VARCHAR(MAX) = (SELECT [value] FROM OPENJSON(@responseJSON) WHERE [key] = 'edited');
            DECLARE @urlFromJSON VARCHAR(MAX) = (SELECT [value] FROM OPENJSON(@responseJSON) WHERE [key] = 'url');
            DECLARE @id INT;
            EXEC sp_GetNumUrl @urlFromJSON, @id OUT;

            INSERT INTO 
                dbo.vehicles
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
                vehicle_class,
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
                @vehicle_class,
                @created,
                @edited,
                @urlFromJSON);

            -- People_Vehicles
            DECLARE @pilots VARCHAR(MAX) = (SELECT [value] FROM OPENJSON(@responseJSON) WHERE [key] = 'pilots');

            IF ((SELECT COUNT(*) FROM OPENJSON(@pilots)) > 0)
            BEGIN

                DECLARE @count2 INT = 0;

                WHILE @count2 < (SELECT COUNT(*) FROM OPENJSON(@pilots))
                BEGIN

                    DECLARE @pilotsUrl VARCHAR(MAX) = (SELECT [value] FROM OPENJSON(@pilots) WHERE [key] = @count2);
                    DECLARE @person_id INT;
                    EXEC sp_GetNumUrl @pilotsUrl, @person_id OUT;      
                    
                    -- PRINT '@people_vehicles ' + CAST(@id AS VARCHAR(MAX)) + ' num: ' + CAST(@person_id AS VARCHAR(MAX));

                    INSERT INTO 
                        dbo.people_vehicles
                    VALUES
                        (@person_id,
                        @id);

                    SET @count2 = @count2 + 1;

                END
            
            END

            -- Films_Vehicles
            DECLARE @films VARCHAR(MAX) = (SELECT [value] FROM OPENJSON(@responseJSON) WHERE [key] = 'films');

            IF ((SELECT COUNT(*) FROM OPENJSON(@films)) > 0)
            BEGIN

                DECLARE @count3 INT = 0;

                WHILE @count3 < (SELECT COUNT(*) FROM OPENJSON(@films))
                BEGIN

                    DECLARE @filmUrl VARCHAR(MAX) = (SELECT [value] FROM OPENJSON(@films) WHERE [key] = @count3);
                    DECLARE @film_id INT;
                    EXEC sp_GetNumUrl @filmUrl, @film_id OUT;      
                    
                    -- PRINT '@films_vehicles ' + CAST(@id AS VARCHAR(MAX)) + ' num: ' + CAST(@film_id AS VARCHAR(MAX));

                    INSERT INTO 
                        dbo.films_vehicles
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
GO

----------------------------------- EXEC Stored Procedures -----------------------------------
EXEC sp_films_insert;
GO

EXEC sp_people_insert;
GO

EXEC sp_planets_insert;
GO

EXEC sp_species_insert;
GO

EXEC sp_starships_insert;
GO

EXEC sp_vehicles_insert;
GO
