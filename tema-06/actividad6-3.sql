USE Futbol;

-- 1 Eliminar jugador (Aleix García)
SELECT 
    *
FROM
    jugadores
WHERE
    id = 25;

DELETE FROM jugadores 
WHERE
    id = 25;


-- 2️ Borrar goles del partido id = 7
SELECT 
    *
FROM
    goles
WHERE
    partido_id = 7;

DELETE FROM goles 
WHERE
    partido_id = 7;


-- 3 Eliminar goles marcados después del minuto 85
SELECT 
    *
FROM
    goles
WHERE
    minuto > 85;

DELETE FROM goles 
WHERE
    minuto > 85;


-- 4 Eliminar partidos sin goles
SELECT 
    *
FROM
    partidos
WHERE
    goles_casa = 0 AND goles_fuera = 0;

DELETE FROM partidos 
WHERE
    goles_casa = 0 AND goles_fuera = 0;


-- 5 Borrar jugadores sin equipo
SELECT 
    *
FROM
    jugadores
WHERE
    equipo_id IS NULL;

DELETE FROM jugadores 
WHERE
    equipo_id IS NULL;


-- 6 Eliminar goles marcados por Gerard Moreno
SELECT 
    g.*
FROM
    goles g
        JOIN
    jugadores j ON g.jugador_id = j.id
WHERE
    j.id = 18;

DELETE g FROM goles g
        JOIN
    jugadores j ON g.jugador_id = j.id 
WHERE
    j.id = 18;


--  7 Eliminar los 2 últimos goles
SELECT 
    *
FROM
    goles
ORDER BY id DESC
LIMIT 2;

DELETE FROM goles ORDER BY id DESC LIMIT 2;


-- 8 Borrar partidos disputados antes del 1 de abril de 2024
SELECT 
    *
FROM
    partidos
WHERE
    fecha < '2024-04-01';

SELECT 
    *
FROM
    goles
WHERE
    partido_id IN (SELECT 
            id
        FROM
            partidos
        WHERE
            fecha < '2024-04-01');

DELETE FROM goles 
WHERE
    partido_id IN (SELECT 
        id
    FROM
        partidos
    
    WHERE
        fecha < '2024-04-01');

DELETE FROM partidos 
WHERE
    fecha < '2024-04-01';


-- 9 Eliminar goles del partido id = 11 antes del minuto 30
SELECT 
    *
FROM
    goles
WHERE
    partido_id = 11 AND minuto < 30;

DELETE FROM goles 
WHERE
    partido_id = 11 AND minuto < 30;


-- 10 Eliminar el equipo "Girona Futbol Club" si no tiene jugadores
SELECT 
    *
FROM
    equipos
WHERE
    id = 10;

SELECT 
    *
FROM
    jugadores
WHERE
    equipo_id = (SELECT 
            id
        FROM
            equipos
        WHERE
            id = 10);

DELETE FROM equipos 
WHERE
    id = 10
    AND id NOT IN (SELECT DISTINCT
        equipo_id
    FROM
        jugadores
    
    WHERE
        equipo_id IS NOT NULL);
