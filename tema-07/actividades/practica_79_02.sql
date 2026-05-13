-- practica_79_02
-- Raúl Bueno

USE maratoon;

-- 1
/*
-- corredores.csv
-- Generar un csv con las datos de 5 corredores
-- tabla: corredores
-- columnas: nombre, apellidos, ciudad, fechanaciemiento, sexo, club_id
"Carlos";"Lopez Garcia";"Sevilla";"1995-03-12";"H";1
"Ana";"Moreno Ruiz";"Cadiz";"1988-07-25""M";3
"Luis";"Fernandez Soto";"Jerez";"2000-11-05";"H";5
"Marta";"Gil Torres";"Malaga";"1975-01-30";"M";4
"Pablo";"Ramos Diaz";"Granada";"1960-09-18";"H";1
*/

-- 2
LOAD DATA INFILE 'C:/Users/08_1DAW_Alum/Documents/base-datos-2526/tema-07/corredores.csv'
IGNORE INTO TABLE maratoon.corredores FIELDS TERMINATED BY ';'
OPTIONALLY ENCLOSED BY '\"' LINES TERMINATED BY '\n'
IGNORE 4 LINES;

-- 3
UPDATE Corredores 
SET Edad = TIMESTAMPDIFF(YEAR, FechaNacimiento, NOW());

UPDATE corredores SET categoria_id = 
CASE 
	WHEN edad < 12 THEN 1 -- infantil
    WHEN edad < 15 THEN 2 -- junior
    WHEN edad < 18 THEN 3 -- juvenil
    WHEN edad < 30 THEN 4 -- senior a
    WHEN edad < 40 THEN 5 -- senior b
    WHEN edad < 50 THEN 6 -- veterano a
    WHEN edad < 60 THEN 7 -- veterano b
    ELSE 8 -- veterano c
END;

-- 4
/*
-- registros.csv
-- Generar un csv con las datos de los 5 corredores anteriores para la carrera id = 3
-- carrera_id;corredor_id;Salida;Llegada
3;17;2024-05-10 09:00:00;2024-05-10 10:45:00
3;18;2024-05-10 09:00:00;2024-05-10 10:30:00
3;19;2024-05-10 09:00:00;2024-05-10 10:50:00
3;20;2024-05-10 09:00:00;2024-05-10 11:10:00
3;21;2024-05-10 09:00:00;2024-05-10 10:40:00
*/

-- 5
LOAD DATA INFILE 'C:/Users/08_1DAW_Alum/Documents/base-datos-2526/tema-07/registros.csv'
INTO TABLE maratoon.registros
FIELDS TERMINATED BY ';'
ENCLOSED BY '\"'
LINES TERMINATED BY '\n'
IGNORE 3 LINES;

-- 6
UPDATE Registros 
SET TiempoInvertido = TIMEDIFF(Llegada, Salida)
WHERE TiempoInvertido IS NULL;

-- 7 y 9
/*  Hacemos el xml
<clubs>
  <club>
    <NombreCorto>RUN</NombreCorto>
    <Nombre>Runners Sevilla</Nombre>
    <Ciudad>Sevilla</Ciudad>
    <FecFundacion>2000-05-10</FecFundacion>
    <NumSocios>120</NumSocios>
  </club>
  <club>
    <NombreCorto>ATL</NombreCorto>
    <Nombre>Atletismo Cádiz</Nombre>
    <Ciudad>Cádiz</Ciudad>
    <FecFundacion>1995-03-20</FecFundacion>
    <NumSocios>90</NumSocios>
  </club>
</clubs>
*/

LOAD XML INFILE 'C:/Users/08_1DAW_Alum/Documents/base-datos-2526/tema-07/clubs.xml'
INTO TABLE maratoon.clubs
ROWS IDENTIFIED BY '<club>';

-- 8 y 10
/* Creamos el xml
<carreras>
  <carrera>
    <Nombre>Carrera Nocturna Sevilla</Nombre>
    <Ciudad>Sevilla</Ciudad>
    <Distancia>10000</Distancia>
    <MesCelebracion>9</MesCelebracion>
  </carrera>
  <carrera>
    <Nombre>Carrera Popular Cádiz</Nombre>
    <Ciudad>Cádiz</Ciudad>
    <Distancia>8000</Distancia>
    <MesCelebracion>7</MesCelebracion>
  </carrera>
</carreras>
*/

LOAD XML INFILE '/ruta/carreras.xml'
INTO TABLE maratoon.carreras
ROWS IDENTIFIED BY '<carrera>';

-- 11
SELECT * 
INTO OUTFILE 'C:/Users/08_1DAW_Alum/Documents/base-datos-2526/tema-07/copiaCorredores.csv'
FIELDS TERMINATED BY ';'
ENCLOSED BY '\"'
LINES TERMINATED BY '\n'
FROM Corredores;

-- 12
SELECT * 
INTO OUTFILE 'C:/Users/08_1DAW_Alum/Documents/base-datos-2526/tema-07/copiaRegistros.csv'
FIELDS TERMINATED BY ';'
ENCLOSED BY '\"'
LINES TERMINATED BY '\n'
FROM Registros;

-- 13
SELECT 
    corredores.id AS IdCorredor,
    corredores.Apellidos,
    corredores.Nombre,
    clubs.Nombre AS Club,
    categorias.Nombre AS Categoria,
    registros.TiempoInvertido
INTO OUTFILE 'C:/Users/08_1DAW_Alum/Documents/base-datos-2526/tema-07/clasificacion_carrera1.csv'
FIELDS TERMINATED BY ';'
ENCLOSED BY '\"'
LINES TERMINATED BY '\n'
FROM registros
INNER JOIN corredores ON registros.corredor_id = corredores.id
LEFT JOIN clubs ON corredores.club_id = clubs.id
LEFT JOIN categorias ON corredores.categoria_id = categorias.id
WHERE registros.carrera_id = 1
ORDER BY registros.TiempoInvertido;

-- 10 (comandos consola)

-- Copia completa
-- mysqldump -u root -p maratoon > maratoon.sql

-- Copia solo tablas carreras y registros
-- mysqldump -u root -p maratoon carreras registros > parcial.sql

-- Backup en XML
-- mysqldump -u root -p --xml maratoon > maratoon.xml

-- Backup solo datos en XML
-- mysqldump -u root -p --no-create-info --xml maratoon > maratoondatos.xml