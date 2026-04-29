-- Actividad 5.6
-- ejercicios tablas completas
-- Lenjuaje SQL - DDL

-- uso la base de datos de testeo
USE test;

DROP TABLE IF EXISTS alumnos;
CREATE TABLE IF NOT EXISTS alumnos(
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY NOT NULL,
    nombre VARCHAR(20) NOT NULL,
    apellidos VARCHAR(45) NOT NULL,
    dni CHAR(9) UNIQUE NOT NULL,
    fecha_nac DATE NOT NULL,
    edad TINYINT UNSIGNED NOT NULL,
    poblacion VARCHAR(20) NOT NULL,
    direccion VARCHAR(255) NOT NULL,
    cpostal CHAR(4) NOT NULL,
    provinvcia VARCHAR(20) NOT NULL,
    nacionalidad VARCHAR(20) NOT NULL,
    telefono VARCHAR(20) UNIQUE NOT NULL,
    email VARCHAR(60) UNIQUE NOT NULL
    );
    
    DROP TABLE IF EXISTS articulos;
    CREATE TABLE IF NOT EXISTS articulos (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY NOT NULL,
    descripcion VARCHAR(255) NOT NULL,
    referencia VARCHAR(50) UNIQUE NOT NULL,
    precio_coste DECIMAL(10,2) NOT NULL,
    precio_venta DECIMAL(10,2) NOT NULL,
    descuento TINYINT UNSIGNED NOT NULL,
    imagen VARCHAR(255) NOT NULL,
    categoria VARCHAR(100) NOT NULL,
    stock INT UNSIGNED DEFAULT 0 NOT NULL,
    stock_min INT UNSIGNED DEFAULT 0 NOT NULL,
    stock_max INT UNSIGNED DEFAULT 0 NOT NULL
);

DROP TABLE IF EXISTS registro_llamadas;
CREATE TABLE IF NOT EXISTS registro_llegadas (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY NOT NULL,
    fecha_hora_salida DATETIME NOT NULL,
    fecha_hora_llegada DATETIME NOT NULL,
    tiempo_realizado TIME NOT NULL,
    id_corredor INT UNSIGNED NOT NULL
);