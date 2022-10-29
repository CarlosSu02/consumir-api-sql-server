
CREATE PROCEDURE sp_planets_insert 
AS
BEGIN

    DECLARE @url VARCHAR(MAX) = 'https://swapi.dev/api/planets/'
    DECLARE @count INT = 0;
    DECLARE @countPlanets INT;
    EXEC sp_GetData @url, @countPlanets OUT;

    DECLARE @responseJSON VARCHAR(MAX);

    WHILE @count < @countPlanets
    BEGIN

		SET @count = @count + 1;

        DECLARE @newUrl VARCHAR(MAX) = @url + CAST(@count AS VARCHAR)
        EXEC sp_GetData @newUrl, @responseJSON OUT;

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
        
    END

    RETURN;
    
END

EXEC sp_planets_insert;
