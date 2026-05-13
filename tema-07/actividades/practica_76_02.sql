-- practica_76_02
-- Raúl Bueno

-- # 1. Crearr la base de datos fmatematicas.
DROP DATABASE IF EXISTS fmatematicas;
CREATE DATABASE IF NOT EXISTS fmatematicas;
USE fmatematicas;
-- # 2. Crear la tabla angulos los valores con máxima precisión
-- id
-- grados
-- radianes
-- seno
-- coseno
-- tangente
CREATE TABLE angulos(
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    grados SMALLINT UNSIGNED, -- [[0, 360]
    radianes DOUBLE(31,30), -- 
    seno DOUBLE(31,30), -- [-1, 1]
    coseno DOUBLE(31,30), -- [-1, 1]
    tangente DOUBLE -- cualquier valor real
);
-- # 3. Insertar en la tabla angulos con valores de 5 ángulos (0 a 360)
-- actualizar solo la columna grados
INSERT INTO angulos (grados) VALUES
(0), (30), (60), (180), (270);
INSERT INTO angulos (grados) VALUES
(15), (45), (90), (300), (360);
-- # 4. Actualizar la columna radianes a partir de la columna grados
-- añadida en el apartado anterior
UPDATE angulos SET radianes = RADIANS(grados);
-- # 5. Actualizar la columna seno, coseno y tangente a partir de la
-- columna radianes actualizada en el apartado anterior
UPDATE angulos SET seno = sin(radianes);
UPDATE angulos SET coseno = cos(radianes);
UPDATE angulos SET tangente = tan(radianes);
-- # 6. Obtener valor entre [1, 10]
SELECT CEILING(RAND()*10);
-- # 7. Obtener valor entre [0, 9]
SELECT FLOOR(RAND()*9);
-- # 8. Obtener valor entre [0, 4]
SELECT FLOOR(RAND()*4);
-- # 9. Obtener valor entre [0, 100000]
SELECT FLOOR(RAND()*100001);