
# Tarea Consumir API SQL Server - Bases de Datos II

> Ejecutar el script [```AllQuerys.sql```](https://github.com/CarlosSu02/consumir-api-sql-server/blob/main/AllQuerys.sql) para crear la base de datos, crear y ejecutar los procedimientos almacenados de una sola vez.

<br>

Alumnos:
- Cristian Cordova Orellana
- Lázaro Antonio Vásquez Rivera
- Carlos Josue Su Pleitez

<br>

Este repositorio contiene lo siguiente:
- Habilitación de [```Ole Automation Procedures```](https://github.com/CarlosSu02/consumir-api-sql-server/blob/main/schema_definition/OleAutomationProcedures.sql)
- Creación de la base de datos [```swapi_dev```](https://github.com/CarlosSu02/consumir-api-sql-server/blob/main/schema_definition/swapi_dev.sql)
- Los siguientes procedimientos almacenados:
    - [```sp_GetData```](https://github.com/CarlosSu02/consumir-api-sql-server/blob/main/stored_procedures/sp_GetData.sql) para traer los datos.
    - [```sp_GetNumUrl```](https://github.com/CarlosSu02/consumir-api-sql-server/blob/main/stored_procedures/utils/sp_GetNumUrl.sql) para sacar el número (id) de la url.
    - [```sp_films_insert```](https://github.com/CarlosSu02/consumir-api-sql-server/blob/main/stored_procedures/films/sp_films_insert.sql) insertar datos en la tabla films.
    - [```sp_people_insert```](https://github.com/CarlosSu02/consumir-api-sql-server/blob/main/stored_procedures/people/sp_people_insert.sql) insertar datos en la tablas people y films_people.
    - [```sp_planets_insert```](https://github.com/CarlosSu02/consumir-api-sql-server/blob/main/stored_procedures/planets/sp_planets_insert.sql) insertar datos en la tablas plantes, planets_people y films_planets.
    - [```sp_species_insert```](https://github.com/CarlosSu02/consumir-api-sql-server/blob/main/stored_procedures/planets/sp_species_insert.sql) insertar datos en la tablas species, species_people y films_species.
    - [```sp_vehicles_insert```](https://github.com/CarlosSu02/consumir-api-sql-server/blob/main/stored_procedures/planets/sp_vehicles_insert.sql) insertar datos en la tablas vehicles, people_vehicles y films_vehicles.
    - [```sp_starships_insert```](https://github.com/CarlosSu02/consumir-api-sql-server/blob/main/stored_procedures/planets/sp_starships_insert.sql) insertar datos en la tablas starships, people_starships y films_starships.
-   El archivo [```AllQuerys```](https://github.com/CarlosSu02/consumir-api-sql-server/blob/main/AllQuerys.sql) contiene todo lo antes descrito.
