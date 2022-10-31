
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
        
    END

    RETURN;
    
END

EXEC sp_people_insert;
