
CREATE PROCEDURE sp_films_insert 
AS
BEGIN

    DECLARE @url VARCHAR(MAX) = 'https://swapi.dev/api/films/'
    DECLARE @count INT = 0;
    DECLARE @coutnFilms INT = 6;
    DECLARE @responseJSON VARCHAR(MAX);

    WHILE @count < @coutnFilms
    BEGIN

		SET @count = @count + 1;

        DECLARE @newUrl VARCHAR(MAX) = @url + CAST(@count AS VARCHAR)
        EXEC sp_GetData @newUrl, @responseJSON OUT;

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

    RETURN;
    
END

EXEC sp_films_insert;