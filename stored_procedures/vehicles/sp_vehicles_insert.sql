
CREATE PROCEDURE sp_vehicles_insert 
AS
BEGIN

    DECLARE @url VARCHAR(MAX) = 'https://swapi.dev/api/vehicles/';
    DECLARE @count INT = 0;
    DECLARE @countVehicles INT = 76

    DECLARE @responseJSON VARCHAR(MAX);

    WHILE @count < @countVehicles
    BEGIN

		SET @count = @count + 1;

        DECLARE @newUrl VARCHAR(MAX) = @url + CAST(@count AS VARCHAR);
        EXEC sp_GetData @newUrl, @responseJSON OUT;

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

    RETURN;
    
END

EXEC sp_vehicles_insert;
