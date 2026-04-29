-- Actividad: 5.12
-- Tema: Lenguaje SQL - DDL
-- Módulo: Base de Datos
-- Curso: 25/26
-- Nombre: Raúl Bueno

-- Crear la base de datos taller
DROP DATABASE IF EXISTS taller;
CREATE DATABASE IF NOT EXISTS taller;

-- Activar la base de datos taller
USE taller;

-- Tabla maquinas
DROP TABLE IF EXISTS maquinas;
CREATE TABLE IF NOT EXISTS maquinas(
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(20) NOT NULL,
    fecha_compra DATE NOT NULL,
    valor DECIMAL(10,2) NOT NULL
);

-- Tabla partes_produccion
DROP TABLE IF EXISTS partes_produccion;
CREATE TABLE IF NOT EXISTS partes_produccion(
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    num_parte INT UNSIGNED UNIQUE NOT NULL,
    fecha_emision DATE NOT NULL,
    fecha_final DATE NOT NULL,
    coste_total DECIMAL(10,2) NOT NULL
);

-- Tabla articulos
DROP TABLE IF EXISTS articulos;
CREATE TABLE IF NOT EXISTS articulos(
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	nombre VARCHAR(255) NOT NULL,
    precio DECIMAL(10,2) NOT NULL,
    modelo VARCHAR(20) NOT NULL,
    coste DECIMAL(10,2) NOT NULL
    
);

-- Tabla empleados
DROP TABLE IF EXISTS empleados;
CREATE TABLE IF NOT EXISTS empleados(
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(20) NOT NULL,
    apellidos VARCHAR(40) NOT NULL,
    dni CHAR(9) UNIQUE NOT NULL,
    taller_id INT UNSIGNED
    -- Dejo establecer la restricción FOREIGN KEY
    -- Se hará una vez definida la tabla talleres
);

-- Tabla talleres
DROP TABLE IF EXISTS talleres;
CREATE TABLE IF NOT EXISTS talleres(
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	funcion VARCHAR(30) NOT NULL,
    nombre VARCHAR(30) NOT NULL,
    jefe_id INT UNSIGNED,
    FOREIGN KEY(jefe_id) REFERENCES empleados (id)
	ON DELETE RESTRICT ON UPDATE RESTRICT
);

-- Modifico la tabla empleados
-- Asigno la restriccion foreign key pendiente a taller_id
ALTER TABLE empleados
ADD CONSTRAINT fk_empleados_taller_id 
foreign key(taller_id)  REFERENCES talleres (id)
ON DELETE RESTRICT ON UPDATE RESTRICT;

-- Tabla maquina_utiliza_taller
DROP TABLE IF EXISTS maquina_utiliza_taller;
CREATE TABLE IF NOT EXISTS maquina_utiliza_taller(
	taller_id INT UNSIGNED NOT NULL,
    maquina_id INT UNSIGNED NOT NULL,
    inicio DATETIME NOT NULL,
    fin DATETIME,
    tiempo DATETIME,
    primary key(taller_id, maquina_id),
    FOREIGN KEY(taller_id) REFERENCES talleres (id) 
    ON DELETE RESTRICT ON UPDATE RESTRICT,
    FOREIGN KEY(maquina_id) REFERENCES maquinas (id) 
    ON DELETE RESTRICT ON UPDATE RESTRICT
);