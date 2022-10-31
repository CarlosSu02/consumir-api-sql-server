
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
