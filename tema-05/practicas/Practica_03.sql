-- Práctica 5.3 - Tipos de Datos Numéricos
-- Tema 5. Lenguaje SQL - DDL
-- Raúl Bueno García

-- borro y creo la base de datos si existe y no existe respecctivamente
DROP DATABASE IF EXISTS tipo_datos;
CREATE DATABASE IF NOT EXISTS tipo_datos;

-- poner base de datos activa tipo_datos
USE tipo_datos;

-- borro y creo la tabla tipo_datos_num
DROP TABLE IF EXISTS tipo_datos_num;
CREATE TABLE IF NOT EXISTS tipo_datos_num (
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    num_camiseta TINYINT UNSIGNED,
    diferencia_goles SMALLINT,
    goles_a_favor SMALLINT UNSIGNED,
    goles_en_contra SMALLINT UNSIGNED,
    num_habitantes INT UNSIGNED,
    humedad FLOAT(3,2) UNSIGNED,
    precipitaciones SMALLINT UNSIGNED,
    temperatura_maxima FLOAT(5,2),
    temperatura_minima FLOAT(5,2),
    velocidad_viento SMALLINT UNSIGNED,
    altura SMALLINT UNSIGNED,
    precio DECIMAL(10,2),
    sueldo DECIMAL(10,2),
    seno FLOAT(30,29),
    coseno FLOAT(30,29),
    tangente SMALLINT UNSIGNED
    )  CHARACTER SET = 'UTF8MB4' COLLATE = 'utf8mb4_general_ci';
    
-- Añadir tres registors válidos a la tabla anterior
INSERT INTO tipo_datos_num VALUES
(
	NULL,
    34,
    -5,
    56,
    45,
    345000,
    0.90,
    300,
    45.56,
    -12.78,
    500,
    10000,
    45.67,
    45000,
    0.5678,
    0.785,
    34
),
(
	NULL,
    65,
    -13,
    78,
    15,
    900000,
    0.37,
    201,
    37.62,
    -17.92,
    120,
    7734,
    12.59,
    67800,
    0.7654,
    0.295,
    74
),
(
	NULL,
    19,
    12,
    14,
    26,
    7890,
    0.71,
    900,
    52.62,
    10.56,
    36,
    2081,
    67.59,
    81000,
    0.2765,
    0.472,
	134
)
;