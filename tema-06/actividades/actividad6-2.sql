USE futbol;

-- 1️ Cambiar del Girona
UPDATE equipos 
SET 
    nombre = 'Girona Futbol Club'
WHERE
    id = 2 LIMIT 1;

-- 2️ Actualizar la ciudad del Villareal
UPDATE equipos 
SET 
    ciudad = 'Vila-real'
WHERE
    id = 7 LIMIT 1;

-- 3️ Incrementar aforo de estadios grandes
UPDATE equipos 
SET 
    aforo = aforo + 1000
WHERE
    aforo > 50000;

-- 4️ Cambiar el equipo de un jugador
UPDATE jugadores 
SET 
    equipo_id = 7
WHERE
    id = 17 LIMIT 1;

-- 5️ Corregir fecha de nacimiento
UPDATE jugadores 
SET 
    fecha_nac = '2001-06-05'
WHERE
    id = 13 LIMIT 1;

-- 6️ Ajustar goles de un partido
UPDATE partidos 
SET 
    goles_casa = 2,
    goles_fuera = 1
WHERE
    id = 7 LIMIT 1;

-- 7️ Actualizar observaciones de partidos recientes
UPDATE partidos 
SET 
    observaciones = CONCAT_WS(' ', observaciones, ' (actualizado)')
ORDER BY fecha DESC LIMIT 3;

-- 8 Todos los goles que contienen "penalti" en la descripción se retrasan 1 minuto.
UPDATE goles 
SET 
    minuto = minuto + 1
WHERE
    descripcion LIKE '%penalty%';

-- 9 Cambia todos los goles del partido id=13 para que pertenezcan al jugador Gerard Moreno (id=18), solo los goles del equipo de casa.
UPDATE goles 
SET 
    jugador_id = 18
WHERE
    id = 37 LIMIT 1;

    
-- 10 Suma 1 al minuto de los goles de Iñaki Williams, pero solo los 2 primeros goles, usando ORDER BY y LIMIT.
SELECT 
    *
FROM
    goles
WHERE
    jugador_id = 20;
    
UPDATE goles 
SET 
    minuto = minuto + 1
WHERE
    jugador_id = 20 ORDER BY id ASC LIMIT 2;
    
-- 11 Cambia el estadio de Real Sociedad a "Reale Arena Nuevo".
UPDATE equipos 
SET 
    estadio = 'Reale Arena Nuevo'
WHERE
    id = 9 LIMIT 1;
    
-- 12 Mueve a todos los jugadores de Girona Futbol Club al Athletic Club (id=8).
UPDATE jugadores 
SET 
    equipo_id = 8
WHERE
    equipo_id = 10;
    
SELECT * FROM jugadores WHERE equipo_id = 10;

-- 13 Suma 1 gol al equipo de casa en todos los partidos donde Valencia CF sea local.
UPDATE partidos 
SET 
    goles_casa = goles_casa + 1
WHERE
    equipo_casa_id = 6;
    
-- 14 Resta 2 minutos a todos los goles que tengan un minuto mayor a 80.
UPDATE goles 
SET 
    minuto = minuto - 2
WHERE
    minuto > 80;
    
-- 15 Cambia el nombre de José Luis Gayà a "José Gayà".
UPDATE jugadores 
SET 
    nombre = 'José Gayá'
WHERE
    id = 16;